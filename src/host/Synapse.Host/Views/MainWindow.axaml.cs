using Avalonia.Controls;
using Avalonia.Interactivity;
using Synapse.Host.ViewModels;

namespace Synapse.Host.Views;

public partial class MainWindow : Window
{
    public MainWindow()
    {
        InitializeComponent();
    }

    private void OpenSelectedSection(object? sender, RoutedEventArgs e)
    {
        if (DataContext is MainWindowViewModel viewModel)
        {
            viewModel.LaunchSelectedSection();
        }
    }
}
