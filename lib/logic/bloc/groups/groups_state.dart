part of 'groups_bloc.dart';

sealed class GroupsState extends Equatable {
  GroupsState({required final List<String> groups})
    : _hashCode = Object.hashAll(groups);

  final int _hashCode;

  List<String> get groups =>
      getIt<ApiConnectionRepository>().apiData.groups.data ?? const [];

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

  List<String> get unrecognizedGroups =>
      groups.where((final String group) {
        final parts = group.split('.');
        return parts.length != 3 &&
            group != fullUsersGroup &&
            group != adminsGroup;
      }).toList();
}

class GroupsInitial extends GroupsState {
  GroupsInitial() : super(groups: const []);

  @override
  List<Object> get props => [_hashCode];
}

class GroupsRefreshing extends GroupsState {
  GroupsRefreshing({required super.groups});

  @override
  List<Object> get props => [_hashCode];
}

class GroupsLoaded extends GroupsState {
  GroupsLoaded({required super.groups});

  @override
  List<Object> get props => [_hashCode];
}
