using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Projekt_c4.Models;

namespace Projekt_c4.ViewModels
{
    public class MainViewModel : INotifyPropertyChanged
    {
        public static MainViewModel Instance { get; private set; }
        public ObservableCollection<Workout> Workouts { get; set; }

        // Zmienna trzymająca imię aktualnie zalogowanego użytkownika
        private string _currentUserName = "Biegaczu";
        public string CurrentUserName
        {
            get => _currentUserName;
            set
            {
                _currentUserName = value;
                OnPropertyChanged();
            }
        }

        public int CurrentUserId { get; set; }

        public MainViewModel()
        {
            Instance = this;
            Workouts = new ObservableCollection<Workout>();

            // Wczytywanie zapisanej sesji (Persist)
            CurrentUserId = Microsoft.Maui.Storage.Preferences.Default.Get("CurrentUserId", 0);
            _currentUserName = Microsoft.Maui.Storage.Preferences.Default.Get("CurrentUserName", "Biegaczu");

            LoadWorkoutsAsync();
        }

        // Zaciąganie z bazy dla konkretnego użytkownika
        public async Task LoadWorkoutsAsync()
        {
            if (CurrentUserId == 0)
            {
                Workouts.Clear();
                return;
            }

            var dbWorkouts = await App.Database.GetWorkoutsAsync(CurrentUserId);
            Workouts.Clear();
            foreach (var workout in dbWorkouts)
            {
                Workouts.Add(workout);
            }
        }

        public event PropertyChangedEventHandler? PropertyChanged;
        protected void OnPropertyChanged([CallerMemberName] string? propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}