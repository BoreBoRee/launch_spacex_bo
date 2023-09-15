import 'dart:async';
import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/launch_program_model.dart';

part 'launch_event.dart';
part 'launch_state.dart';

class SpaceXBloc extends Bloc<SpaceXEvent, SpaceXState> {
  // , required this.spaceXRepository
  final spaceXRepository;
  SpaceXBloc(this.spaceXRepository)
      : super(
            SpaceXState(latestLaunch: LaunchProgram(), listLaunch: const [])) {
    on<LaunchRequest>(onGetLaunch);
  }
  void onGetLaunch(
    SpaceXEvent event,
    Emitter<SpaceXState> emit,
  ) async {
    await _onLoadLaunch(emit);
  }

  Future<void> _onLoadLaunch(Emitter<SpaceXState> emit) async {
    emit(state.copyWith(
      loading: true,
    ));
    final LatestLaunch = await spaceXRepository.getLatestLaunch();
    final LaunchList = await spaceXRepository.getLaunchList();
    print("Got data: ${LatestLaunch.name}");
    emit(state.copyWith(
      loading: false,
      latestLaunch: LatestLaunch,
      listLaunch: LaunchList,
    ));
    // emit(SpaceXLoaded(latestLaunch: LatestLaunch, listLaunch: LaunchList));

    // print("Error: $e");
    // emit(SpaceXError(message: e.toString()));
    //
  }
}
