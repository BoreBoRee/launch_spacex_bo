part of 'launch_bloc.dart';

@immutable
abstract class SpaceXState {}

class SpaceXInitial extends SpaceXState {}

class SpaceXLoading extends SpaceXState {}

class SpaceXLoaded extends SpaceXState {
  final LaunchProgram latestLaunch;
  final List<dynamic> listLaunch;
  SpaceXLoaded({required this.latestLaunch, required this.listLaunch});
}

class SpaceXError extends SpaceXState {
  final String message;
  // print(message);
  SpaceXError({required this.message}) {
    print(message);
  }
}
