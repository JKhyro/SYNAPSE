using System.Text.Json;

namespace Synapse.Host.Models;

public sealed class SynapseTopologyDocument
{
    public string SchemaVersion { get; set; } = string.Empty;
    public BoundaryDescriptor Boundary { get; set; } = new();
    public HostDescriptor Host { get; set; } = new();
    public NativeCoreDescriptor NativeCore { get; set; } = new();
    public List<SectionDescriptor> Sections { get; set; } = new();

    public static SynapseTopologyDocument LoadDefault()
    {
        var topologyPath = Path.Combine(AppContext.BaseDirectory, "registry", "synapse.topology.json");
        var json = File.ReadAllText(topologyPath);

        return JsonSerializer.Deserialize<SynapseTopologyDocument>(
            json,
            new JsonSerializerOptions
            {
                PropertyNameCaseInsensitive = true
            }) ?? new SynapseTopologyDocument();
    }
}

public sealed class BoundaryDescriptor
{
    public string CoreRuntimeOwner { get; set; } = string.Empty;
    public string ShellHost { get; set; } = string.Empty;
    public string Interop { get; set; } = string.Empty;
    public List<string> ManagedScope { get; set; } = new();
}

public sealed class HostDescriptor
{
    public string Project { get; set; } = string.Empty;
    public string EntryPoint { get; set; } = string.Empty;
    public string LaunchMode { get; set; } = string.Empty;
}

public sealed class NativeCoreDescriptor
{
    public string BuildProject { get; set; } = string.Empty;
    public string LibraryName { get; set; } = string.Empty;
    public string ContractHeader { get; set; } = string.Empty;
}

public sealed class SectionDescriptor
{
    public string Key { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string Surface { get; set; } = string.Empty;
    public string LaunchOwner { get; set; } = string.Empty;
    public string RouteKind { get; set; } = string.Empty;
    public string PresentationMode { get; set; } = string.Empty;
    public string EntrySymbol { get; set; } = string.Empty;
}
