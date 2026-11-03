using System.Collections.Generic;
using System.Threading.Tasks;
using SQLite;
using Projekt_c4.Models;

namespace Projekt_c4.Data
{
    public class WorkoutDatabase
    {
        private SQLiteAsyncConnection _database;

        public WorkoutDatabase(string dbPath)
        {
            _database = new SQLiteAsyncConnection(dbPath);
            _database.CreateTableAsync<Workout>().Wait(); // Tabela Treningów
            _database.CreateTableAsync<User>().Wait();    // Nowa Tabela Użytkowników
        }

        // --- FUNKCJE TRENINGÓW ---
        public Task<List<Workout>> GetWorkoutsAsync(int userId)
        {
            return _database.Table<Workout>().Where(w => w.UserId == userId).OrderByDescending(w => w.Date).ToListAsync();
        }

        public Task<int> SaveWorkoutAsync(Workout workout)
        {
            if (workout.Id != 0)
                return _database.UpdateAsync(workout);
            else
                return _database.InsertAsync(workout);
        }

        // --- FUNKCJE UŻYTKOWNIKÓW (LOGOWANIE/REJESTRACJA) ---
        public Task<User> GetUserAsync(string email, string password)
        {
            return _database.Table<User>().Where(u => u.Email == email && u.PasswordHash == password).FirstOrDefaultAsync();
        }

        public Task<int> SaveUserAsync(User user)
        {
            return _database.InsertAsync(user);
        }

        public Task<User> GetUserByEmailAsync(string email)
        {
            return _database.Table<User>().Where(u => u.Email == email).FirstOrDefaultAsync();
        }
    }
}