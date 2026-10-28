using System;
using Microsoft.Maui.Controls;

namespace Projekt_c4.Views
{
    public partial class AddWorkoutPage : ContentPage
    {
        public AddWorkoutPage()
        {
            InitializeComponent();
        }

        private async void OnSaveClicked(object sender, EventArgs e)
        {
            // TODO: Tutaj w przyszłości zepniemy to z modelem danych, aby zapisać trening

            // PopAsync cofa nas do poprzedniego ekranu na stosie nawigacji
            await Navigation.PopAsync();
        }
    }
}