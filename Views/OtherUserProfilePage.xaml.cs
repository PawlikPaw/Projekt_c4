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

            var workouts = await App.FirebaseCloud.PullWorkoutsAsync(user.Id);

            if (workouts != null && workouts.Any())
            {
                var sortedWorkouts = workouts.OrderByDescending(w => w.Date).ToList();
                WorkoutsCollectionView.ItemsSource = sortedWorkouts;

                int totalSteps = sortedWorkouts.Sum(w => (int)(w.DistanceKm * 1300));
                TotalStepsLabel.Text = totalSteps.ToString("N0");
            }
            else
            {
                WorkoutsCollectionView.ItemsSource = null;
                TotalStepsLabel.Text = "0";
            }
        }

        private async void OnBackTapped(object sender, EventArgs e)
        {
            await Navigation.PopModalAsync();
        }
    }
}
