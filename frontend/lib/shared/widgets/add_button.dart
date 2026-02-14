import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A floating action button with a plus icon for adding new items.
class AddButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String tooltip;

  const AddButton({
    super.key,
    required this.onPressed,
    this.tooltip = 'Add',
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      child: PhosphorIcon(
        PhosphorIcons.plus(PhosphorIconsStyle.fill),
        color: colorScheme.onPrimaryContainer,
      ),
    );
  }
}
