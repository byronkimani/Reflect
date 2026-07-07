// Checks that direct dependencies are up to date within pubspec constraints.
//
// Usage: dart run tool/check_outdated_deps.dart
// Exit 0 when all direct deps match their upgradable versions; exit 1 otherwise.

import 'dart:convert';
import 'dart:io';

String? _versionOf(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is Map<String, dynamic>) {
    return value['version'] as String?;
  }
  return null;
}

Future<void> main() async {
  final result = await Process.run(
    'dart',
    ['pub', 'outdated', '--json'],
    runInShell: true,
  );

  if (result.exitCode != 0) {
    stderr.writeln('Failed to run dart pub outdated');
    stderr.writeln(result.stderr);
    exit(result.exitCode);
  }

  final decoded = jsonDecode(result.stdout as String) as Map<String, dynamic>;
  final packages = decoded['packages'] as List<dynamic>? ?? [];

  final outdatedDirect = <String>[];
  final advisoryDirect = <String>[];

  for (final entry in packages) {
    final map = entry as Map<String, dynamic>;
    if (map['kind'] != 'direct') continue;

    final name = map['package'] as String;
    final current = _versionOf(map['current']);
    final upgradable = _versionOf(map['upgradable']);

    if (map['isCurrentAffectedByAdvisory'] == true) {
      advisoryDirect.add(name);
    }

    if (current == null || upgradable == null) continue;
    if (current != upgradable) {
      outdatedDirect.add('$name: $current -> $upgradable');
    }
  }

  if (advisoryDirect.isNotEmpty) {
    stderr.writeln('Direct dependencies affected by security advisories:');
    for (final name in advisoryDirect) {
      stderr.writeln('  - $name');
    }
  }

  if (outdatedDirect.isNotEmpty) {
    stderr.writeln('Outdated direct dependencies (run `make deps-upgrade`):');
    for (final line in outdatedDirect) {
      stderr.writeln('  - $line');
    }
  }

  if (advisoryDirect.isEmpty && outdatedDirect.isEmpty) {
    stdout.writeln('All direct dependencies are up to date.');
    exit(0);
  }

  exit(1);
}
