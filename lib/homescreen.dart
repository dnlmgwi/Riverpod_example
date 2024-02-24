import 'package:ble_peripheral/ble_peripheral.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_example/provider/permission_provider.dart';
import 'provider/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blePeripheral = ref.read(blePeripheralProvider);

    void startAdvertising() async {
      const serviceBattery = "12345678-1234-1234-1234-123456789abc";

      // Set callback for advertising state
      BlePeripheral.setAdvertingStartedCallback((String? error) {
        var advertisingState = ref.read(advertisingStateProvider.notifier);
        var advertisingError = ref.read(advertisingErrorProvider);

        if (error != null) {
          // print("AdvertisingFailed: $error");
          advertisingError = error;
          advertisingState.state = false;
        } else {
          // print("AdvertisingStarted");
          advertisingError = null;
          advertisingState.state = true;
        }
      });

      // Start advertising
      await BlePeripheral.startAdvertising(
        services: [serviceBattery],
        localName: "NX10",
      );
    }

    void stopAdvertising() async {
      // Stop advertising
      await BlePeripheral.stopAdvertising();

      // Update advertising state
      var advertisingState = ref.read(advertisingStateProvider.notifier);
      advertisingState.state = false;
    }

    final permissionStatus = ref.watch(permissionStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('NACIT BLE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
               startAdvertising();
              },
              child: const Text('Start BLE'),
            ),
            if (permissionStatus.isDenied)
              ElevatedButton(
                onPressed: () {
                  final permissionStatusNotifier =
                      ref.read(permissionStatusProvider.notifier);
                  permissionStatusNotifier.requestPermission();
                },
                child: const Text('Request Bluetooth Permission'),
              ),
            if (permissionStatus.isRestricted)
              const Text(
                'Bluetooth access is restricted by the OS.',
                style: TextStyle(color: Colors.red),
              ),
            if (permissionStatus.isRestricted || !permissionStatus.isGranted)
              ElevatedButton(
                onPressed: () {
                  openAppSettings();
                },
                child: const Text('Open Settings Permission'),
              ),
          ],
        ),
      ),
    );
  }
}
