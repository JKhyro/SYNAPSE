using System.Collections.ObjectModel;
using Synapse.Host.Interop;
using Synapse.Host.Models;

namespace Synapse.Host.ViewModels;

public sealed class MainWindowViewModel : ViewModelBase
{
    private SectionDescriptorViewModel? _selectedSection;
    private string _lastAction = "Select a section to inspect the first Native C entrypoint scaffold.";
    private string _nativeStatus;

    public MainWindowViewModel()
    {
        var topology = SynapseTopologyDocument.LoadDefault();
        var nativeKeys = NativeSynapseBridge.TryReadNativeSectionKeys();

        BoundarySummary =
            $"Runtime owner: {topology.Boundary.CoreRuntimeOwner}. Shell host: {topology.Boundary.ShellHost}. " +
            $"Interop seam: {topology.Boundary.Interop}.";

        HostSummary =
            $"Host project: {topology.Host.Project}. Native contract: {topology.NativeCore.ContractHeader}.";

        foreach (var section in topology.Sections)
        {
            var titleSuffix = nativeKeys.Contains(section.Key, StringComparer.Ordinal)
                ? section.Title
                : $"{section.Title} (metadata only)";

            Sections.Add(new SectionDescriptorViewModel
            {
                Key = section.Key,
                Title = titleSuffix,
                Surface = section.Surface,
                LaunchOwner = section.LaunchOwner,
                PresentationMode = section.PresentationMode,
                EntrySymbol = section.EntrySymbol
            });
        }

        _nativeStatus = NativeSynapseBridge.GetAvailabilityStatus();
        SelectedSection = Sections.FirstOrDefault();
    }

    public ObservableCollection<SectionDescriptorViewModel> Sections { get; } = new();

    public string BoundarySummary { get; }

    public string HostSummary { get; }

    public string NativeStatus
    {
        get => _nativeStatus;
        private set => SetProperty(ref _nativeStatus, value);
    }

    public string LastAction
    {
        get => _lastAction;
        private set => SetProperty(ref _lastAction, value);
    }

    public SectionDescriptorViewModel? SelectedSection
    {
        get => _selectedSection;
        set
        {
            if (SetProperty(ref _selectedSection, value))
            {
                OnPropertyChanged(nameof(CanLaunchSelectedSection));
            }
        }
    }

    public bool CanLaunchSelectedSection => SelectedSection is not null;

    public void LaunchSelectedSection()
    {
        if (SelectedSection is null)
        {
            LastAction = "Pick a section before invoking the native entrypoint stub.";
            return;
        }

        if (NativeSynapseBridge.TryLaunch(SelectedSection.Key, out var message))
        {
            LastAction = message;
            NativeStatus = "Native launch path responded through the interop seam.";
            return;
        }

        LastAction = message;
        NativeStatus = "Native bridge is still unavailable or incomplete for live launch.";
    }
}
