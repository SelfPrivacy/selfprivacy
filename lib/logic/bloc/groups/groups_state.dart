part of 'groups_bloc.dart';

sealed class GroupsState extends Equatable {
  GroupsState({required final List<String> groups})
    : groups = List.unmodifiable(groups);

  final List<String> groups;

  @override
  List<Object> get props => [groups];

  String get fullUsersGroup => 'sp.full_users';

  String get adminsGroup => 'sp.admins';

  bool get isEmpty => groups.isEmpty;

  Map<String, Map<String, String>> get serviceGroups {
    final Map<String, Map<String, String>> serviceGroups = {};
    for (final String group in groups.sorted()) {
      if (group == fullUsersGroup || group == adminsGroup) {
        continue;
      }
      final parts = group.split('.');
      if (parts.length == 3) {
        if (!serviceGroups.containsKey(parts[1])) {
          serviceGroups[parts[1]] = {};
        }
        serviceGroups[parts[1]]?[parts[2]] = group;
      }
    }
    return serviceGroups;
  }

  List<String> get unrecognizedGroups => groups.where((final String group) {
    final parts = group.split('.');
    return parts.length != 3 && group != fullUsersGroup && group != adminsGroup;
  }).toList();
}

class GroupsInitial extends GroupsState {
  GroupsInitial() : super(groups: const []);
}

class GroupsRefreshing extends GroupsState {
  GroupsRefreshing({required super.groups});
}

class GroupsLoaded extends GroupsState {
  GroupsLoaded({required super.groups});
}

class GroupsUnsupported extends GroupsState {
  GroupsUnsupported() : super(groups: const []);
}

class GroupsError extends GroupsState {
  GroupsError() : super(groups: const []);
}
