import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/models/algorithm_category.dart';

class CategoryCard extends StatelessWidget {
  final AlgorithmCategory category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: category.color.withOpacity(0.1),
      child: InkWell(
        onTap: () => context.push(category.route),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(category.icon, size: 48, color: category.color),
              const SizedBox(height: 12),
              Text(
                category.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(category.description, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
