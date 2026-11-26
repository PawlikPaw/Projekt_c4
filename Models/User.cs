using SQLite;

namespace Projekt_c4.Models
{
    public class User
    {
        [PrimaryKey]
        public int Id { get; set; }

        public string FirstName { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;

        [Unique]
        public string Email { get; set; } = string.Empty;

        public string PasswordHash { get; set; } = string.Empty;

        public bool UseBiometrics { get; set; } = false;

        public string ProfileImagePath { get; set; } = string.Empty;

        [Ignore]
        public string FullName => $"{FirstName} {LastName}".Trim();
        [Ignore]
        public bool HasProfileImage => !string.IsNullOrEmpty(ProfileImagePath);
        [Ignore]
        public bool HasNoProfileImage => string.IsNullOrEmpty(ProfileImagePath);
    }
}