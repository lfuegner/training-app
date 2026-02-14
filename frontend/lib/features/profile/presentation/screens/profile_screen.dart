import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileCard(context, colorScheme, textTheme),
          const SizedBox(height: 24),
          _buildSectionTitle(textTheme, 'Groups'),
          const SizedBox(height: 8),
          _buildGroupsList(context, colorScheme, textTheme),
          const SizedBox(height: 24),
          _buildMenuTile(
            context,
            icon: PhosphorIcons.gear(),
            title: 'Settings',
            onTap: () {},
          ),
          _buildMenuTile(
            context,
            icon: PhosphorIcons.creditCard(),
            title: 'Subscription',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          _buildMenuTile(
            context,
            icon: PhosphorIcons.fileText(),
            title: 'Terms of Use',
            onTap: () {},
          ),
          _buildMenuTile(
            context,
            icon: PhosphorIcons.shieldCheck(),
            title: 'Privacy Policy',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          _buildLogOutButton(context, colorScheme),
        ],
      ),
    );
  }

  Widget _buildProfileCard(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: colorScheme.primaryContainer,
              child: Text(
                'JD',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Elo: 1485',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    'Member since Jan 2024',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: PhosphorIcon(
                PhosphorIcons.pencilSimple(),
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(TextTheme textTheme, String title) {
    return Text(
      title,
      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildGroupsList(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    // Mock groups from profile perspective
    final List<Map<String, String>> groups = [
      {'name': 'Advanced Group A', 'role': 'Member'},
      {'name': 'Weekend Beach Volleyball', 'role': 'Admin'},
    ];
    return Card(
      child: Column(
        children: groups.map((Map<String, String> group) {
          return ListTile(
            leading: PhosphorIcon(
              PhosphorIcons.usersThree(),
              color: colorScheme.primary,
            ),
            title: Text(group['name']!, style: textTheme.bodyLarge),
            trailing: Chip(
              label: Text(group['role']!, style: textTheme.labelSmall),
            ),
            onTap: () {},
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuTile(
    BuildContext context, {
    required PhosphorIconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: PhosphorIcon(icon, color: colorScheme.onSurfaceVariant),
      title: Text(title),
      trailing: PhosphorIcon(
        PhosphorIcons.caretRight(),
        color: colorScheme.onSurfaceVariant,
        size: 20,
      ),
      onTap: onTap,
    );
  }

  Widget _buildLogOutButton(BuildContext context, ColorScheme colorScheme) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Log out coming soon')),
          );
        },
        icon: PhosphorIcon(
          PhosphorIcons.signOut(),
          color: colorScheme.error,
        ),
        label: Text(
          'Log Out',
          style: TextStyle(color: colorScheme.error),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colorScheme.error),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
