import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'space_x_event.dart';
part 'space_x_state.dart';

class SpaceXBloc extends Bloc<SpaceXEvent, SpaceXState> {
  SpaceXBloc() : super(SpaceXInitial()) {
    on<SpaceXEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
