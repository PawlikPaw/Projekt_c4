using System;
using System.Text.RegularExpressions;
using Microsoft.Maui.Controls;
using Projekt_c4.Models;
using Plugin.Fingerprint;
using Plugin.Fingerprint.Abstractions;

namespace Projekt_c4.Views
{
    public partial class MainPage : ContentPage
    {
        public MainPage()
        {
            InitializeComponent();
            BindingContext = ViewModels.MainViewModel.Instance;
            CheckLoginState();
        }

        protected override void OnAppearing()
        {
            base.OnAppearing();
            // Sprawdzenie stanu logowania za każdym razem gdy wchodzimy na stronę (wymusza wylogowanie z poziomu ustawień)
            CheckLoginState();
        }

        private void CheckLoginState()
        {
            int savedUserId = Microsoft.Maui.Storage.Preferences.Default.Get("CurrentUserId", 0);
            if (savedUserId != 0)
            {
                LoginView.IsVisible = false;
                ProfileView.IsVisible = true;
            }
            else
            {
                LoginView.IsVisible = true;
                ProfileView.IsVisible = false;
            }
        }

        private void OnEntryFocused(object sender, FocusEventArgs e)
        {
            if (sender is Entry entry && entry.Parent is Border border)
            {
                border.Stroke = Color.FromArgb("#00E676");
            }
        }

        private void OnEntryUnfocused(object sender, FocusEventArgs e)
        {
            if (sender is Entry entry && entry.Parent is Border border)
            {
                border.Stroke = Colors.Transparent;
            }
        }

        private async void OnLoginClicked(object sender, EventArgs e)
        {
            string email = EmailEntry.Text?.Trim() ?? "";
            string password = PasswordEntry.Text ?? "";

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                ErrorLabel.Text = "Wprowadź email i hasło.";
                ErrorLabel.IsVisible = true;
                return;
            }

            // Próba zalogowania i znalezienia gościa przez internet z chmury
            var cloudUser = await App.FirebaseCloud.LoginUserAsync(email, password);
            User? user = cloudUser;

            if (user != null)
            {
                // Konto istnieje w chmurze! Sprawdzamy czy mamy je już u nas, jeśli to np. świeży telefon
                var localCheck = await App.Database.GetUserByIdAsync(user.Id);
                if (localCheck == null)
                    await App.Database.SaveUserAsync(user);
                else
                {
                    // Uaktualniamy lokalne dane (np. ktoś zmienił awatar na innym urządzeniu)
                    localCheck.FirstName = user.FirstName;
                    localCheck.LastName = user.LastName;
                    localCheck.ProfileImagePath = user.ProfileImagePath;
                    await App.Database.SaveUserAsync(localCheck);
                }
            }
            else
            {
                // Jak nie ma neta albo usterka - polegamy w 100% na starym dobrym, zapisanym offline SQLite!
                user = await App.Database.GetUserAsync(email, password);
            }

            if (user != null)
            {
                if (ViewModels.MainViewModel.Instance != null)
                {
                    if (!string.IsNullOrEmpty(user.FirstName))
                        ViewModels.MainViewModel.Instance.CurrentUserName = user.FirstName;

                    ViewModels.MainViewModel.Instance.CurrentUserId = user.Id;

                    // Zapisujemy sesję do stałej pamięci telefonu by przetrwała wyłączenie aplikacji
                    Microsoft.Maui.Storage.Preferences.Default.Set("CurrentUserId", user.Id);
                    Microsoft.Maui.Storage.Preferences.Default.Set("CurrentUserName", user.FirstName);

                    await ViewModels.MainViewModel.Instance.LoadWorkoutsAsync();
                }

                ErrorLabel.IsVisible = false;
                LoginView.IsVisible = false;
                ProfileView.IsVisible = true;
            }
            else
            {
                ErrorLabel.Text = "Nieprawidłowy email lub hasło.";
                ErrorLabel.TextColor = Colors.Red;
                ErrorLabel.IsVisible = true;
            }
        }

        private void OnShowRegisterClicked(object sender, EventArgs e)
        {
            LoginView.IsVisible = false;
            RegisterView.IsVisible = true;
        }

        private async void OnSettingsTapped(object sender, EventArgs e)
        {
            await Navigation.PushModalAsync(new SettingsPage());
        }

        private void OnShowLoginClicked(object sender, EventArgs e)
        {
            RegisterView.IsVisible = false;
            LoginView.IsVisible = true;
        }

        private void OnLogoutClicked(object sender, EventArgs e)
        {
            // Resetujemy formularze i chowamy profil
            EmailEntry.Text = string.Empty;
            PasswordEntry.Text = string.Empty;
            ProfileView.IsVisible = false;
            LoginView.IsVisible = true;

            // Wycieramy historię z zapisanej pamięci i sesji
            Microsoft.Maui.Storage.Preferences.Default.Remove("CurrentUserId");
            Microsoft.Maui.Storage.Preferences.Default.Remove("CurrentUserName");

            if (ViewModels.MainViewModel.Instance != null)
            {
                ViewModels.MainViewModel.Instance.CurrentUserName = "Biegaczu";
                ViewModels.MainViewModel.Instance.CurrentUserId = 0;
                ViewModels.MainViewModel.Instance.Workouts.Clear();
            }
        }

