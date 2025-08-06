import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/sorting/presentation/sorting_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', name: 'home', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/sorting', name: 'sorting', builder: (context, state) => const SortingScreen()),
    ],
  );
});
