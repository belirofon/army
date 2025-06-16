import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/quest/presentation/screens/splash_screen.dart';
import 'features/quest/presentation/screens/home_screen.dart';

void main() {
  runApp(const ArmyGameApp());
}

class ArmyGameApp extends StatelessWidget {
  const ArmyGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _router = GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
      ],
    );

    return MaterialApp.router(
      title: 'Army Quest',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
    );
  }
}
