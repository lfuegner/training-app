import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A generic dropdown for header filters (e.g. "All" / "Group"),
/// styled with white background and rounded corners.
class HeaderDropdown<T> extends StatelessWidget {
  final T selectedValue;
  final List<T> items;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onChanged;

  const HeaderDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.headerWhite,
        borderRadius: BorderRadius.circular(24),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: selectedValue,
          icon: PhosphorIcon(
            PhosphorIcons.caretDown(),
            color: AppColors.headerDarkGreen,
            size: 18,
          ),
          style: const TextStyle(
            color: AppColors.headerDarkGreen,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          dropdownColor: AppColors.headerWhite,
          isDense: true,
          alignment: AlignmentDirectional.center,
          onChanged: (T? value) {
            if (value != null) {
              onChanged(value);
            }
          },
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              alignment: AlignmentDirectional.center,
              child: Text(labelBuilder(item)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
