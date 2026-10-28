using System;
using Microsoft.Maui.Controls;

namespace Projekt_c4.Views
{
    public partial class RunningPage : ContentPage
    {
        public RunningPage()
        {
            InitializeComponent();
        }

        private void OnStartRunClicked(object sender, EventArgs e)
        {
            if (sender is Button btn)
            {
                if (btn.Text == "ROZPOCZNIJ BIEG")
                {
                    btn.Text = "ZAKOŃCZ BIEG";
                    btn.BackgroundColor = Colors.DarkRed;
                    // Tutaj włączymy nasłuchiwanie GPS i timer
                }
                else
                {
                    btn.Text = "ROZPOCZNIJ BIEG";
                    btn.BackgroundColor = Color.FromArgb("#4CAF50");
                    // Tutaj zatrzymamy timer i wyświetlimy podsumowanie biegu
                }
            }
        }
    }
}