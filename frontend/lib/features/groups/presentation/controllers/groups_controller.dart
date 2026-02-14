import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tab options for the Groups screen.
enum GroupsTab {
  groups('Groups'),
  friends('Friends');

  final String displayName;
  const GroupsTab(this.displayName);
}

/// Represents a group.
class Group {
  final String id;
  final String name;
  final String description;
  final int memberCount;
  final List<GroupMember> members;

  const Group({
    required this.id,
    required this.name,
    required this.description,
    required this.memberCount,
    required this.members,
  });
}

/// A member of a group.
class GroupMember {
  final String id;
  final String name;
  final String role;
  final String? avatarUrl;

  const GroupMember({
    required this.id,
    required this.name,
    required this.role,
    this.avatarUrl,
  });
}

/// Represents a friend.
class Friend {
  final String id;
  final String name;
  final String? avatarUrl;
  final String? lastActivity;

  const Friend({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.lastActivity,
  });
}

/// State for the Groups feature.
class GroupsState {
  final GroupsTab selectedTab;
  final List<Group> groups;
  final List<Friend> friends;
  final String? selectedGroupId;

  const GroupsState({
    this.selectedTab = GroupsTab.groups,
    this.groups = const [],
    this.friends = const [],
    this.selectedGroupId,
  });

  GroupsState copyWith({
    GroupsTab? selectedTab,
    List<Group>? groups,
    List<Friend>? friends,
    String? selectedGroupId,
  }) {
    return GroupsState(
      selectedTab: selectedTab ?? this.selectedTab,
      groups: groups ?? this.groups,
      friends: friends ?? this.friends,
      selectedGroupId: selectedGroupId ?? this.selectedGroupId,
    );
  }

  Group? get selectedGroup {
    if (selectedGroupId == null) return groups.isNotEmpty ? groups.first : null;
    final Iterable<Group> matches =
        groups.where((Group g) => g.id == selectedGroupId);
    return matches.isNotEmpty ? matches.first : null;
  }
}

/// Controller for the Groups feature.
class GroupsController extends StateNotifier<GroupsState> {
  GroupsController() : super(const GroupsState()) {
    _loadMockData();
  }

  void selectTab(GroupsTab tab) {
    state = state.copyWith(selectedTab: tab);
  }

  void selectGroup(String groupId) {
    state = state.copyWith(selectedGroupId: groupId);
  }

  void _loadMockData() {
    state = state.copyWith(
      groups: const [
        Group(
          id: 'grp1',
          name: 'Advanced Group A',
          description: 'Competitive tennis players, weekly training sessions',
          memberCount: 8,
          members: [
            GroupMember(id: 'm1', name: 'You', role: 'Member'),
            GroupMember(id: 'm2', name: 'Carlos Martinez', role: 'Member'),
            GroupMember(id: 'm3', name: 'Lucas Dupont', role: 'Member'),
            GroupMember(id: 'm4', name: 'Coach Becker', role: 'Coach'),
            GroupMember(id: 'm5', name: 'Max Mueller', role: 'Member'),
            GroupMember(id: 'm6', name: 'Marco Rossi', role: 'Member'),
          ],
        ),
        Group(
          id: 'grp2',
          name: 'Weekend Beach Volleyball',
          description: 'Casual weekend beach volleyball group',
          memberCount: 12,
          members: [
            GroupMember(id: 'm1', name: 'You', role: 'Admin'),
            GroupMember(id: 'm7', name: 'Joao Silva', role: 'Member'),
            GroupMember(id: 'm8', name: 'Andreas Svensson', role: 'Member'),
          ],
        ),
      ],
      friends: const [
        Friend(
            id: 'f1',
            name: 'Carlos Martinez',
            lastActivity: '2 hours ago'),
        Friend(
            id: 'f2',
            name: 'Lucas Dupont',
            lastActivity: 'Yesterday'),
        Friend(
            id: 'f3',
            name: 'Max Mueller',
            lastActivity: '3 days ago'),
        Friend(
            id: 'f4',
            name: 'Marco Rossi',
            lastActivity: 'Online'),
        Friend(
            id: 'f5',
            name: 'Kenji Tanaka',
            lastActivity: '1 week ago'),
      ],
    );
  }
}

/// Provider for the GroupsController.
final groupsControllerProvider =
    StateNotifierProvider<GroupsController, GroupsState>((Ref ref) {
  return GroupsController();
});
