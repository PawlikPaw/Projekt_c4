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
        private static MainViewModel? _instance;
        public static MainViewModel Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new MainViewModel();
                return _instance;
            }
        }

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

        private string _profileImagePath = string.Empty;
        public string ProfileImagePath
        {
            get => _profileImagePath;
            set
            {
                _profileImagePath = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(HasProfileImage));
                OnPropertyChanged(nameof(HasNoProfileImage));
            }
        }

        public bool HasProfileImage => !string.IsNullOrEmpty(ProfileImagePath);
        public bool HasNoProfileImage => string.IsNullOrEmpty(ProfileImagePath);

        private int _currentUserId;
        public int CurrentUserId
        {
            get => _currentUserId;
            set
            {
                _currentUserId = value;
                IsLoggedIn = _currentUserId > 0;
            }
        }

        private bool _isLoggedIn;
        public bool IsLoggedIn
        {
            get => _isLoggedIn;
            set
            {
                _isLoggedIn = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(IsNotLoggedIn));
            }
        }

        public bool IsNotLoggedIn => !IsLoggedIn;

        private int _totalSteps;
        public int TotalSteps
        {
            get => _totalSteps;
            set
            {
                _totalSteps = value;
                OnPropertyChanged();
            }
        }

        public MainViewModel()
        {
            Workouts = new ObservableCollection<Workout>();

            // Wczytywanie zapisanej sesji (Persist)
            CurrentUserId = Microsoft.Maui.Storage.Preferences.Default.Get("CurrentUserId", 0);
            _currentUserName = Microsoft.Maui.Storage.Preferences.Default.Get("CurrentUserName", "Biegaczu");

            // Ustaw flagę logowania
            IsLoggedIn = CurrentUserId > 0;

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

            var user = await App.Database.GetUserByIdAsync(CurrentUserId);
            if (user != null)
            {
                ProfileImagePath = user.ProfileImagePath;
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
            int stepsSum = 0;
            foreach (var workout in dbWorkouts.OrderByDescending(w => w.Date))
            {
                Workouts.Add(workout);
                stepsSum += (int)(workout.DistanceKm * 1300);
            }
            TotalSteps = stepsSum;
        }

        public async Task DeleteWorkoutAsync(Workout workout)
        {
            if (workout == null) return;

            // Usuń z lokalnej bazy
            await App.Database.DeleteWorkoutAsync(workout);

            // Usuń z widoku
            Workouts.Remove(workout);

            // W przyszłości można dodać: await App.FirebaseCloud.DeleteWorkoutAsync(workout.Id);
        }

        public event PropertyChangedEventHandler? PropertyChanged;
        protected void OnPropertyChanged([CallerMemberName] string? propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}