import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/models/algorithm_category.dart';
import 'widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      AlgorithmCategory(
        title: 'Sorting',
        description: 'Bubble, Quick, Merge, Heap Sort',
        icon: Icons.sort,
        color: Colors.blue,
        route: '/sorting',
      ),
      AlgorithmCategory(
        title: 'Searching',
        description: 'Linear, Binary, Interpolation Search',
        icon: Icons.search,
        color: Colors.green,
        route: '/searching',
      ),
      AlgorithmCategory(
        title: 'Pathfinding',
        description: 'DFS, BFS, Dijkstra, A*',
        icon: Icons.route,
        color: Colors.purple,
        route: '/pathfinding',
      ),
      AlgorithmCategory(
        title: 'Graph',
        description: 'Traversal, MST, Shortest Path',
        icon: Icons.hub,
        color: Colors.orange,
        route: '/graph',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Algorithm Visualizer'),
        actions: [IconButton(icon: const Icon(Icons.settings), onPressed: () => context.push('/settings'))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose a Category', style: Theme.of(context).textTheme.headlineMedium).animate().fadeIn().slideX(),
            const SizedBox(height: 8),
            Text(
              'Interactive visualizations to understand algorithms',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ).animate().fadeIn(delay: 100.ms),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryCard(
                    category: category,
                  ).animate().fadeIn(delay: (100 * (index + 1)).ms).scale(delay: (100 * (index + 1)).ms);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
