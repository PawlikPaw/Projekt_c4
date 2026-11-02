using System;
using Microsoft.Maui.Controls;

namespace Projekt_c4.Views
{
    public partial class MainPage : ContentPage
    {
        public MainPage()
        {
            InitializeComponent();
        }

        private void OnLoginClicked(object sender, EventArgs e)
        {
            // Po kliknięciu w "Zaloguj" ukrywamy widok logowania i pokazujemy profil!
            LoginView.IsVisible = false;
            ProfileView.IsVisible = true;
        }

        private async void OnAddWorkoutClicked(object sender, EventArgs e)
        {
            await Navigation.PushAsync(new AddWorkoutPage());
        }

        private async void OnWorkoutTapped(object sender, EventArgs e)
        {
            await Navigation.PushAsync(new WorkoutDetailsPage());
        }
    }
}