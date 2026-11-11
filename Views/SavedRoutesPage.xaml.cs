using System.Linq;
using Microsoft.Maui.Controls;
using Projekt_c4.Models;

namespace Projekt_c4.Views
{
    public partial class SavedRoutesPage : ContentPage
    {
        public SavedRoutesPage()
        {
            InitializeComponent();
        }

        protected override async void OnAppearing()
        {
            base.OnAppearing();

            // Przy każdym wejściu w tę zakładkę odświeżamy historię (np. jeśli skończyliśmy nowy bieg)
            if (ViewModels.MainViewModel.Instance != null)
            {
                await ViewModels.MainViewModel.Instance.LoadWorkoutsAsync();
            }
        }

        private async void OnWorkoutSelected(object sender, SelectionChangedEventArgs e)
        {
            // Przechwytujemy kliknięty bieg z listy
            if (e.CurrentSelection.FirstOrDefault() is Workout selectedWorkout)
            {
                // Odznaczamy element, by móc w niego kliknąć ponownie w przyszłości
                ((CollectionView)sender).SelectedItem = null;

                // Animowane wjechanie na wierzch nowo zaprogramowanego ekranu "RouteDetailsPage"
                await Navigation.PushAsync(new RouteDetailsPage(selectedWorkout));
            }
        }
    }
}