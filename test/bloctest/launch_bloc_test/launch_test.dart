import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:launch_spacex/homepage_and_table/bloc/launch_bloc.dart';
import 'package:launch_spacex/homepage_and_table/model/launch_program_model.dart';
import 'package:launch_spacex/homepage_and_table/repository/spaceX_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockLaunch extends Mock implements LaunchProgram {}

class MockSpaceXRepository extends Mock implements SpaceXRepository {}

void main() {
  group("Bloc Launch Test", () {
    late MockSpaceXRepository repository;
    late SpaceXBloc spaceXBloc;
    late LaunchProgram latestLaunchMock;
    late List<LaunchProgram> launchListMock;
    setUp(() {
      repository = MockSpaceXRepository();
      spaceXBloc = SpaceXBloc(repository);
      latestLaunchMock = LaunchProgram();
      launchListMock = [LaunchProgram()];
    });
    blocTest<SpaceXBloc, SpaceXState>(
      'emits [SpaceXLoading, SpaceXLoaded] when successful',
      build: () {
        when(() => repository.getLatestLaunch())
            .thenAnswer((_) => Future.value(latestLaunchMock));
        when(() => repository.getLaunchList())
            .thenAnswer((_) => Future.value(launchListMock));
        return spaceXBloc;
      },
      wait: const Duration(milliseconds: 3000),
      skip: 1,
      act: (bloc) => bloc.add(const LaunchRequest()),
      expect: () => [
        spaceXBloc.state.copyWith(
            loading: false,
            latestLaunch: latestLaunchMock,
            listLaunch: launchListMock),
      ],
    );
    tearDown(() => spaceXBloc.close());
  });
  // group('Bloc Information Test', () {
  //   setUp(() => null)
  // });
}
