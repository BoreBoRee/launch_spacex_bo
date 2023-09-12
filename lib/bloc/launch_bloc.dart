import 'dart:async';
import '../data/models/launch.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/space_x_repository.dart';

part 'launch_event.dart';
part 'launch_state.dart';

class SpaceXBloc extends Bloc<SpaceXEvent, SpaceXState> {
  final _spaceXRepository = SpaceXRepository();

  SpaceXBloc() : super(SpaceXInitial()) {
    on<LaunchRequest>((event, emit) async {
      emit(SpaceXLoading());
      try {
        final LatestLaunch = await _spaceXRepository.getLatestLaunch();
        final LaunchList = await _spaceXRepository.getLaunchList();
        emit(SpaceXLoaded(latestLaunch: LatestLaunch, listLaunch: LaunchList));
      } catch (e) {
        print("Error: $e");
        emit(SpaceXError(message: e.toString()));
      }
    });
  }

  // Stream<SpaceXState> mapEventToState(SpaceXEvent event) async* {
  //   if (event is LaunchRequest) {
  //     yield SpaceXLoading();
  //
  //     try {
  //       final spaceXResponse = await _spaceXRepository.getLatestLaunch();
  //       yield SpaceXLoaded(launch: spaceXResponse);
  //     } catch (e) {
  //       yield SpaceXError(message: e.toString());
  //     }
  //   }
  // }
}
