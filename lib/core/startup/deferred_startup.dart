import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/features/gcal/presentation/g_cal_sync_cubit.dart';
import 'package:reflect/features/notifications/notification_service.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:reflect/main.dart';

/// Non-critical startup: notifications, heartbeat sync, and GCal queue processing.
Future<void> runDeferredStartup({
  required NotificationService notifications,
  required SettingsCubit settings,
  required GCalSyncCubit gcalSync,
}) async {
  await notifications.init();
  await notifications.requestPermissions();
  await settings.scheduleStartupSync();
  unawaited(gcalSync.processQueue());
}

/// Runs [runDeferredStartup] after the first frame so [runApp] is not blocked.
class DeferredStartupRunner extends StatefulWidget {
  const DeferredStartupRunner({required this.child, super.key});

  final Widget child;

  @override
  State<DeferredStartupRunner> createState() => _DeferredStartupRunnerState();
}

class _DeferredStartupRunnerState extends State<DeferredStartupRunner> {
  var _started = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => unawaited(_run()));
  }

  Future<void> _run() async {
    if (_started || !mounted) return;
    _started = true;

    await runDeferredStartup(
      notifications: getIt<NotificationService>(),
      settings: context.read<SettingsCubit>(),
      gcalSync: context.read<GCalSyncCubit>(),
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
