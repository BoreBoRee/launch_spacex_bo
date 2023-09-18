import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:launch_spacex/homepage_and_table/model/launch_program_model.dart';
import 'package:launch_spacex/more_information/model/crew_model.dart';
import 'package:launch_spacex/more_information/model/launch_pad_model.dart';
import 'package:launch_spacex/more_information/model/rocket_model.dart';
import 'package:launch_spacex/more_information/repository/crew_repository.dart';
import 'package:launch_spacex/more_information/repository/launch_one_repository.dart';
import 'package:launch_spacex/more_information/repository/pads_repository.dart';
import 'package:launch_spacex/more_information/repository/rocket_repository.dart';
import 'package:meta/meta.dart';

part 'information_event.dart';

part 'information_state.dart';

class InformationBloc extends Bloc<InformationEvent, InformationState> {
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
          landAndLaunchPad: LaunchPad(),
        )) {
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

    final landAndLaunchPad =
        await padsRepository.launchRepository(event.launchProgram.launchpad);
    final crew =
        await crewRepository.getCrewInformationRepo(event.launchProgram.crew);
    final rocket =
        await rocketRepository.getOneRocketRepo(event.launchProgram.rocket);

    emit(state.copyWith(
      loading: false,
      rocket: rocket,
      crew: crew,
      launch: event.launchProgram,
      landAndLaunchPad: landAndLaunchPad,
    ));
  }
}
