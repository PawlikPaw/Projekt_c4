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
                    }
                }
            }

            int stepGoal = Microsoft.Maui.Storage.Preferences.Default.Get("DailyStepGoal", 10000);
            StepGoalEntry.Text = stepGoal.ToString();
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
    }
}
