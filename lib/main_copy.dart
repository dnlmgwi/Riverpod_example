import 'package:ble_peripheral/ble_peripheral.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/homescreen.dart';
import 'package:permission_handler/permission_handler.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp(),));

  String serviceRegister = "0000180F-0000-1000-8000-00805F9B34FB";

  // await BlePeripheral.initialize();

  await BlePeripheral.addService(
    BleService(
      uuid: serviceRegister,
      primary: true,
      characteristics: [
        BleCharacteristic(
          uuid: "87654321-4321-4321-4321-abcdef123456",
          properties: [
            CharacteristicProperties.read.index,
            CharacteristicProperties.notify.index
          ],
          value: null,
          permissions: [
            AttributePermissions.readable.index
          ],
        ),
      ],
    ),
  ).onError((error, stackTrace) => print(error));

  await BlePeripheral.initialize();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

