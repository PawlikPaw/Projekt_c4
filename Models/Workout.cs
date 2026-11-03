using System;
using System.Collections.Generic;
using Microsoft.Maui.Devices.Sensors;
using SQLite;
using System.Text.Json;
using System.Linq;

namespace Projekt_c4.Models
{
    public class Workout
    {
        [PrimaryKey, AutoIncrement]
        public int Id { get; set; }

        public int UserId { get; set; }

        public string Title { get; set; } = string.Empty;
        public DateTime Date { get; set; } = DateTime.Now;
        public double DistanceKm { get; set; }
        public TimeSpan Duration { get; set; }
        public string PaceString { get; set; } = string.Empty;

        // Kompresja koordynatów GPS do bazy danych (jako zwykły tekst JSON)
        public string RouteJson { get; set; } = string.Empty;

        // "Tymczasowa" właściwość, z której aplikacja pobiera gotowe punkty na mapę
        [Ignore]
        public List<Location> Route
        {
            get
            {
                if (string.IsNullOrEmpty(RouteJson)) return new List<Location>();
                var points = JsonSerializer.Deserialize<List<RoutePoint>>(RouteJson);
                return points?.Select(p => new Location(p.Latitude, p.Longitude)).ToList() ?? new List<Location>();
            }
            set
            {
                var points = value.Select(loc => new RoutePoint { Latitude = loc.Latitude, Longitude = loc.Longitude }).ToList();
                RouteJson = JsonSerializer.Serialize(points);
            }
        }
    }
}