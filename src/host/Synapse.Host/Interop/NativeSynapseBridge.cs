using System.Runtime.InteropServices;

namespace Synapse.Host.Interop;

internal static class NativeSynapseBridge
{
    private const string LibraryName = "synapse_core";

    public static string GetAvailabilityStatus()
    {
        try
        {
            var version = synapse_get_contract_version();
            return $"Native bridge detected. Contract version {version}.";
        }
        catch (DllNotFoundException)
        {
            return "Native bridge not built yet. The host is showing topology metadata only.";
        }
        catch (BadImageFormatException)
        {
            return "Native bridge present but not loadable by the current host process.";
        }
    }

    public static bool TryLaunch(string sectionKey, out string message)
    {
        try
        {
            var result = synapse_launch_section(sectionKey);
            if (result == 0)
            {
                message = $"Native stub launched {sectionKey}.";
                return true;
            }

            message = ReadUtf8(synapse_get_last_error()) ?? "Native launch failed.";
            return false;
        }
        catch (DllNotFoundException)
        {
            message = "Native bridge not built yet. Launch remains stubbed in the repository scaffold.";
            return false;
        }
        catch (BadImageFormatException)
        {
            message = "Native bridge is present but incompatible with the current host process.";
            return false;
        }
    }

    public static IReadOnlyList<string> TryReadNativeSectionKeys()
    {
        var keys = new List<string>();

        try
        {
            var count = synapse_get_section_count();
            for (var index = 0; index < count; index++)
            {
                var key = ReadUtf8(synapse_get_section_key(index));
                if (!string.IsNullOrWhiteSpace(key))
                {
                    keys.Add(key);
                }
            }
        }
        catch (DllNotFoundException)
        {
            return Array.Empty<string>();
        }
        catch (BadImageFormatException)
        {
            return Array.Empty<string>();
        }

        return keys;
    }

    private static string? ReadUtf8(IntPtr pointer)
    {
        return pointer == IntPtr.Zero ? null : Marshal.PtrToStringUTF8(pointer);
    }

    [DllImport(LibraryName, CallingConvention = CallingConvention.Cdecl)]
    private static extern int synapse_get_contract_version();

    [DllImport(LibraryName, CallingConvention = CallingConvention.Cdecl)]
    private static extern int synapse_get_section_count();

    [DllImport(LibraryName, CallingConvention = CallingConvention.Cdecl)]
    private static extern IntPtr synapse_get_section_key(int index);

    [DllImport(LibraryName, CallingConvention = CallingConvention.Cdecl)]
    private static extern int synapse_launch_section([MarshalAs(UnmanagedType.LPUTF8Str)] string sectionKey);

    [DllImport(LibraryName, CallingConvention = CallingConvention.Cdecl)]
    private static extern IntPtr synapse_get_last_error();
}
