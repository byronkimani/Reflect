import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// Fake [PathProviderPlatform] for widget/unit tests.
class FakePathProvider extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  FakePathProvider({
    required this.documentsPath,
    required this.supportPath,
  });

  final String documentsPath;
  final String supportPath;

  factory FakePathProvider.using(Directory directory) => FakePathProvider(
        documentsPath: directory.path,
        supportPath: directory.path,
      );

  @override
  Future<String?> getApplicationDocumentsPath() async => documentsPath;

  @override
  Future<String?> getApplicationSupportPath() async => supportPath;
}
