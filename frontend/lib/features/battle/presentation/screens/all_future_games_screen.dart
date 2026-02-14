import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AllFutureGamesScreen extends StatelessWidget {
  const AllFutureGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upcoming Games')),
      body: const Center(
        child: Text('All future games'),
      ),
    );
  }
}
