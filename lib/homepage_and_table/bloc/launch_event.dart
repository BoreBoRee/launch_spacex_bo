part of 'launch_bloc.dart';

@immutable
abstract class SpaceXEvent extends Equatable {
  const SpaceXEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class LaunchRequest extends SpaceXEvent {
  const LaunchRequest();
}
