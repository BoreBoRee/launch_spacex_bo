part of 'launch_bloc.dart';

class SpaceXState extends Equatable {
  final LaunchProgram latestLaunch;
  final List<LaunchProgram> listLaunch;
  final bool loading;

  const SpaceXState({
    this.loading = false,
    required this.latestLaunch,
    required this.listLaunch,
  });

  SpaceXState copyWith(
      {bool? loading,
      LaunchProgram? latestLaunch,
      List<LaunchProgram>? listLaunch}) {
    return SpaceXState(
      loading: loading ?? this.loading,
      latestLaunch: latestLaunch ?? this.latestLaunch,
      listLaunch: listLaunch ?? this.listLaunch,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        latestLaunch,
        listLaunch,
      ];
}
