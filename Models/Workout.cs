using System;
using System.Collections.Generic;

namespace Projekt_c4.Models
{
    public class Workout
    {
        public string Title { get; set; } = string.Empty;
        public DateTime Date { get; set; } = DateTime.Now;
        public List<Exercise> Exercises { get; set; } = new List<Exercise>();
    }
}