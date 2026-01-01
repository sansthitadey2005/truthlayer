import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TruthLayer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to TruthLayer',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'A minimal trust pipeline prototype to verify and validate digital evidence.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // future backend integration
              },
              child: const Text('Submit Evidence'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // future backend integration
              },
              child: const Text('Check Verification Status'),
            ),
          ],
        ),
      ),
    );
  }
}
