import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/features/network/data/connectivity_bloc.dart';
import 'app_snackbar.dart';

class ConnectivityWrapper extends StatelessWidget {
  final Widget child;

  const ConnectivityWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listenWhen: (previous, current) {
        // Only react to actual changes between connected/disconnected
        return previous != current;
      },
      listener: (context, state) {
        state.whenOrNull(
          disconnected: () {
            AppSnackbar.showError(
              context,
              "No Internet Connection",
              duration: const Duration(
                days: 1,
              ), // Keep it visible until connected
            );
          },
          connected: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            AppSnackbar.showSuccess(context, "You are back online!");
          },
        );
      },
      child: child,
    );
  }
}
