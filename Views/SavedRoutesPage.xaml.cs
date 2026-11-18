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

        // Metoda do płynnego otwierania historii, wyzwalana natywnym stuknięciem
        private async void OnRouteTapped(object sender, TappedEventArgs e)
        {
            if (e.Parameter is Workout selectedWorkout)
            {
                // Animowane wjechanie na wierzch ekranu "RouteDetailsPage"
                await Navigation.PushAsync(new RouteDetailsPage(selectedWorkout));
            }
        }
    }
}