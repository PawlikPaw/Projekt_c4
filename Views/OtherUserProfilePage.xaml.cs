using System;
using System.Linq;
using Microsoft.Maui.Controls;
using Projekt_c4.Models;

namespace Projekt_c4.Views
{
    public partial class OtherUserProfilePage : ContentPage
    {
        public OtherUserProfilePage(User user)
        {
            InitializeComponent();
            LoadUserData(user);
        }

        private async void LoadUserData(User user)
        {
            UserNameLabel.Text = user.FullName;
            UserEmailLabel.Text = user.Email;

            if (user.HasProfileImage)
            {
                ProfileImage.Source = user.ProfileImagePath;
                ProfileImage.IsVisible = true;
                ProfileEmoji.IsVisible = false;
            }

            // Pobierz historię z bazy lokalnej ORAZ z chmury (aby działało również na testowych profilach offline)
            var cloudWorkouts = await App.FirebaseCloud.PullWorkoutsAsync(user.Id);
            var localWorkouts = await App.Database.GetWorkoutsAsync(user.Id);

            // Połącz trasy unikając duplikatów z Firebase
            var allWorkouts = cloudWorkouts.Concat(localWorkouts)
                .GroupBy(w => new { w.Date, w.DistanceKm })
                .Select(g => g.First())
                .ToList();

            if (allWorkouts != null && allWorkouts.Any())
            {
                var sortedWorkouts = allWorkouts.OrderByDescending(w => w.Date).ToList();
                WorkoutsCollectionView.ItemsSource = sortedWorkouts;

                int totalSteps = sortedWorkouts.Sum(w => (int)(w.DistanceKm * 1300));
                TotalStepsLabel.Text = totalSteps.ToString("N0");
                MotivationalLabel.Text = GetMotivationalMessage(totalSteps);
            }
            else
            {
                WorkoutsCollectionView.ItemsSource = null;
                TotalStepsLabel.Text = "0";
                MotivationalLabel.Text = GetMotivationalMessage(0);
            }
        }

        private string GetMotivationalMessage(int totalSteps)
        {
            if (totalSteps == 0) return "Rozpocznij swoją pierwszą trasę!";
            if (totalSteps < 10000) return "Świetny start! Oby tak dalej.";
            if (totalSteps < 50000) return "Dobra robota! Idziesz jak burza.";
            if (totalSteps < 100000) return "Prawdziwy weteran tras!";
            return "Niesamowite! Jesteś maszyną do biegania!";
        }

        private async void OnBackTapped(object sender, EventArgs e)
        {
            await Navigation.PopModalAsync();
        }
    }
}
