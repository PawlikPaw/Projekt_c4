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
        private bool isPaused = false;
        private DateTime startTime;
        private TimeSpan totalPausedTime = TimeSpan.Zero;
        private DateTime lastPauseTime;
        private IDispatcherTimer timer = null!;
        private Polyline runRoute = null!;
        private Location? lastLocation;
        private double totalDistance = 0;

        // Customowa, NIEZAWODNA kropka wskazująca pozycję gracza
        private Circle userPositionMarker = null!;

        // Przechowywanie danych o krokach fizycznych
        private int realSteps = 0;
        private DateTime lastStepTime = DateTime.MinValue;
        private bool goalReachedNotified = false;

        private int stepGoal = 10000;

        public RunningPage()
        {
            InitializeComponent();

            // Ładowanie zapisanego celu kroków
            stepGoal = Microsoft.Maui.Storage.Preferences.Default.Get("DailyStepGoal", 10000);
            StepGoalLabel.Text = stepGoal.ToString("N0");

            runRoute = new Polyline
            {
                StrokeColor = Color.FromArgb("#00E676"),
                StrokeWidth = 8
            };
            RunMap.MapElements.Add(runRoute);

            userPositionMarker = new Circle
            {
                FillColor = Color.FromArgb("#FF2196F3"),
                StrokeColor = Color.FromArgb("#FFFFFFFF"),
                StrokeWidth = 4,
                Radius = Distance.FromMeters(15)
            };

            timer = Dispatcher.CreateTimer();
            timer.Interval = TimeSpan.FromSeconds(2);
            timer.Tick += Timer_Tick;
        }

        // --- NASŁUCHIWANIE FIZYCZNYCH KROKÓW ZA POMOCĄ AKCELEROMETRU ---
        private void Accelerometer_ReadingChanged(object? sender, AccelerometerChangedEventArgs e)
        {
            var data = e.Reading;
            // Obliczamy wektor wypadkowy (Magnitude) przyśpieszenia fizycznego smartfona
            double magnitude = Math.Sqrt(data.Acceleration.X * data.Acceleration.X +
                                         data.Acceleration.Y * data.Acceleration.Y +
                                         data.Acceleration.Z * data.Acceleration.Z);

            // Wartość 1.0G to stan spoczynku (grawitacja). Przeciętny wstrząs w biegu (krok) przekracza 1.3 - 1.5G
            if (magnitude > 1.4)
            {
                if ((DateTime.Now - lastStepTime).TotalMilliseconds > 300) // Cooldown na jeden krok to 300ms by wyeliminować szumy z wibracji
                {
                    realSteps++;
                    lastStepTime = DateTime.Now;

                    // Odtwarzanie do widoku na wątku GUI
                    MainThread.BeginInvokeOnMainThread(async () =>
                    {
                        StepsLabel.Text = realSteps.ToString("N0");

                        // Sprawdzamy czy osiągnęliśmy cel kroków
                        if (realSteps >= stepGoal && !goalReachedNotified)
                        {
                            goalReachedNotified = true;

                            // Odtwarzanie fanfar, wywołanie w oknie Alertu
                            await DisplayAlert("Gratulacje! 🎉", $"Udało Ci się osiągnąć zaplanowany cel: {stepGoal} kroków. Cel zostanie teraz zwiększony, abyś mógł bić kolejne rekordy!", "Super!");

                            // Obliczanie nowego celu. Zaokrągla do pełnych tysięcy dla estetyki lub zwiększa równo.
                            int nextGoal = stepGoal;
                            if (nextGoal <= 500)
                                nextGoal += 500;
                            else if (nextGoal < 5000)
                                nextGoal += 1000;
                            else
                                nextGoal += 5000;

                            stepGoal = nextGoal;
                            StepGoalLabel.Text = stepGoal.ToString("N0");
                            Microsoft.Maui.Storage.Preferences.Default.Set("DailyStepGoal", stepGoal);

                            // Resetujemy by łapać ewentualny przekroczony nowy limit na tym samym biegu
                            goalReachedNotified = false;
                        }
                    });
                }
            }
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
                    // Odblokowujemy domyślną kropkę Google
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

                            // Bliższy początkowy zoom na start biegu (0.15 km to 150 metrów wokół Ciebie)
                            RunMap.MoveToRegion(MapSpan.FromCenterAndRadius(location, Distance.FromKilometers(0.15)));
                        });
                    }
                }
            }
            catch { /* Ignoruj błędy lokalizacji na symulatorze */ }
        }

        private void Timer_Tick(object? sender, EventArgs e)
        {
            if (isRunning && !isPaused)
            {
                // Aktualizujemy etykietę czasu tylko gdy trwa bieg (odejmując czas wstrzymania)
                var duration = DateTime.Now - startTime - totalPausedTime;
                DurationLabel.Text = duration.ToString(@"mm\:ss");
            }

            // W tle pobieramy lokalizację przez cały czas
            UpdateLocation();
        }

        private bool isCheckingLocation = false; // Blokada przed zatykaniem się żądań GPS

        private async void UpdateLocation()
        {
            if (isCheckingLocation || isPaused)
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
                            }
                        }

                        // Aktualizujemy "stary punkt" na bieżąco, by śledzić pozycję z kamerą
                        lastLocation = location;

                        // Płynny zoom kamery! Zmniejszono z 0.3 na 0.15 km (150 metrów) dla dużo bliższego widoku biegacza
                        RunMap.MoveToRegion(MapSpan.FromCenterAndRadius(location, Distance.FromKilometers(0.15)));
                    });
                }
            }
            catch { }
            finally
            {
                isCheckingLocation = false;
            }
        }

        private async void OnEditStepGoalTapped(object sender, EventArgs e)
        {
            string newGoalStr = await DisplayPromptAsync("Cel Kroków", "Wpisz nowy dzienny cel kroków:", "Zapisz", "Anuluj", null, -1, Keyboard.Numeric, stepGoal.ToString());

            if (!string.IsNullOrWhiteSpace(newGoalStr) && int.TryParse(newGoalStr, out int newGoal))
            {
                if (newGoal > 0)
                {
                    stepGoal = newGoal;
                    StepGoalLabel.Text = stepGoal.ToString("N0");
                    Microsoft.Maui.Storage.Preferences.Default.Set("DailyStepGoal", stepGoal);
                }
                else
                {
                    await DisplayAlert("Błąd", "Cel kroków musi być większy niż zero.", "OK");
                }
            }
        }

        private bool isPanelExpanded = true;

        // --- ZWIJANIE I ROZWIJANIE PANELU STATYSTYK (PAN/PRZESUWANIE) ---
        private async void OnPanUpdated(object sender, PanUpdatedEventArgs e)
        {
            switch (e.StatusType)
            {
                case GestureStatus.Running:
                    if (e.TotalY > 0 && isPanelExpanded) // Dół
                    {
                        BottomPanel.TranslationY = e.TotalY;
                    }
                    else if (e.TotalY < 0 && !isPanelExpanded) // Góra
                    {
                        double newY = 300 + e.TotalY; // Odwrotność zjazdu w dół
                        if (newY >= 0)
                            BottomPanel.TranslationY = newY;
                    }
                    break;

                case GestureStatus.Completed:
                    if (BottomPanel.TranslationY > 100 && isPanelExpanded)
                    {
                        // Zsuwamy w dół tylko do poziomu przycisku akcji i uchwytu
                        await BottomPanel.TranslateTo(0, 260, 250, Easing.CubicOut);
                        isPanelExpanded = false;

                        // ZABEZPIECZENIE: NIE ukrywamy całego kontenera ActionBtn! START ma zostać.
                        StatsContent.Opacity = 0; // Znikanie zamiast ucinania!
                    }
                    else if (BottomPanel.TranslationY < 200 && !isPanelExpanded)
                    {
                        // Przywracamy statystyki i wyjeżdżamy do góry
                        StatsContent.Opacity = 1;
                        await BottomPanel.TranslateTo(0, 0, 250, Easing.CubicOut);
                        isPanelExpanded = true;
                    }
                    else
                    {
                        await BottomPanel.TranslateTo(0, isPanelExpanded ? 0 : 260, 150, Easing.Linear);
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
                // Start Biegu i akcelerometru (kroków fizycznych)
                isRunning = true;
                isPaused = false;
                totalPausedTime = TimeSpan.Zero;

                ActionBtn.Text = "STOP";
                ActionBtn.BackgroundColor = Colors.Red;
                ActionBtn.TextColor = Colors.White;

                // Animacja UI: ukryj wielki przycisk i pokaż mniejsze opcje akcji na brzegach
                Grid.SetColumn(ActionBtn, 1);
                Grid.SetColumnSpan(ActionBtn, 1);
                ResetBtn.IsVisible = true;
                PauseBtn.IsVisible = true;

                Microsoft.Maui.Devices.DeviceDisplay.Current.KeepScreenOn = true;

                // Uruchomienie śledzenia żyroskopu (akcelerometru)
                if (Accelerometer.Default.IsSupported && !Accelerometer.Default.IsMonitoring)
                {
                    Accelerometer.Default.ReadingChanged += Accelerometer_ReadingChanged;
                    Accelerometer.Default.Start(SensorSpeed.UI);
                }

                startTime = DateTime.Now;
                runRoute.Geopath.Clear();
                lastLocation = null;
                totalDistance = 0;
                realSteps = 0;
                DistanceLabel.Text = "00.00";
                StepsLabel.Text = "0";

                timer.Start();
            }
            else
            {
                // Stop Biegu, Zapisanie i powrót do normalnego stanu UI
                StopAndSaveWorkout();
            }
        }

        private void OnPauseClicked(object sender, EventArgs e)
        {
            if (!isRunning) return;

            if (isPaused)
            {
                // WZNÓW
                isPaused = false;
                totalPausedTime += DateTime.Now - lastPauseTime;
                PauseBtn.Text = "WSTRZYMAJ";
                PauseBtn.BackgroundColor = Color.FromArgb("#FFA000");

                if (Accelerometer.Default.IsSupported && !Accelerometer.Default.IsMonitoring)
                {
                    Accelerometer.Default.Start(SensorSpeed.UI);
                }
            }
            else
            {
                // WSTRZYMAJ
                isPaused = true;
                lastPauseTime = DateTime.Now;
                PauseBtn.Text = "WZNÓW";
                PauseBtn.BackgroundColor = Color.FromArgb("#00E676");

                if (Accelerometer.Default.IsMonitoring)
                {
                    Accelerometer.Default.Stop();
                }
            }
        }

        private async void OnResetClicked(object sender, EventArgs e)
        {
            bool answer = await DisplayAlert("Reset", "Czy na pewno chcesz skasować ten bieg bez zapisywania?", "Tak", "Nie");
            if (answer)
            {
                ResetUI();
            }
        }

        private void StopAndSaveWorkout()
        {
            var newWorkout = new Models.Workout
            {
                UserId = ViewModels.MainViewModel.Instance?.CurrentUserId ?? 999,
                Title = "Bieg (Outdoor)",
                Date = DateTime.Now,
                DistanceKm = totalDistance,
                Duration = DateTime.Now - startTime - totalPausedTime,
                PaceString = PaceLabel.Text,
                Route = new System.Collections.Generic.List<Microsoft.Maui.Devices.Sensors.Location>(runRoute.Geopath)
            };

            ResetUI();

            App.Database.SaveWorkoutAsync(newWorkout).ContinueWith(t =>
            {
                _ = App.FirebaseCloud.PushWorkoutAsync(newWorkout);

                if (ViewModels.MainViewModel.Instance != null)
                {
                    MainThread.BeginInvokeOnMainThread(async () =>
                    {
                        await ViewModels.MainViewModel.Instance.LoadWorkoutsAsync();
                    });
                }
            });
        }

        private void ResetUI()
        {
            isRunning = false;
            isPaused = false;

            Grid.SetColumn(ActionBtn, 0);
            Grid.SetColumnSpan(ActionBtn, 3);
            ActionBtn.Text = "START";
            ActionBtn.BackgroundColor = Color.FromArgb("#00E676");
            ActionBtn.TextColor = Colors.Black;

            ResetBtn.IsVisible = false;
            PauseBtn.IsVisible = false;
            PauseBtn.Text = "WSTRZYMAJ";
            PauseBtn.BackgroundColor = Color.FromArgb("#FFA000");

            Microsoft.Maui.Devices.DeviceDisplay.Current.KeepScreenOn = false;

            if (Accelerometer.Default.IsMonitoring)
            {
                Accelerometer.Default.Stop();
                Accelerometer.Default.ReadingChanged -= Accelerometer_ReadingChanged;
            }

            timer.Stop();
            runRoute.Geopath.Clear();
            DistanceLabel.Text = "00.00";
            StepsLabel.Text = "0";
            DurationLabel.Text = "00:00";
            totalDistance = 0;
            realSteps = 0;
        }
    }
}