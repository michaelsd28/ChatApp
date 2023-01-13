namespace Chat_app.Views.Pages;

public partial class MainChat : ContentPage
{
	public MainChat()
	{
		InitializeComponent();

        // scroll to bottom
        chat_stack.SizeChanged += (s, e) =>
        {
            chat_scroll.ScrollToAsync(0, chat_scroll.ScrollY + chat_stack.Height, false);
        };

    }
}