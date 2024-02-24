import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a state notifier class to manage permission status
class PermissionStatusNotifier extends StateNotifier<PermissionStatus> {
  PermissionStatusNotifier() : super(PermissionStatus.denied) {
    checkPermissionStatus();
  }

  // Function to check permission status and update the state
  Future<void> checkPermissionStatus() async {
    final status = await Permission.bluetooth.status;
    state = status;

  }

  // Function to request permission
  Future<void> requestPermission() async {
    final status = await Permission.bluetooth.request();
    state = status;
  }
}

// Define a provider for PermissionStatusNotifier
final permissionStatusProvider =
StateNotifierProvider<PermissionStatusNotifier, PermissionStatus>((ref) {
  return PermissionStatusNotifier();
});