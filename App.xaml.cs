using System;
using System.IO;
using Microsoft.Maui.Controls;
using Projekt_c4.Data;

namespace Projekt_c4
{
    public partial class App : Application
    {
        private static WorkoutDatabase _database;
        public static WorkoutDatabase Database
        {
            get
            {
                if (_database == null)
                {
                    string dbPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "Workouts.db3");
                    _database = new WorkoutDatabase(dbPath);
                }
                return _database;
            }
        }

        public App()
        {
            InitializeComponent();
            MainPage = new AppShell();
        }
    }
}