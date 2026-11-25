using System;
using Microsoft.Maui.Controls;
using Projekt_c4.Models;
using Projekt_c4.ViewModels;
using Plugin.Fingerprint;
using Plugin.Fingerprint.Abstractions;

namespace Projekt_c4.Views
{
    public partial class SettingsPage : ContentPage
    {
        private User _currentUser = null!;

        public SettingsPage()
        {
            InitializeComponent();
        }

        protected override async void OnAppearing()
        {
            base.OnAppearing();

            int userId = MainViewModel.Instance.CurrentUserId;
            if (userId > 0)
            {
                _currentUser = await App.Database.GetUserByIdAsync(userId);
                if (_currentUser != null)
                {
                    FirstNameEntry.Text = _currentUser.FirstName;
                    LastNameEntry.Text = _currentUser.LastName;
                    EmailEntry.Text = _currentUser.Email;
                    UseBiometricsCheckbox.IsChecked = _currentUser.UseBiometrics;

                    if (!string.IsNullOrEmpty(_currentUser.ProfileImagePath))
                    {
                        ProfileImage.Source = _currentUser.ProfileImagePath;
                        ProfileImage.IsVisible = true;
                        ProfileEmoji.IsVisible = false;
                        ProfileDarkOverlay.IsVisible = true;
                    }
                }
            }

            int stepGoal = Microsoft.Maui.Storage.Preferences.Default.Get("DailyStepGoal", 10000);
            StepGoalDisplay.Text = stepGoal.ToString("N0");
            StepGoalEntry.Text = stepGoal.ToString();
        }

        private void OnOpenStepGoalOverlayTapped(object sender, EventArgs e)
        {
            StepGoalOverlay.IsVisible = true;
            StepGoalEntry.Focus(); // Automatycznie wysuwa klawiaturę
        }

        private void OnCloseStepGoalOverlayTapped(object sender, EventArgs e)
        {
            StepGoalOverlay.IsVisible = false;
            if (int.TryParse(StepGoalEntry.Text, out int newGoal) && newGoal > 0)
            {
                StepGoalDisplay.Text = newGoal.ToString("N0");
            }
        }

        private async void OnChangeProfilePictureTapped(object sender, EventArgs e)
        {
            try
            {
                var result = await MediaPicker.Default.PickPhotoAsync(new MediaPickerOptions
                {
                    Title = "Wybierz nowe zdjęcie profilowe"
                });

                if (result != null && _currentUser != null)
                {
                    var stream = await result.OpenReadAsync();

                    // Zapisujemy wybraną ścieżkę do bazy użytkownika
                    _currentUser.ProfileImagePath = result.FullPath;
                    await App.Database.SaveUserAsync(_currentUser);

                    // Aktualizacja ViewModelu od razu
                    MainViewModel.Instance.ProfileImagePath = result.FullPath;

                    // Aktualizacja obecnego okna Settings
                    ProfileImage.Source = result.FullPath;
                    ProfileImage.IsVisible = true;
                    ProfileEmoji.IsVisible = false;
                    ProfileDarkOverlay.IsVisible = true;
                }
            }
            catch (Exception)
            {
                await DisplayAlert("Błąd", "Nie udało się otworzyć galerii. Sprawdź uprawnienia.", "OK");
            }
        }

        private async void OnBackTapped(object sender, EventArgs e)
        {
            await Navigation.PopModalAsync();
        }

