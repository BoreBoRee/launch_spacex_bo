part of 'information_bloc.dart';

// @immutable
// abstract class InformationState {}
//
// class InformationInitial extends InformationState {}
// // class InformationInitial extends InformationState {}
//
// class InformationLoading extends InformationState {}
//
// class InformationLoaded extends InformationState {
//   final launch;
//   final rocket;
//   final crew;
//   final landAndLaunchPad;
//   InformationLoaded(
//       {required this.rocket,
//       required this.crew,
//       required this.launch,
//       required this.landAndLaunchPad});
// }
//
// class InformationError extends InformationState {
//   final String message;
//   // print(message);
//   InformationError({required this.message}) {
//     print(message);
//   }
// }

class InformationState extends Equatable {
  final LaunchProgram launch;
  final Rocket rocket;
  final List<CrewInformation> crew;
  final List<LaunchPad> landAndLaunchPad;
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
      List<LaunchPad>? landAndLaunchPad}) {
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
