import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../homepage_and_table/model/launch_program_model.dart';
import '../model/crew_model.dart';
import '../model/launch_pad_model.dart';
import '../model/rocket_model.dart';
import '../repository/crew_repository.dart';
import '../repository/launch_one_repository.dart';
import '../repository/pads_repository.dart';
import '../repository/rocket_repository.dart';
part 'information_event.dart';

part 'information_state.dart';

class InformationBloc extends Bloc<InformationEvent, InformationState> {
  // , required this.spaceXRepository
  // final InformationFetchRepository spaceXInfoRepository;
  final RocketRepository rocketRepository;
  final LaunchOneRepository launchOneRepository;
  final CrewRepository crewRepository;
  final PadsRepository padsRepository;

  InformationBloc(this.launchOneRepository, this.crewRepository,
      this.padsRepository, this.rocketRepository)
      : super(InformationState(
            rocket: Rocket(),
            crew: const [],
            launch: LaunchProgram(),
            landAndLaunchPad: LaunchPad())) {
    on<InformationRequest>(onGetInformation);
  }

  void onGetInformation(
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
    print('1');
    // final LaunchProgram launch =
    //     await launchOneRepository.getOneLaunchRepo(event.id);
    print('2 Launch: ${event.launchProgram.id}');

    final landAndLaunchPad =
        await padsRepository.launchRepository(event.launchProgram.launchpad);
    print('3');
    final crew =
        await crewRepository.getCrewInformationRepo(event.launchProgram.crew);
    print('4');
    final rocket =
        await rocketRepository.getOneRocketRepo(event.launchProgram.rocket);
    print('5');
    // await Future.wait([launch, landAndLaunchPad, crew, rocket]).then((value){
    //
    // });
    emit(state.copyWith(
      loading: false,
      rocket: rocket,
      crew: crew,
      launch: event.launchProgram,
      landAndLaunchPad: landAndLaunchPad,
    ));
  }
}
