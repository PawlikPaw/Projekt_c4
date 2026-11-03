using System;
using System.Threading.Tasks;
using Microsoft.Maui.Controls;
using Microsoft.Maui.Devices.Sensors;
using Microsoft.Maui.Controls.Maps;
using Microsoft.Maui.Maps;

namespace Projekt_c4.Views
{
    public partial class RunningPage : ContentPage
    {
        private bool isRunning = false;
        private DateTime startTime;
        private IDispatcherTimer timer;
        private Polyline runRoute;
        private Location lastLocation;
        private double totalDistance = 0;

        public RunningPage()
        {
            InitializeComponent();

            // Konfiguracja linii ścieżki biegu (neonowa zieleń)
            runRoute = new Polyline
            {
                StrokeColor = Color.FromArgb("#00E676"),
                StrokeWidth = 8
            };
            RunMap.MapElements.Add(runRoute);

            // Inicjalizacja zegara (Stopera)
            timer = Dispatcher.CreateTimer();
            timer.Interval = TimeSpan.FromSeconds(1);
            timer.Tick += Timer_Tick;
        }

        protected override async void OnAppearing()
        {
            base.OnAppearing();
            await RequestLocationPermission();
        }

        private async Task RequestLocationPermission()
        {
            var status = await Permissions.CheckStatusAsync<Permissions.LocationWhenInUse>();
            if (status != PermissionStatus.Granted)
            {
                await Permissions.RequestAsync<Permissions.LocationWhenInUse>();
            }

            try
            {
                // Wyśrodkuj mapę na obecnej lokalizacji startowej
                var request = new GeolocationRequest(GeolocationAccuracy.Medium, TimeSpan.FromSeconds(5));
                var location = await Geolocation.GetLocationAsync(request);
                if (location != null)
                {
                    RunMap.MoveToRegion(MapSpan.FromCenterAndRadius(location, Distance.FromKilometers(0.5)));
                }
            }
            catch { /* Ignoruj błędy lokalizacji na symulatorze */ }
        }

        private void Timer_Tick(object sender, EventArgs e)
        {
            var duration = DateTime.Now - startTime;
            DurationLabel.Text = duration.ToString(@"mm\:ss");

            // W tle pobieramy lokalizację co kilka sekund
            UpdateLocation();
        }

        private async void UpdateLocation()
        {
            try
            {
                var request = new GeolocationRequest(GeolocationAccuracy.Best, TimeSpan.FromSeconds(3));
                var location = await Geolocation.GetLocationAsync(request);

                if (location != null)
                {
                    if (lastLocation != null)
                    {
                        var distance = Location.CalculateDistance(lastLocation, location, DistanceUnits.Kilometers);
                        if (distance > 0.005) // filtr szumu GPS
                        {
                            runRoute.Geopath.Add(location);
                            totalDistance += distance;
                            DistanceLabel.Text = totalDistance.ToString("00.00");

                            // Symulowany krokomierz! Przeciętnie z 1 kilometra wychodzi ~1300 kroków
                            int steps = (int)(totalDistance * 1300);
                            StepsLabel.Text = steps.ToString("N0");
                        }
                    }
                    lastLocation = location;

                    // Podążaj kamerą za graczem
                    RunMap.MoveToRegion(MapSpan.FromCenterAndRadius(location, Distance.FromKilometers(0.3)));
                }
            }
            catch { }
        }

        private bool isPanelExpanded = true;

        // --- ZWIJANIE I ROZWIJANIE PANELU STATYSTYK (PAN/PRZESUWANIE) ---
        private async void OnPanUpdated(object sender, PanUpdatedEventArgs e)
        {
            switch (e.StatusType)
            {
                case GestureStatus.Running:
                    if (e.TotalY > 0 && isPanelExpanded) // Przesunięcie w dół
                    {
                        BottomPanel.TranslationY = e.TotalY;
                    }
                    else if (e.TotalY < 0 && !isPanelExpanded) // Przesunięcie w górę
                    {
                        double newY = 400 + e.TotalY; // Ukryty znacznie mocniej u dołu
                        if (newY >= 0)
                            BottomPanel.TranslationY = newY;
                    }
                    break;

                case GestureStatus.Completed:
                    if (BottomPanel.TranslationY > 100 && isPanelExpanded)
                    {
                        // Całkowite zsunięcie w dół, widoczny pozostaje tylko przycisk "uchwyt"
                        await BottomPanel.TranslateTo(0, 400, 250, Easing.CubicOut);
                        isPanelExpanded = false;
                    }
                    else if (BottomPanel.TranslationY < 300 && !isPanelExpanded)
                    {
                        // Powrót statystyk na górę
                        await BottomPanel.TranslateTo(0, 0, 250, Easing.CubicOut);
                        isPanelExpanded = true;
                    }
                    else
                    {
                        await BottomPanel.TranslateTo(0, isPanelExpanded ? 0 : 400, 150, Easing.Linear);
                    }
                    break;
            }
        }

        private async void OnProfileIconTapped(object sender, EventArgs e)
        {
            // Przeniesienie do zakładki "Profil" przy użyciu zdefiniowanego Route
            await Shell.Current.GoToAsync("//ProfileTab");
        }

        private async void OnCenterMapTapped(object sender, EventArgs e)
        {
            // Opcja ręcznego wymuszania centrowania mapy na naszej lokalizacji
            await RequestLocationPermission();
        }

        private void OnActionClicked(object sender, EventArgs e)
        {
            if (!isRunning)
            {
                // Start Biegu
                isRunning = true;
                ActionBtn.Text = "STOP";
                ActionBtn.BackgroundColor = Colors.Red;
                ActionBtn.TextColor = Colors.White;

                startTime = DateTime.Now;
                runRoute.Geopath.Clear();
                lastLocation = null;
                totalDistance = 0;
                DistanceLabel.Text = "00.00";

                timer.Start();
            }
            else
            {
                // Stop Biegu
                isRunning = false;
                ActionBtn.Text = "START";
                ActionBtn.BackgroundColor = Color.FromArgb("#00E676");
                ActionBtn.TextColor = Colors.Black;

                timer.Stop();

                // Zapisz bieg do bazy danych!
                var newWorkout = new Models.Workout
                {
                    UserId = ViewModels.MainViewModel.Instance?.CurrentUserId ?? 0,
                    Title = "Bieg (Outdoor)",
                    Date = DateTime.Now,
                    DistanceKm = totalDistance,
                    Duration = DateTime.Now - startTime,
                    PaceString = PaceLabel.Text,
                    Route = new System.Collections.Generic.List<Microsoft.Maui.Devices.Sensors.Location>(runRoute.Geopath)
                };

                // Czekamy na zapisanie do SQLite i odświeżamy ViewModel
                App.Database.SaveWorkoutAsync(newWorkout).ContinueWith(t =>
                {
                    if (ViewModels.MainViewModel.Instance != null)
                    {
                        MainThread.BeginInvokeOnMainThread(async () =>
                        {
                            await ViewModels.MainViewModel.Instance.LoadWorkoutsAsync();
                        });
                    }
                });
            }
        }
    }
}