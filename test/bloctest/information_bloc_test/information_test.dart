import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:launch_spacex/homepage_and_table/model/launch_program_model.dart';
import 'package:launch_spacex/more_information/bloc/information_bloc.dart';
import 'package:launch_spacex/more_information/model/crew_model.dart';
import 'package:launch_spacex/more_information/model/launch_pad_model.dart';
import 'package:launch_spacex/more_information/model/rocket_model.dart';
import 'package:launch_spacex/more_information/repository/crew_repository.dart';
import 'package:launch_spacex/more_information/repository/launch_one_repository.dart';
import 'package:launch_spacex/more_information/repository/pads_repository.dart';
import 'package:launch_spacex/more_information/repository/rocket_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockLaunch extends Mock implements LaunchProgram {}

class MockLaunchOneRepo extends Mock implements LaunchOneRepository {}

class MockCrewRepo extends Mock implements CrewRepository {}

class MockPadsRepo extends Mock implements PadsRepository {}

class MockRocketRepo extends Mock implements RocketRepository {}

String mockId = "5eb87d46ffd86e000604b388";
String launch = "5e9e4502f5090995de566f86";
String? land;
String rocketId = "5e9d0d95eda69973a809d1ec";

void main() {
  group("Bloc Information Test", () {
    late MockLaunchOneRepo launchOneRepository;
    late MockCrewRepo crewRepository;
    late MockPadsRepo padsRepository;
    late MockRocketRepo rocketRepository;
    late InformationBloc informationBloc;
    late LaunchProgram launchProgram;
    late Rocket rocket;
    late LaunchPad pad;
    late List<CrewInformation> crew;

    setUp(() {
      launchOneRepository = MockLaunchOneRepo();
      crewRepository = MockCrewRepo();
      padsRepository = MockPadsRepo();
      rocketRepository = MockRocketRepo();
      informationBloc = InformationBloc(launchOneRepository, crewRepository,
          padsRepository, rocketRepository);
      launchProgram = LaunchProgram(
        launchpad: "5e9e4502f5090995de566f86",
        crew: ["5ebf1b7323a9a60006e03a7b"],
        rocket: "5e9d0d95eda69973a809d1ec",
      );
      rocket = Rocket();
      pad = LaunchPad();
      crew = [CrewInformation()];
    });
    group('get all api', () {
      blocTest<InformationBloc, InformationState>(
        'get API when successful',
        build: () {
          when(() => padsRepository.launchRepository(launch))
              .thenAnswer((_) => Future.value(pad));
          when(() => crewRepository.getCrewInformationRepo(launchProgram.crew))
              .thenAnswer((_) => Future.value(crew));
          when(() => rocketRepository.getOneRocketRepo(rocketId))
              .thenAnswer((_) => Future.value(rocket));
          return informationBloc;
        },
        // wait: const Duration(milliseconds: 3000),
        skip: 1,
        act: (bloc) =>
            bloc.add(InformationRequest(launchProgram: launchProgram)),
        expect: () => [
          informationBloc.state.copyWith(
              loading: false,
              launch: launchProgram,
              landAndLaunchPad: pad,
              crew: crew,
              rocket: rocket),
        ],
      );
      // tearDown(() => informationBloc.close());
    });
  });
}
