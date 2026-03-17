import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/common_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(title: 'My Profile', showBackButton: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 100, color: Colors.grey),
            SizedBox(height: 16),
            Text('User Profile', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
