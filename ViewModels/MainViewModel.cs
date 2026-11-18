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
        public static MainViewModel Instance { get; private set; } = null!;
        public ObservableCollection<Workout> Workouts { get; set; } = new ObservableCollection<Workout>();

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

            // KOD TESTOWY (DEV): Wymuszenie zalogowania na sztywno, żeby nie tracić czasu!
            if (CurrentUserId == 0)
            {
                CurrentUserId = 999;
                CurrentUserName = "Janusz (Test)";
            }

            LoadWorkoutsAsync();
        }

        // Zaciąganie z bazy dla konkretnego użytkownika + pobieranie z chmury Firebase
        public async Task LoadWorkoutsAsync()
        {
            if (CurrentUserId == 0)
            {
                Workouts.Clear();
                return;
            }

            // --- 1. Zaciągnij lokalnie offline (SQLite) ---
            var dbWorkouts = await App.Database.GetWorkoutsAsync(CurrentUserId);

            // --- 2. Synchronizuj nowości z chmurą (Firebase) ---
            var cloudWorkouts = await App.FirebaseCloud.PullWorkoutsAsync(CurrentUserId);

            // Prosty mechanizm merge'owania (łączenia): Dodajemy z chmury to, czego nam brakuje
            foreach (var cloudWorkout in cloudWorkouts)
            {
                // Unikaj duplikatów po tytule i dystansie
                if (!dbWorkouts.Any(w => w.Date.ToString() == cloudWorkout.Date.ToString() && w.DistanceKm == cloudWorkout.DistanceKm))
                {
                    await App.Database.SaveWorkoutAsync(cloudWorkout);
                    dbWorkouts.Add(cloudWorkout);
                }
            }

            // Odśwież i wyświetl wszystko!
            Workouts.Clear();
            foreach (var workout in dbWorkouts.OrderByDescending(w => w.Date))
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