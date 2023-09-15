part of 'information_bloc.dart';

@immutable
abstract class InformationEvent {
  const InformationEvent();

  List<Object?> get props => [];
}

class InformationRequest extends InformationEvent {
  final String? id;
  const InformationRequest({required this.id});
}
