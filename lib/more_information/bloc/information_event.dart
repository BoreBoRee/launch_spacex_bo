part of 'information_bloc.dart';

@immutable
abstract class InformationEvent {
  const InformationEvent();

  List<Object?> get props => [];
}

class InformationRequest extends InformationEvent {
  final LaunchProgram launchProgram;
  const InformationRequest({required this.launchProgram});
}
