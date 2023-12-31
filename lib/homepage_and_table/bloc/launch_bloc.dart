import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:launch_spacex/homepage_and_table/model/launch_program_model.dart';
import 'package:launch_spacex/homepage_and_table/repository/spaceX_repository.dart';
import 'package:meta/meta.dart';
part 'launch_event.dart';
part 'launch_state.dart';

class SpaceXBloc extends Bloc<SpaceXEvent, SpaceXState> {
  final SpaceXRepository spaceXRepository;

  SpaceXBloc(this.spaceXRepository)
      : super(SpaceXState(
          latestLaunch: LaunchProgram(),
          listLaunch: const [],
        )) {
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

    final latestLaunch = await spaceXRepository.getLatestLaunch();
    final launchList = await spaceXRepository.getLaunchList();

    emit(state.copyWith(
      loading: false,
      latestLaunch: latestLaunch,
      listLaunch: launchList,
    ));
  }
}
