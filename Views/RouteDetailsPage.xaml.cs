using System;
using System.Linq;
using Microsoft.Maui.Controls;
using Microsoft.Maui.Controls.Maps;
using Microsoft.Maui.Maps;
using Projekt_c4.Models;

namespace Projekt_c4.Views
{
    public partial class RouteDetailsPage : ContentPage
    {
        public RouteDetailsPage(Workout workout)
        {
            InitializeComponent();

            // Ustawienie statystyk na dolnym panelu
            TitleLabel.Text = workout.Date.ToString("dd.MM.yyyy HH:mm");
            DistanceLabel.Text = workout.DistanceKm.ToString("0.00");
            DurationLabel.Text = workout.Duration.ToString(@"hh\:mm\:ss");
            PaceLabel.Text = string.IsNullOrEmpty(workout.PaceString) ? "--'--" : workout.PaceString;

            // Rysowanie trasy na mapie
            if (workout.Route != null && workout.Route.Any())
            {
                var polyline = new Polyline
                {
                    StrokeColor = Color.FromArgb("#00E676"),
                    StrokeWidth = 8
                };

                // Dodawanie zdekodowanych z JSONa punktów GPS do linii mapy
                foreach (var loc in workout.Route)
                {
                    polyline.Geopath.Add(loc);
                }
                RouteMap.MapElements.Add(polyline);

                // Dodanie graficznych pinezek START i META
                var startLocation = workout.Route.First();
                var endLocation = workout.Route.Last();

                RouteMap.Pins.Add(new Pin
                {
                    Label = "START",
                    Location = startLocation,
                    Type = PinType.Place
                });

                RouteMap.Pins.Add(new Pin
                {
                    Label = "META",
                    Location = endLocation,
                    Type = PinType.Place
                });

                // Kalkulacja centrum mapy, by objęła całą trasę (od startu do mety)
                var centerLat = (startLocation.Latitude + endLocation.Latitude) / 2;
                var centerLong = (startLocation.Longitude + endLocation.Longitude) / 2;
                var center = new Location(centerLat, centerLong);

                var distance = Location.CalculateDistance(startLocation, endLocation, DistanceUnits.Kilometers);
                var radius = Math.Max(distance / 2 + 0.2, 0.5); // Bezpieczny zoom out

                RouteMap.MoveToRegion(MapSpan.FromCenterAndRadius(center, Distance.FromKilometers(radius)));
            }
        }

        private async void OnBackTapped(object sender, EventArgs e)
        {
            // Powrót do poprzedniego ekranu bez burzenia paska zakładek Shell
            await Navigation.PopAsync();
        }
    }
}