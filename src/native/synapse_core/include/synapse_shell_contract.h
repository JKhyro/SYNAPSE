#ifndef SYNAPSE_SHELL_CONTRACT_H
#define SYNAPSE_SHELL_CONTRACT_H

#ifdef _WIN32
#if defined(SYNAPSE_CORE_EXPORTS)
#define SYNAPSE_API __declspec(dllexport)
#else
#define SYNAPSE_API __declspec(dllimport)
#endif
#else
#define SYNAPSE_API
#endif

#ifdef __cplusplus
extern "C" {
#endif

SYNAPSE_API int synapse_get_contract_version(void);
SYNAPSE_API int synapse_get_section_count(void);
SYNAPSE_API const char* synapse_get_section_key(int index);
SYNAPSE_API const char* synapse_get_section_title(int index);
SYNAPSE_API const char* synapse_get_section_surface(int index);
SYNAPSE_API const char* synapse_get_section_presentation_mode(int index);
SYNAPSE_API const char* synapse_get_section_entry_symbol(int index);
SYNAPSE_API int synapse_launch_section(const char* section_key);
SYNAPSE_API int synapse_launch_cortex(void);
SYNAPSE_API int synapse_launch_vector(void);
SYNAPSE_API int synapse_launch_forge(void);
SYNAPSE_API int synapse_launch_anvil(void);
SYNAPSE_API int synapse_launch_nexus(void);
SYNAPSE_API const char* synapse_get_last_launched_section(void);
SYNAPSE_API const char* synapse_get_last_error(void);

#ifdef __cplusplus
}
#endif

#endif
