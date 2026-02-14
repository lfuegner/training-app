import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GameHistoryScreen extends StatelessWidget {
  const GameHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game History')),
      body: const Center(
        child: Text('Past games history'),
      ),
    );
  }
}
