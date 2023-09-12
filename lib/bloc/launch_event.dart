part of 'launch_bloc.dart';

@immutable
abstract class SpaceXEvent {}

class LaunchRequest extends SpaceXEvent {
  LaunchRequest();
}
