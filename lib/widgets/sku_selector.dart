import 'package:flutter/material.dart';

typedef OnSkuChanged = void Function(Map<String, String> selected, int quantity);

class SkuSelector extends StatefulWidget {
  final Map<String, List<String>> attributes;
  final OnSkuChanged? onChanged;

  const SkuSelector({super.key, required this.attributes, this.onChanged});

  @override
  State<SkuSelector> createState() => _SkuSelectorState();
}

class _SkuSelectorState extends State<SkuSelector> {
  late Map<String, String> _selected;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _selected = {};
    for (final key in widget.attributes.keys) {
      final list = widget.attributes[key]!;
      if (list.isNotEmpty) _selected[key] = list.first;
    }
  }

  void _notify() {
    widget.onChanged?.call(_selected, _quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final entry in widget.attributes.entries) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Wrap(
            spacing: 8,
            children: entry.value.map((option) {
              final selected = _selected[entry.key] == option;
              return ChoiceChip(
                label: Text(option),
                selected: selected,
                onSelected: (_) {
                  setState(() {
                    _selected[entry.key] = option;
                  });
                  _notify();
                },
              );
            }).toList(),
          ),
        ],
        const SizedBox(height: 12),
        Row(
          children: [
            const Text('数量', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () {
                if (_quantity > 1) {
                  setState(() => _quantity--);
                  _notify();
                }
              },
            ),
            Text('$_quantity'),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                setState(() => _quantity++);
                _notify();
              },
            ),
          ],
        ),
      ],
    );
  }
}
