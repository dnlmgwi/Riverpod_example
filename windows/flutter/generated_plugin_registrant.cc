//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <ble_peripheral/ble_peripheral_plugin_c_api.h>
#include <flutter_ble_peripheral/flutter_ble_peripheral_plugin_c_api.h>
#include <permission_handler_windows/permission_handler_windows_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  BlePeripheralPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("BlePeripheralPluginCApi"));
  FlutterBlePeripheralPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterBlePeripheralPluginCApi"));
  PermissionHandlerWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PermissionHandlerWindowsPlugin"));
}
