import 'package:flutter/material.dart';

/// Semantic color tokens for the XTraining app.
class AppColors {
  const AppColors._();

  // Seed color for Material 3 color scheme generation
  static const Color seedColor = Color(0xFF0D9488); // Teal 600

  // Header colors
  static const Color headerDarkGreen = Color(0xFF14532D);
  static const Color headerWhite = Colors.white;

  // Navigation bar background: 98% white + 2% green tint
  static const Color navBarBackground = Color(0xFFF9FBF9);

  // Game result indicators
  static const Color winGreen = Color(0xFF22C55E);
  static const Color lossRed = Color(0xFFEF4444);
  static const Color drawGrey = Color(0xFF9CA3AF);

  // RSVP status colors
  static const Color attendingGreen = Color(0xFF16A34A);
  static const Color notAttendingRed = Color(0xFFDC2626);
  static const Color undecidedAmber = Color(0xFFF59E0B);

  // Badge colors for game types
  static const Color trainingBadge = Color(0xFF3B82F6);
  static const Color ratedBadge = Color(0xFFF97316);
  static const Color tournamentBadge = Color(0xFF8B5CF6);
}
