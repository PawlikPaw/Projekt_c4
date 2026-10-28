namespace Projekt_c4.Models
{
    public class Exercise
    {
        public string Name { get; set; } = string.Empty;

        // Pola dla ćwiczeń siłowych
        public int Sets { get; set; }
        public int Reps { get; set; }
        public double WeightKg { get; set; }

        // Pola dla ćwiczeń cardio / biegania
        public double DistanceKm { get; set; }
        public System.TimeSpan Duration { get; set; }
        public bool IsCardio { get; set; }
    }
}