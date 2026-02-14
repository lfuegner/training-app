import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/groups/presentation/controllers/groups_controller.dart';
import 'package:frontend/shared/widgets/header_dropdown.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

@RoutePage()
class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GroupsState groupsState = ref.watch(groupsControllerProvider);
    final GroupsController controller =
        ref.read(groupsControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: HeaderDropdown<GroupsTab>(
          selectedValue: groupsState.selectedTab,
          items: GroupsTab.values,
          labelBuilder: (GroupsTab t) => t.displayName,
          onChanged: controller.selectTab,
        ),
      ),
      body: groupsState.selectedTab == GroupsTab.groups
          ? _buildGroupsView(context, ref, groupsState)
          : _buildFriendsView(context, groupsState),
    );
  }

  Widget _buildGroupsView(
    BuildContext context,
    WidgetRef ref,
    GroupsState groupsState,
  ) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    if (groupsState.groups.isEmpty) {
      return const Center(child: Text('No groups yet'));
    }
    return Column(
      children: [
        // Group selector chips
        SizedBox(
          height: 48,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: groupsState.groups.map((Group group) {
              final bool isSelected =
                  groupsState.selectedGroup?.id == group.id;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(group.name),
                  selected: isSelected,
                  onSelected: (_) => ref
                      .read(groupsControllerProvider.notifier)
                      .selectGroup(group.id),
                ),
              );
            }).toList(),
          ),
        ),
        // Group info and members
        if (groupsState.selectedGroup != null)
          Expanded(
            child: _buildGroupDetail(
                context, groupsState.selectedGroup!, colorScheme, textTheme),
          ),
      ],
    );
  }

  Widget _buildGroupDetail(
    BuildContext context,
    Group group,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Group info card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.name,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  group.description,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    PhosphorIcon(
                      PhosphorIcons.usersThree(),
                      size: 18,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${group.memberCount} members',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Members',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ...group.members.map((GroupMember member) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: colorScheme.primaryContainer,
              child: Text(
                member.name[0].toUpperCase(),
                style: TextStyle(color: colorScheme.onPrimaryContainer),
              ),
            ),
            title: Text(member.name),
            trailing: Chip(
              label: Text(
                member.role,
                style: textTheme.labelSmall,
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildFriendsView(BuildContext context, GroupsState groupsState) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    if (groupsState.friends.isEmpty) {
      return const Center(child: Text('No friends yet'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: groupsState.friends.length,
      itemBuilder: (BuildContext context, int index) {
        final Friend friend = groupsState.friends[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: colorScheme.secondaryContainer,
            child: Text(
              friend.name[0].toUpperCase(),
              style: TextStyle(color: colorScheme.onSecondaryContainer),
            ),
          ),
          title: Text(friend.name, style: textTheme.bodyLarge),
          subtitle: friend.lastActivity != null
              ? Text(
                  friend.lastActivity!,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                )
              : null,
          trailing: PhosphorIcon(
            PhosphorIcons.chatCircle(),
            color: colorScheme.onSurfaceVariant,
          ),
        );
      },
    );
  }
}
