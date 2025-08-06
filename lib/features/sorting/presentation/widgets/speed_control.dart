import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/sorting_providers.dart';

class SpeedControl extends ConsumerWidget {
  const SpeedControl({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speed = ref.watch(animationSpeedProvider);

    return Row(
      children: [
        const Icon(Icons.speed),
        const SizedBox(width: 8),
        Expanded(
          child: Slider(
            value: speed,
            onChanged: (value) {
              ref.read(animationSpeedProvider.notifier).state = value;
              ref.read(sortingControllerProvider.notifier).setSpeed(value);
            },
            min: 0.0,
            max: 1.0,
            divisions: 10,
            label: '${(speed * 100).toInt()}%',
          ),
        ),
        SizedBox(width: 45, child: Text('${(speed * 100).toInt()}%', style: Theme.of(context).textTheme.bodySmall)),
      ],
    );
  }
}
