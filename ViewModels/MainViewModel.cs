using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using Projekt_c4.Models;

namespace Projekt_c4.ViewModels
{
    public class MainViewModel : INotifyPropertyChanged
    {
        public ObservableCollection<Workout> Workouts { get; set; }

        public MainViewModel()
        {
            Workouts = new ObservableCollection<Workout>
            {
                new Workout
                {
                    Title = "Trening klatki i tricepsa",
                    Date = DateTime.Now,
                    Exercises = new System.Collections.Generic.List<Exercise>
                    {
                        new Exercise { Name = "Wyciskanie sztangi leżąc", Sets = 4, Reps = 10, WeightKg = 80 },
                        new Exercise { Name = "Pompki na poręczach (Dipy)", Sets = 3, Reps = 12, WeightKg = 0 }
                    }
                }
            };
        }

        public event PropertyChangedEventHandler? PropertyChanged;
        protected void OnPropertyChanged([CallerMemberName] string? propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}