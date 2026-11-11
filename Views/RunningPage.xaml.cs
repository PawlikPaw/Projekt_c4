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

        // Customowa, NIEZAWODNA kropka wskazująca pozycję gracza
        private Circle userPositionMarker;

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

            // Inicjalizacja naszej kropki gracza
            userPositionMarker = new Circle
            {
                FillColor = Color.FromArgb("#FF2196F3"), // Niebieska
                StrokeColor = Color.FromArgb("#FFFFFFFF"), // Biała obwódka
                StrokeWidth = 4,
                Radius = Distance.FromMeters(15) // Kółeczko wielkości 15m
            };

            // Inicjalizacja pętli odświeżającej GPS
            timer = Dispatcher.CreateTimer();
            timer.Interval = TimeSpan.FromSeconds(2); // Sprawdzaj stabilnie co 2 sekundy
            timer.Tick += Timer_Tick;
        }

        protected override async void OnAppearing()
        {
            base.OnAppearing();
            await RequestLocationPermission();

            // Zawsze uruchamiaj lokalizację gdy jesteśmy na ekranie, by gracz widział gdzie jest przed startem!
            timer.Start();
        }

        protected override void OnDisappearing()
        {
            base.OnDisappearing();
            // Wyłącz odświeżanie w tle, jeśli gracz wyszedł z ekranu i nie jest w trakcie biegu
            if (!isRunning)
            {
                timer.Stop();
            }
        }

        private async Task RequestLocationPermission()
        {
            var status = await Permissions.CheckStatusAsync<Permissions.LocationWhenInUse>();
            if (status != PermissionStatus.Granted)
            {
                status = await Permissions.RequestAsync<Permissions.LocationWhenInUse>();
            }

            try
            {
                if (status == PermissionStatus.Granted)
                {
                    // Odblokowujemy domyślną kropkę Google i jej natywny przycisk centrowania mapy
                    RunMap.IsShowingUser = true;

                    // Wyśrodkuj mapę na obecnej lokalizacji startowej
                    var request = new GeolocationRequest(GeolocationAccuracy.Medium, TimeSpan.FromSeconds(5));
                    var location = await Geolocation.GetLocationAsync(request);

                    if (location == null)
                        location = await Geolocation.GetLastKnownLocationAsync();

                    if (location != null)
                    {
                        MainThread.BeginInvokeOnMainThread(() =>
                        {
                            userPositionMarker.Center = location;
                            if (!RunMap.MapElements.Contains(userPositionMarker))
                                RunMap.MapElements.Add(userPositionMarker);

                            RunMap.MoveToRegion(MapSpan.FromCenterAndRadius(location, Distance.FromKilometers(0.5)));
                        });
                    }
                }
            }
            catch { /* Ignoruj błędy lokalizacji na symulatorze */ }
        }

        private void Timer_Tick(object sender, EventArgs e)
        {
            if (isRunning)
            {
                // Aktualizujemy etykietę czasu tylko gdy trwa bieg
                var duration = DateTime.Now - startTime;
                DurationLabel.Text = duration.ToString(@"mm\:ss");
            }

            // W tle pobieramy lokalizację przez cały czas
            UpdateLocation();
        }

        private bool isCheckingLocation = false; // Blokada przed zatykaniem się żądań GPS

        private async void UpdateLocation()
        {
            if (isCheckingLocation)
                return;

            isCheckingLocation = true;

            try
            {
                var request = new GeolocationRequest(GeolocationAccuracy.High, TimeSpan.FromSeconds(2));
                var location = await Geolocation.GetLocationAsync(request);

                if (location == null)
                    location = await Geolocation.GetLastKnownLocationAsync();

                if (location != null)
                {
                    MainThread.BeginInvokeOnMainThread(() =>
                    {
                        userPositionMarker.Center = location;
                        if (!RunMap.MapElements.Contains(userPositionMarker))
                            RunMap.MapElements.Add(userPositionMarker);

                        // Liczymy dystans i rysujemy trasę TYLKO gdy kliknięto START
                        if (isRunning && lastLocation != null)
                        {
                            var distance = Location.CalculateDistance(lastLocation, location, DistanceUnits.Kilometers);
                            if (distance > 0.002)
                            {
                                runRoute.Geopath.Add(location);
                                totalDistance += distance;
                                DistanceLabel.Text = totalDistance.ToString("0.00");

                                int steps = (int)(totalDistance * 1300);
                                StepsLabel.Text = steps.ToString("N0");
                            }
                        }

                        // Aktualizujemy "stary punkt" na bieżąco, by śledzić pozycję z kamerą
                        lastLocation = location;

                        // Centruj płynnie mapę na nowej pozycji
                        RunMap.MoveToRegion(MapSpan.FromCenterAndRadius(location, Distance.FromKilometers(0.3)));
                    });
                }
            }
            catch { }
            finally
            {
                isCheckingLocation = false;
            }
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

        private void OnActionClicked(object sender, EventArgs e)
        {
            if (ViewModels.MainViewModel.Instance?.CurrentUserId == 0)
            {
                DisplayAlert("Wymagane logowanie", "Zanim zaczniesz biegać, przejdź do zakładki Profil i zaloguj się na swoje konto, by móc zapisać trening!", "OK");
                return;
            }

            if (!isRunning)
            {
                // Start Biegu
                isRunning = true;
                ActionBtn.Text = "STOP";
                ActionBtn.BackgroundColor = Colors.Red;
                ActionBtn.TextColor = Colors.White;

                // Zapobieganie wygaszaniu ekranu w kieszeni i usypianiu modułu GPS!
                Microsoft.Maui.Devices.DeviceDisplay.Current.KeepScreenOn = true;

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

                // Ekran znowu może się normalnie wygaszać
                Microsoft.Maui.Devices.DeviceDisplay.Current.KeepScreenOn = false;

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