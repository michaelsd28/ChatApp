

namespace Chat_app.Views.Components.ChatScreen;

public partial class Chat_bubble : ContentView
{



    /// <summary>
	/// net maui custom control binding property to set the chat bubble text
	/// </summary>
	/// 
	public static readonly BindableProperty TextProperty = BindableProperty.Create(nameof(Bubble_text), typeof(string), typeof(Chat_bubble), string.Empty, BindingMode.TwoWay, propertyChanged: OnTextPropertyChanged);

    private static void OnTextPropertyChanged(BindableObject bindable, object oldValue, object newValue)
    {
        if (bindable is Chat_bubble chatBubble)
        {
            chatBubble.chat_bubble_text.Text = newValue.ToString();
        }
    }

    public string Bubble_text { get => (string)GetValue(TextProperty); set => SetValue(TextProperty, value); }


    // now with color 
    public static readonly BindableProperty ColorProperty = BindableProperty.Create(nameof(Bubble_color), typeof(Color), typeof(Chat_bubble), Color.FromInt(0), BindingMode.TwoWay, propertyChanged: OnColorPropertyChanged);
    private static void OnColorPropertyChanged(BindableObject bindable, object oldValue, object newValue)
    {
        if (bindable is Chat_bubble chatBubble)
        {
            chatBubble.Bubble_frame.Background = (Color)newValue;
        }
    }
    public Color Bubble_color { get => (Color)GetValue(ColorProperty); set => SetValue(ColorProperty, value); }




    // now with horizontal alignment the type is string
    public static readonly BindableProperty HorizontalAlignmentProperty = BindableProperty.Create(nameof(Bubble_horizontal_alignment), typeof(string), typeof(Chat_bubble), string.Empty, BindingMode.TwoWay, propertyChanged: OnHorizontalAlignmentPropertyChanged);

    private static void OnHorizontalAlignmentPropertyChanged(BindableObject bindable, object oldValue, object newValue)
    {
        if (bindable is Chat_bubble chatBubble)
        {
            chatBubble.chat_bubble_text.HorizontalTextAlignment = (TextAlignment)Enum.Parse(typeof(TextAlignment), newValue.ToString());
        }
    }

    public string Bubble_horizontal_alignment { get => (string)GetValue(HorizontalAlignmentProperty); set => SetValue(HorizontalAlignmentProperty, value); }







    public Chat_bubble()
	{
		InitializeComponent();
	}
}