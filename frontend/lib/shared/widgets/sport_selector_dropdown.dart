import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/shared/models/sport.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A centered dropdown to select the current sport, styled with
/// white background and rounded corners for the header.
class SportSelectorDropdown extends StatelessWidget {
  final Sport selectedSport;
  final ValueChanged<Sport> onChanged;

  const SportSelectorDropdown({
    super.key,
    required this.selectedSport,
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
        child: DropdownButton<Sport>(
          value: selectedSport,
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
          onChanged: (Sport? sport) {
            if (sport != null) {
              onChanged(sport);
            }
          },
          items: Sport.values.map((Sport sport) {
            return DropdownMenuItem<Sport>(
              value: sport,
              alignment: AlignmentDirectional.center,
              child: Text(sport.displayName),
            );
          }).toList(),
        ),
      ),
    );
  }
}
