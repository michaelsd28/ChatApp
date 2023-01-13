using Chat_app.Views.Pages;

namespace Chat_app.Views.Components.Dashboard;

public partial class UserCard : ContentView
{
	public UserCard()
	{
		InitializeComponent();


    }

    private void TapGestureRecognizer_Tapped(object sender, EventArgs e)
    {
        Routing.RegisterRoute(nameof(MainChat), typeof(MainChat));
        _ = Shell.Current.GoToAsync(nameof(MainChat));
    }
}