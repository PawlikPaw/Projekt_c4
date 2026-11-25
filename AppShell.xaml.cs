namespace Projekt_c4;

public partial class AppShell : Shell
{
	public AppShell()
	{
		InitializeComponent();
	}

    protected override void OnNavigated(ShellNavigatedEventArgs args)
    {
        base.OnNavigated(args);

        // Reset wszystkich ikon na nieaktywne
        RunningTab.Icon = "runinactive.png";
        RoutesTab.Icon = "routesinactive.png";
        SearchTab.Icon = "searchinactive.png";
        ProfileTab.Icon = "profileinactive.png";

        // Ustalanie aktywnej zakładki na podstawie aktualnej ścieżki
        var currentRoute = Shell.Current.CurrentState.Location.OriginalString;

        if (currentRoute.Contains("RunningTab"))
        {
            RunningTab.Icon = "runactive.png";
        }
        else if (currentRoute.Contains("RoutesTab"))
        {
            RoutesTab.Icon = "routesactive.png";
        }
        else if (currentRoute.Contains("SearchTab"))
        {
            SearchTab.Icon = "searchactive.png";
        }
        else if (currentRoute.Contains("ProfileTab") || currentRoute.Contains("MainPage"))
        {
            ProfileTab.Icon = "profileactive.png";
        }
    }
}
