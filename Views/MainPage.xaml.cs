using System;
using System.Text.RegularExpressions;
using Microsoft.Maui.Controls;
using Projekt_c4.Models;

namespace Projekt_c4.Views
{
    public partial class MainPage : ContentPage
    {
        public MainPage()
        {
            InitializeComponent();
            CheckLoginState();
        }

        private void CheckLoginState()
        {
            // Jeżeli jesteśmy już zalogowani (sesja przetrwała restart), pokazuj od razu profil
            int savedUserId = Microsoft.Maui.Storage.Preferences.Default.Get("CurrentUserId", 0);
            if (savedUserId != 0)
            {
                LoginView.IsVisible = false;
                ProfileView.IsVisible = true;
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

            var user = await App.Database.GetUserAsync(email, password);
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
                ErrorLabel.IsVisible = true;
            }
        }

        private void OnShowRegisterClicked(object sender, EventArgs e)
        {
            LoginView.IsVisible = false;
            RegisterView.IsVisible = true;
        }

        private void OnShowLoginClicked(object sender, EventArgs e)
        {
            RegisterView.IsVisible = false;
            LoginView.IsVisible = true;
        }

        private async void OnEntryFocused(object sender, FocusEventArgs e)
        {
            if (sender is Entry entry && entry.Parent is Frame frame)
            {
                frame.BorderColor = Color.FromArgb("#00E676"); // Neonowy zielony
                // Lekka animacja powiększenia (Scale) i podbicia
                await frame.ScaleTo(1.02, 100, Easing.CubicOut);
            }
        }

        private async void OnEntryUnfocused(object sender, FocusEventArgs e)
        {
            if (sender is Entry entry && entry.Parent is Frame frame)
            {
                frame.BorderColor = Colors.Transparent;
                // Powrót do standardowej wielkości
                await frame.ScaleTo(1.0, 100, Easing.CubicIn);
            }
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

            var existingUser = await App.Database.GetUserByEmailAsync(email);
            if (existingUser != null)
            {
                RegisterErrorLabel.Text = "Konto z tym adresem już istnieje!";
                RegisterErrorLabel.IsVisible = true;
            }
            else
            {
                await App.Database.SaveUserAsync(new User
                {
                    FirstName = firstName,
                    LastName = lastName,
                    Email = email,
                    PasswordHash = password
                });

                RegisterView.IsVisible = false;
                LoginView.IsVisible = true;
                ErrorLabel.TextColor = Colors.Green;
                ErrorLabel.Text = "Zarejestrowano pomyślnie! Zaloguj się.";
                ErrorLabel.IsVisible = true;

                // Automatyczne wypełnienie maila dla wygody
                EmailEntry.Text = email;
            }
        }
    }
}