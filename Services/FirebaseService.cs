using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Firebase.Database;
using Firebase.Database.Query;
using Projekt_c4.Models;

namespace Projekt_c4.Services
{
    public class FirebaseService
    {
        // Publiczny, testowy projekt bazy danych Firebase - podmienisz go na swój własny w przyszłości!
        private readonly string FirebaseUrl = "https://runnner-test-default-rtdb.europe-west1.firebasedatabase.app/";
        private FirebaseClient firebaseClient;

        public FirebaseService()
        {
            firebaseClient = new FirebaseClient(FirebaseUrl);
        }

        // METODA: PUSH - wysyłanie nowo skończonego treningu do chmury (internet)
        public async Task PushWorkoutAsync(Workout workout)
        {
            if (workout == null || workout.UserId == 0) return;

            try
            {
                await firebaseClient
                    .Child("Workouts")
                    .Child(workout.UserId.ToString()) // Sortowanie folderów chmury po ID użytkownika!
                    .PostAsync(workout);
            }
            catch { /* Ignorujemy błędy, by nie crasHować aplikacji gdy jesteś offline (bieg w lesie) */ }
        }

        // METODA: PULL - zaciąganie historii biegów danego gracza z chmury po zalogowaniu na nowym telefonie!
        public async Task<List<Workout>> PullWorkoutsAsync(int userId)
        {
            try
            {
                var cloudWorkouts = await firebaseClient
                    .Child("Workouts")
                    .Child(userId.ToString())
                    .OnceAsync<Workout>();

                return cloudWorkouts.Select(item => item.Object).ToList();
            }
            catch
            {
                return new List<Workout>(); // Gdy brak neta - oddaj pustą listę zamiast wywalać
            }
        }

        // --- FUNKCJE UŻYTKOWNIKÓW (FIREBASE) ---
        public async Task<User?> RegisterUserAsync(User user)
        {
            try
            {
                // Ustawiamy sztywne, losowe, unikalne ID w formie int, aby nie kłóciło się z bazą SQLite na innych urządzeniach
                if (user.Id == 0)
                    user.Id = Math.Abs(Guid.NewGuid().GetHashCode());

                await firebaseClient
                    .Child("Users")
                    .Child(user.Id.ToString())
                    .PutAsync(user);

                return user;
            }
            catch { return null; }
        }

        public async Task<User?> GetUserByEmailAsync(string email)
        {
            try
            {
                var users = await firebaseClient
                    .Child("Users")
                    .OnceAsync<User>();

                return users.Select(x => x.Object).FirstOrDefault(u => u.Email == email);
            }
            catch { return null; }
        }

        public async Task<User?> LoginUserAsync(string email, string password)
        {
            try
            {
                var users = await firebaseClient
                    .Child("Users")
                    .OnceAsync<User>();

                return users.Select(x => x.Object).FirstOrDefault(u => u.Email == email && u.PasswordHash == password);
            }
            catch { return null; }
        }

        public async Task UpdateUserAsync(User user)
        {
            try
            {
                await firebaseClient
                    .Child("Users")
                    .Child(user.Id.ToString())
                    .PutAsync(user);
            }
            catch { }
        }

        public async Task<List<User>> GetAllUsersAsync()
        {
            try
            {
                var users = await firebaseClient
                    .Child("Users")
                    .OnceAsync<User>();

                return users.Select(x => x.Object).ToList();
            }
            catch { return new List<User>(); }
        }

        public async Task DeleteUserAsync(int userId)
        {
            try
            {
                await firebaseClient
                    .Child("Users")
                    .Child(userId.ToString())
                    .DeleteAsync();
            }
            catch { }
        }

        public async Task DeleteUserWorkoutsAsync(int userId)
        {
            try
            {
                await firebaseClient
                    .Child("Workouts")
                    .Child(userId.ToString())
                    .DeleteAsync();
            }
            catch { }
        }
    }
}