import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/connectivity_provider.dart';
import '../../../screens/no_internet_screen.dart';

class ConnectivityWrapper extends StatelessWidget {
  const ConnectivityWrapper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (BuildContext context, ConnectivityProvider provider, Widget? _) {
        if (!provider.isConnected) {
          return const NoInternetScreen();
        }
        return child;
      },
    );
  }
}
