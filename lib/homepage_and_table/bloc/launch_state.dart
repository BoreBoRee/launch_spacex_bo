part of 'launch_bloc.dart';

// @immutable
// abstract class SpaceXState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }
//
// class SpaceXInitial extends SpaceXState {}
//
// class SpaceXLoading extends SpaceXState {}
//
// class SpaceXLoaded extends SpaceXState {
//   final LaunchProgram latestLaunch;
//   final List<dynamic> listLaunch;
//
//   SpaceXLoaded({required this.latestLaunch, required this.listLaunch});
//
//   @override
//   List<Object?> get props => [latestLaunch, listLaunch];
// }
//
// class SpaceXError extends SpaceXState {
//   final String message;
//
//   // print(message);
//   SpaceXError({required this.message}) {
//     print(message);
//   }
//
//   @override
//   List<Object?> get props => [message];
// }

class SpaceXState extends Equatable {
  final LaunchProgram latestLaunch;
  final List<LaunchProgram> listLaunch;
  final bool loading;

  const SpaceXState(
      {this.loading = false,
      required this.latestLaunch,
      required this.listLaunch});

  SpaceXState copyWith(
      {bool? loading,
      LaunchProgram? latestLaunch,
      List<LaunchProgram>? listLaunch}) {
    return SpaceXState(
        loading: loading ?? this.loading,
        latestLaunch: latestLaunch ?? this.latestLaunch,
        listLaunch: listLaunch ?? this.listLaunch);
  }

  @override
  List<Object?> get props => [
        loading,
        latestLaunch,
        listLaunch,
      ];
}
