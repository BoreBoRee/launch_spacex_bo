part of 'information_bloc.dart';

class InformationState extends Equatable {
  final LaunchProgram launch;
  final Rocket rocket;
  final List<CrewInformation> crew;
  final LaunchPad landAndLaunchPad;
  final bool loading;
  const InformationState(
      {this.loading = false,
      required this.crew,
      required this.launch,
      required this.rocket,
      required this.landAndLaunchPad});

  InformationState copyWith(
      {bool? loading,
      LaunchProgram? launch,
      Rocket? rocket,
      List<CrewInformation>? crew,
      LaunchPad? landAndLaunchPad}) {
    return InformationState(
        loading: loading ?? this.loading,
        launch: launch ?? this.launch,
        rocket: rocket ?? this.rocket,
        crew: crew ?? this.crew,
        landAndLaunchPad: landAndLaunchPad ?? this.landAndLaunchPad);
  }

  @override
  List<Object?> get props => [
        loading,
        launch,
        rocket,
        crew,
      ];
}
