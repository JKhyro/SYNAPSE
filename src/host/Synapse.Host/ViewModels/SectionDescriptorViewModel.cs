namespace Synapse.Host.ViewModels;

public sealed class SectionDescriptorViewModel
{
    public required string Key { get; init; }
    public required string Title { get; init; }
    public required string Surface { get; init; }
    public required string LaunchOwner { get; init; }
    public required string PresentationMode { get; init; }
    public required string EntrySymbol { get; init; }
}
