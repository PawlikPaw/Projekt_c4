using Android.App;
using Android.Content.PM;
using Android.OS;
using Android.Views;

namespace Projekt_c4;

[Activity(Theme = "@style/Maui.SplashTheme", MainLauncher = true, WindowSoftInputMode = SoftInput.AdjustResize, LaunchMode = LaunchMode.SingleTop, ConfigurationChanges = ConfigChanges.ScreenSize | ConfigChanges.Orientation | ConfigChanges.UiMode | ConfigChanges.ScreenLayout | ConfigChanges.SmallestScreenSize | ConfigChanges.Density)]
public class MainActivity : MauiAppCompatActivity
{
}
