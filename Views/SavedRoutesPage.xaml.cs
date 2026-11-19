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
            BindingContext = ViewModels.MainViewModel.Instance;
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
                await Navigation.PushModalAsync(new RouteDetailsPage(selectedWorkout));
            }
        }

        private async void OnEditTapped(object sender, TappedEventArgs e)
        {
            if (e.Parameter is Workout workoutToEdit)
            {
                string newTitle = await DisplayPromptAsync("Edycja", "Podaj nową nazwę dla tego treningu:", "Zapisz", "Anuluj", null, -1, null, workoutToEdit.Title);

                if (!string.IsNullOrWhiteSpace(newTitle) && newTitle != workoutToEdit.Title)
                {
                    workoutToEdit.Title = newTitle;

                    // Zapisanie nowej nazwy w bazie danych
                    await App.Database.SaveWorkoutAsync(workoutToEdit);

                    // Jeśli chcesz, można tu także dodać wysłanie zmian do FirebaseCloud:
                    // _ = App.FirebaseCloud.PushWorkoutAsync(workoutToEdit);

                    // Odświeżenie listy z widokiem (wyciąga najnowsze dane z powrotem z bazy)
                    await ViewModels.MainViewModel.Instance.LoadWorkoutsAsync();
                }
            }
        }

        private async void OnDeleteTapped(object sender, TappedEventArgs e)
        {
            if (e.Parameter is Workout workoutToDelete)
            {
                bool answer = await DisplayAlert("Usuwanie", "Czy na pewno chcesz usunąć ten bieg?", "Tak", "Nie");
                if (answer)
                {
                    await ViewModels.MainViewModel.Instance.DeleteWorkoutAsync(workoutToDelete);
                }
            }
        }

        private void OnGoToLoginClicked(object sender, System.EventArgs e)
        {
            // Przejście do zakładki profilu przez nawigację Shella przy użyciu route'a zakładki
            Shell.Current.GoToAsync("//ProfileTab");
        }
    }
}