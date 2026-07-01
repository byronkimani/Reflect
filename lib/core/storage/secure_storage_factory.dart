import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Central factory for hardened secure storage options.
class SecureStorageFactory {
  SecureStorageFactory._();

  static const FlutterSecureStorage instance = FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
}
