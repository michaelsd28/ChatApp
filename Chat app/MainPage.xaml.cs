using Chat_app.Views.Pages;
using System.Diagnostics;

namespace Chat_app;

public partial class MainPage : ContentPage
{


	public MainPage()
	{
		InitializeComponent();

        Routing.RegisterRoute(nameof(Dashboard) , typeof(Dashboard));
        _ = Shell.Current.GoToAsync(nameof(Dashboard));


    }



    private async void Button_login(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new Dashboard());
    }
}

