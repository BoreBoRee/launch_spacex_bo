part of 'space_x_bloc.dart';

@immutable
abstract class SpaceXState {}

class SpaceXInitial extends SpaceXState {}

class SpaceXLoading extends SpaceXState {}

class SpaceXLoaded extends SpaceXState {
  final Launch launch;
  SpaceXLoaded({required this.launch});
}

class SpaceXError extends SpaceXState {
  final String message;
  SpaceXError({required this.message});
}
