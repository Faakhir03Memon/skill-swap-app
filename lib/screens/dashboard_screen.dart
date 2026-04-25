import 'package:flutter/material.dart';
import 'architecture_graph_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skill Swap Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Skill Swap', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Profile'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Skill Match'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Exams & Leaderboard'),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.architecture),
              label: const Text('View Architecture Graph'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ArchitectureGraphScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
