#include "synapse_shell_contract.h"

#include <stddef.h>
#include <string.h>

typedef struct synapse_section_descriptor {
    const char* key;
    const char* title;
    const char* surface;
    const char* presentation_mode;
    const char* entry_symbol;
} synapse_section_descriptor;

static const synapse_section_descriptor g_sections[] = {
    { "CORTEX", "CORTEX", "Agent and array management", "embedded-pane", "synapse_launch_cortex" },
    { "VECTOR", "VECTOR", "Active workspace product", "embedded-pane", "synapse_launch_vector" },
    { "FORGE", "FORGE", "Code and file workspace", "embedded-pane", "synapse_launch_forge" },
    { "ANVIL", "ANVIL", "Launcher and overview shell", "embedded-pane", "synapse_launch_anvil" },
    { "NEXUS", "NEXUS", "Communications surface", "embedded-pane", "synapse_launch_nexus" }
};

static const int g_contract_version = 1;
static const char* g_last_launched_section = "";
static const char* g_last_error = "";

static const synapse_section_descriptor* synapse_find_section(const char* section_key)
{
    size_t index = 0;

    if (section_key == NULL) {
        return NULL;
    }

    for (index = 0; index < sizeof(g_sections) / sizeof(g_sections[0]); ++index) {
        if (strcmp(g_sections[index].key, section_key) == 0) {
            return &g_sections[index];
        }
    }

    return NULL;
}

int synapse_get_contract_version(void)
{
    return g_contract_version;
}

int synapse_get_section_count(void)
{
    return (int)(sizeof(g_sections) / sizeof(g_sections[0]));
}

const char* synapse_get_section_key(int index)
{
    if (index < 0 || index >= synapse_get_section_count()) {
        return NULL;
    }

    return g_sections[index].key;
}

const char* synapse_get_section_title(int index)
{
    if (index < 0 || index >= synapse_get_section_count()) {
        return NULL;
    }

    return g_sections[index].title;
}

const char* synapse_get_section_surface(int index)
{
    if (index < 0 || index >= synapse_get_section_count()) {
        return NULL;
    }

    return g_sections[index].surface;
}

const char* synapse_get_section_presentation_mode(int index)
{
    if (index < 0 || index >= synapse_get_section_count()) {
        return NULL;
    }

    return g_sections[index].presentation_mode;
}

const char* synapse_get_section_entry_symbol(int index)
{
    if (index < 0 || index >= synapse_get_section_count()) {
        return NULL;
    }

    return g_sections[index].entry_symbol;
}

int synapse_launch_cortex(void)
{
    g_last_launched_section = "CORTEX";
    g_last_error = "";
    return 0;
}

int synapse_launch_vector(void)
{
    g_last_launched_section = "VECTOR";
    g_last_error = "";
    return 0;
}

int synapse_launch_forge(void)
{
    g_last_launched_section = "FORGE";
    g_last_error = "";
    return 0;
}

int synapse_launch_anvil(void)
{
    g_last_launched_section = "ANVIL";
    g_last_error = "";
    return 0;
}

int synapse_launch_nexus(void)
{
    g_last_launched_section = "NEXUS";
    g_last_error = "";
    return 0;
}

int synapse_launch_section(const char* section_key)
{
    const synapse_section_descriptor* section = synapse_find_section(section_key);

    if (section == NULL) {
        g_last_error = "Unknown SYNAPSE section key.";
        return -1;
    }

    if (strcmp(section->key, "CORTEX") == 0) {
        return synapse_launch_cortex();
    }

    if (strcmp(section->key, "VECTOR") == 0) {
        return synapse_launch_vector();
    }

    if (strcmp(section->key, "FORGE") == 0) {
        return synapse_launch_forge();
    }

    if (strcmp(section->key, "ANVIL") == 0) {
        return synapse_launch_anvil();
    }

    if (strcmp(section->key, "NEXUS") == 0) {
        return synapse_launch_nexus();
    }

    g_last_error = "Section entrypoint exists but is not wired.";
    return -1;
}

const char* synapse_get_last_launched_section(void)
{
    return g_last_launched_section;
}

const char* synapse_get_last_error(void)
{
    return g_last_error;
}
