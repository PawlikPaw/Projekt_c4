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

        private async void OnAddWorkoutClicked(object sender, EventArgs e)
        {
            await Navigation.PushAsync(new AddWorkoutPage());
        }

        private async void OnRunningClicked(object sender, EventArgs e)
        {
            await Navigation.PushAsync(new RunningPage());
        }

        private async void OnDatabaseClicked(object sender, EventArgs e)
        {
            await Navigation.PushAsync(new ExercisesDatabasePage());
        }

        private async void OnWorkoutTapped(object sender, EventArgs e)
        {
            // Przejście do widoku szczegółów po kliknięciu w "kafelek" treningu
            await Navigation.PushAsync(new WorkoutDetailsPage());
        }
    }
}