        private async void OnBiometricLoginClicked(object sender, EventArgs e)
        {
            // Optyczna zmiana na zielony kolor (odpowiednik pseudo-pressed)
            BiometricIcon.Source = "biometricactive.png";

            try
            {
                var isAvailable = await CrossFingerprint.Current.IsAvailableAsync(false);
                if (!isAvailable)
                {
                    ErrorLabel.Text = "Logowanie biometryczne nie jest dostępne na tym urządzeniu.";
                    ErrorLabel.IsVisible = true;
                    return;
                }

                var savedEmail = Microsoft.Maui.Storage.Preferences.Default.Get("BiometricUserEmail", "");
                var savedPassword = Microsoft.Maui.Storage.Preferences.Default.Get("BiometricUserPassword", "");

                if (string.IsNullOrEmpty(savedEmail) || string.IsNullOrEmpty(savedPassword))
                {
                    ErrorLabel.Text = "Brak przypisanego odcisku. Zaloguj się tradycyjnie lub włącz opcję przy rejestracji.";
                    ErrorLabel.IsVisible = true;
                    return;
                }

                var request = new AuthenticationRequestConfiguration("Logowanie", "Przyłóż palec, aby się zalogować.");
                var result = await CrossFingerprint.Current.AuthenticateAsync(request);

                if (result.Authenticated)
                {
                    // Przepisanie z pamięci i ciche wywołanie normalnego kodu sprawdzającego logowanie
                    EmailEntry.Text = savedEmail;
                    PasswordEntry.Text = savedPassword;
                    OnLoginClicked(this, EventArgs.Empty);
                }
                else
                {
                    ErrorLabel.Text = "Nie rozpoznano odcisku palca.";
                    ErrorLabel.IsVisible = true;
                }
            }
            finally
            {
                // Powrót do szarego koloru po wciśnięciu
                BiometricIcon.Source = "biometricinactive.png";
            }
        }

        private async void OnRegisterConfirmClicked(object sender, EventArgs e)
        {
            string firstName = RegFirstNameEntry.Text?.Trim() ?? "";
            string lastName = RegLastNameEntry.Text?.Trim() ?? "";
            string email = RegEmailEntry.Text?.Trim() ?? "";
            string password = RegPasswordEntry.Text ?? "";
            string passwordConfirm = RegPasswordConfirmEntry.Text ?? "";

            // Prosta walidacja pustych pół i formatu @
            if (string.IsNullOrEmpty(firstName) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                RegisterErrorLabel.Text = "Wypełnij wszystkie wymagane pola.";
                RegisterErrorLabel.IsVisible = true;
                return;
            }

            // Poprawiona walidacja używająca wyrażeń regularnych (Regex) do pełnej weryfikacji maila
            var emailPattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
            if (!Regex.IsMatch(email, emailPattern))
            {
                RegisterErrorLabel.Text = "Podaj poprawny adres e-mail (np. adres@gmail.com).";
                RegisterErrorLabel.IsVisible = true;
                return;
            }

            if (password != passwordConfirm)
            {
                RegisterErrorLabel.Text = "Hasła nie są identyczne.";
                RegisterErrorLabel.IsVisible = true;
                return;
            }

            var existingCloudUser = await App.FirebaseCloud.GetUserByEmailAsync(email);
            var existingLocalUser = await App.Database.GetUserByEmailAsync(email);
            if (existingLocalUser != null || existingCloudUser != null)
            {
                RegisterErrorLabel.Text = "Konto z tym adresem już istnieje!";
                RegisterErrorLabel.IsVisible = true;
            }
            else
            {
                var newUser = new User
                {
                    Id = Math.Abs(Guid.NewGuid().GetHashCode()), // Ręcznie generujemy globalne ID dla spójności
                    FirstName = firstName,
                    LastName = lastName,
                    Email = email,
                    PasswordHash = password,
                    UseBiometrics = UseBiometricsCheckbox.IsChecked
                };

                // Zapisujemy od razu w obu miejscach używając tego samego globalnego ID
                await App.Database.SaveUserAsync(newUser);
                _ = App.FirebaseCloud.RegisterUserAsync(newUser);

                // Jeżeli użytkownik zaznaczył chęć logowania palcem
                if (newUser.UseBiometrics)
                {
                    // Weryfikacja biometryczna podczas samej rejestracji!
                    var request = new AuthenticationRequestConfiguration("Rejestracja", "Przyłóż palec, aby powiązać odcisk z nowym kontem.");
                    var result = await CrossFingerprint.Current.AuthenticateAsync(request);

                    if (result.Authenticated)
                    {
                        Microsoft.Maui.Storage.Preferences.Default.Set("BiometricUserEmail", email);
                        Microsoft.Maui.Storage.Preferences.Default.Set("BiometricUserPassword", password);
                    }
                    else
                    {
                        // Jeśli odrzucono lub się nie udało, wracamy do checkboxa na False (odłączono)
                        newUser.UseBiometrics = false;
                        await App.Database.SaveUserAsync(newUser);
                        await DisplayAlert("Uwaga", "Nie udało się przypisać odcisku palca. Konto założono klasycznie.", "OK");
                    }
                }

                RegisterView.IsVisible = false;
                LoginView.IsVisible = true;
                ErrorLabel.TextColor = Colors.Green;
                ErrorLabel.Text = "Zarejestrowano pomyślnie! Zaloguj się.";
                ErrorLabel.IsVisible = true;

                // Resetowanie pól po udanej rejestracji, by nie zostawały tam dane
                RegFirstNameEntry.Text = string.Empty;
                RegLastNameEntry.Text = string.Empty;
                RegEmailEntry.Text = string.Empty;
                RegPasswordEntry.Text = string.Empty;
                RegPasswordConfirmEntry.Text = string.Empty;
                UseBiometricsCheckbox.IsChecked = false;

                // Automatyczne wypełnienie maila w zakładce logowania dla wygody
                EmailEntry.Text = email;
            }
        }
    }
}