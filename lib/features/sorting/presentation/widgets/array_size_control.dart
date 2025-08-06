import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/sorting_providers.dart';

class ArraySizeControl extends ConsumerWidget {
  const ArraySizeControl({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = ref.watch(arraySizeProvider);

    return Row(
      children: [
        const Icon(Icons.data_array),
        const SizedBox(width: 8),
        Expanded(
          child: Slider(
            value: size.toDouble(),
            min: 10,
            max: 100,
            divisions: 9,
            label: size.toString(),
            onChanged: (value) {
              final newSize = value.toInt();
              ref.read(arraySizeProvider.notifier).state = newSize;
              ref.read(sortingControllerProvider.notifier).setArraySize(newSize);
            },
          ),
        ),
        SizedBox(width: 35, child: Text(size.toString(), style: Theme.of(context).textTheme.bodySmall)),
      ],
    );
  }
}
