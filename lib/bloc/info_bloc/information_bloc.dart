import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/launch.dart';
import '../../data/space_x_repository.dart';
import '../launch_bloc/launch_bloc.dart';

part 'information_event.dart';
part 'information_state.dart';

class InformationBloc extends Bloc<InformationEvent, InformationState> {
  // , required this.spaceXRepository
  final InformationFetchRepository spaceXInfoRepository;
  InformationBloc(this.spaceXInfoRepository)
      : super(InformationState(
            rocket: Rocket(),
            crew: const [],
            launch: LaunchProgram(),
            landAndLaunchPad: const [])) {
    on<InformationRequest>(_onGetInformation);
  }
  void _onGetInformation(
    InformationRequest event,
    Emitter<InformationState> emit,
  ) async {
    await _onLoadInformation(emit, event);
  }

  Future<void> _onLoadInformation(
    Emitter<InformationState> emit,
    InformationRequest event,
  ) async {
    emit(state.copyWith(
      loading: true,
    ));
    final launch = await spaceXInfoRepository.getOneLaunchRepo(event.id);
    final landAndLaunchPad = await spaceXInfoRepository
        .getLaunchPadAndLandPadRepo(launch.launchpad, launch.landpad);
    final crew = await spaceXInfoRepository.getCrewInformationRepo(launch.crew);
    final rocket = await spaceXInfoRepository.getOneRocketRepo(launch.rocket);
    // print("Got data: ${LatestLaunch.name}");
    emit(state.copyWith(
      loading: false,
      rocket: rocket,
      crew: crew,
      launch: launch,
      landAndLaunchPad: landAndLaunchPad,
    ));
    // emit(SpaceXLoaded(latestLaunch: LatestLaunch, listLaunch: LaunchList));

    // print("Error: $e");
    // emit(SpaceXError(message: e.toString()));
    //
  }
}
