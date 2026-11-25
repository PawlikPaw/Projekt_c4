using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Maui.Controls;
using Projekt_c4.Models;
using Projekt_c4.ViewModels;

namespace Projekt_c4.Views
{
    public partial class SearchPage : ContentPage
    {
        private List<User> _allUsers = new List<User>();

        public SearchPage()
        {
            InitializeComponent();
            BindingContext = MainViewModel.Instance;
        }

        protected override async void OnAppearing()
        {
            base.OnAppearing();
            if (MainViewModel.Instance.IsLoggedIn)
            {
                // Pobierz użytkowników z Firebase oraz z lokalnej bazy (żeby działało nawet gdy FirebaseURL 404 testowo)
                var cloudUsers = await App.FirebaseCloud.GetAllUsersAsync();
                var localUsers = await App.Database.GetAllUsersAsync();

                // Łączymy wyniki aby upewnić się, że widzimy też ludzi utworzonych offline
                var mergedUsers = cloudUsers.Concat(localUsers)
                    .GroupBy(u => u.Email)
                    .Select(g => g.First()) // bierzemy unikalnych po e-mailu
                    .ToList();

                _allUsers = mergedUsers;

                // Odfiltrowujemy siebie samego
                _allUsers = _allUsers.Where(u => u.Id != MainViewModel.Instance.CurrentUserId).ToList();

                FilterUsers(UserSearchBar.Text);
            }
        }

        private void OnSearchBarTextChanged(object sender, TextChangedEventArgs e)
        {
            FilterUsers(e.NewTextValue);
        }

        private void OnSearchButtonPressed(object sender, EventArgs e)
        {
            FilterUsers(UserSearchBar.Text);
        }

        private void FilterUsers(string query)
        {
            if (string.IsNullOrWhiteSpace(query))
            {
                UsersCollectionView.ItemsSource = _allUsers;
            }
            else
            {
                var lowerQuery = query.ToLowerInvariant();
                var filtered = _allUsers.Where(u =>
                    (u.FirstName?.ToLowerInvariant().Contains(lowerQuery) == true) ||
                    (u.LastName?.ToLowerInvariant().Contains(lowerQuery) == true) ||
                    (u.Email?.ToLowerInvariant().Contains(lowerQuery) == true)
                ).ToList();
                UsersCollectionView.ItemsSource = filtered;
            }
        }

        private async void OnUserTapped(object sender, TappedEventArgs e)
        {
            if (e.Parameter is User selectedUser)
            {
                await Navigation.PushModalAsync(new OtherUserProfilePage(selectedUser));
            }
        }

        private void OnGoToLoginClicked(object sender, EventArgs e)
        {
            Shell.Current.GoToAsync("//ProfileTab");
        }
    }
}