        private async void OnSaveClicked(object sender, EventArgs e)
        {
            if (_currentUser == null) return;

            // Zapis danych osobowych
            _currentUser.FirstName = FirstNameEntry.Text?.Trim() ?? "";
            _currentUser.LastName = LastNameEntry.Text?.Trim() ?? "";
            _currentUser.Email = EmailEntry.Text?.Trim() ?? "";

            // Zapis hasła
            if (!string.IsNullOrWhiteSpace(PasswordEntry.Text))
            {
                _currentUser.PasswordHash = PasswordEntry.Text;
            }

            // Obsługa biometrii
            if (UseBiometricsCheckbox.IsChecked && !_currentUser.UseBiometrics)
            {
                var request = new AuthenticationRequestConfiguration("Uwierzytelnianie", "Przyłóż palec, aby powiązać odcisk z kontem.");
                var result = await CrossFingerprint.Current.AuthenticateAsync(request);

                if (result.Authenticated)
                {
                    _currentUser.UseBiometrics = true;
                    Microsoft.Maui.Storage.Preferences.Default.Set("BiometricUserEmail", _currentUser.Email);
                    Microsoft.Maui.Storage.Preferences.Default.Set("BiometricUserPassword", _currentUser.PasswordHash);
                }
                else
                {
                    UseBiometricsCheckbox.IsChecked = false;
                    await DisplayAlert("Błąd", "Nie udało się przypisać odcisku palca.", "OK");
                }
            }
            else if (!UseBiometricsCheckbox.IsChecked)
            {
                _currentUser.UseBiometrics = false;
                Microsoft.Maui.Storage.Preferences.Default.Remove("BiometricUserEmail");
                Microsoft.Maui.Storage.Preferences.Default.Remove("BiometricUserPassword");
            }

            await App.Database.SaveUserAsync(_currentUser);

            // Wysyłamy zmianę danych do Chmury (Firebase)
            _ = App.FirebaseCloud.UpdateUserAsync(_currentUser);

            MainViewModel.Instance.CurrentUserName = _currentUser.FirstName;
            Microsoft.Maui.Storage.Preferences.Default.Set("CurrentUserName", _currentUser.FirstName);

            // Zapis celu biegowego
            if (int.TryParse(StepGoalEntry.Text, out int newGoal) && newGoal > 0)
            {
                Microsoft.Maui.Storage.Preferences.Default.Set("DailyStepGoal", newGoal);
            }

            await DisplayAlert("Sukces", "Twoje ustawienia zostały zaktualizowane.", "OK");
            await Navigation.PopModalAsync();
        }

        private void OnDeleteAccountTapped(object sender, EventArgs e)
        {
            DeleteAccountOverlay.IsVisible = true;
            ConfirmDeleteCheckbox.IsChecked = false;
            DeletePasswordEntry.Text = string.Empty;
        }

        private void OnCancelDeleteTapped(object sender, EventArgs e)
        {
            DeleteAccountOverlay.IsVisible = false;
        }

        private async void OnConfirmDeleteTapped(object sender, EventArgs e)
        {
            if (!ConfirmDeleteCheckbox.IsChecked)
            {
                await DisplayAlert("Uwaga", "Musisz potwierdzić, że rozumiesz konsekwencje zaznaczając pole wyboru.", "OK");
                return;
            }

            if (DeletePasswordEntry.Text != _currentUser.PasswordHash)
            {
                await DisplayAlert("Błąd", "Nieprawidłowe hasło. Odmowa dostępu.", "OK");
                return;
            }

            // Usunięcie z bazy lokalnej
            await App.Database.DeleteWorkoutsByUserIdAsync(_currentUser.Id);
            await App.Database.DeleteUserAsync(_currentUser);

            // Usunięcie z bazy Firebase (w tle, bez blokowania GUI)
            _ = App.FirebaseCloud.DeleteUserWorkoutsAsync(_currentUser.Id);
            _ = App.FirebaseCloud.DeleteUserAsync(_currentUser.Id);

            // Całkowite czyszczenie sesji i pamięci telefonu
            Microsoft.Maui.Storage.Preferences.Default.Remove("CurrentUserId");
            Microsoft.Maui.Storage.Preferences.Default.Remove("CurrentUserName");
            Microsoft.Maui.Storage.Preferences.Default.Remove("BiometricUserEmail");
            Microsoft.Maui.Storage.Preferences.Default.Remove("BiometricUserPassword");

            MainViewModel.Instance.CurrentUserName = "Biegaczu";
            MainViewModel.Instance.CurrentUserId = 0;
            MainViewModel.Instance.Workouts.Clear();
            MainViewModel.Instance.TotalSteps = 0;

            await DisplayAlert("Konto usunięte", "Twoje konto oraz wszystkie zapisane trasy zostały bezpowrotnie usunięte.", "OK");

            DeleteAccountOverlay.IsVisible = false;

            // Cofnij do profilu, z którego (dzięki wylogowaniu sesji) natychmiast wyskoczy ekran logowania
            await Navigation.PopModalAsync();
        }
    }
}
