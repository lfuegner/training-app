import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

/// Displays a circular country flag for the given country code.
class NationalityFlag extends StatelessWidget {
  final String countryCode;
  final double size;

  const NationalityFlag({
    super.key,
    required this.countryCode,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: CountryFlag.fromCountryCode(
          countryCode,
          width: size,
          height: size,
        ),
      ),
    );
  }
}
