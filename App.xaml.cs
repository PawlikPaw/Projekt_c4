using Microsoft.Maui.Controls;

namespace Projekt_c4
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();
            MainPage = new AppShell();
        }
    }
}