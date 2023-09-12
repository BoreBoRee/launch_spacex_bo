import 'dart:async';
import '../data/models/launch.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/space_x_repository.dart';

part 'space_x_event.dart';
part 'space_x_state.dart';

class SpaceXBloc extends Bloc<SpaceXEvent, SpaceXState> {
  final _spaceXRepository = SpaceXRepository();

  SpaceXBloc() : super(SpaceXInitial());

  Stream<SpaceXState> mapEventToState(SpaceXEvent event) async* {
    if (event is LaunchRequest) {
      yield SpaceXLoading();

      try {
        final spaceXResponse = await _spaceXRepository.getLatestLaunch();
        yield SpaceXLoaded(launch: spaceXResponse);
      } catch (e) {
        yield SpaceXError(message: e.toString());
      }
    }
  }
}
