import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:launch_spacex/bloc/info_bloc/information_bloc.dart';
import 'package:launch_spacex/bloc/launch_bloc/launch_bloc.dart';
import 'package:launch_spacex/data/models/launch.dart';
import 'package:launch_spacex/data/space_x_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockLaunch extends Mock implements LaunchProgram {}

class MockInformationRepository extends Mock
    implements InformationFetchRepository {}

String mockId = "5eb87d46ffd86e000604b388";
String launch = "5e9e4502f5090995de566f86";
String land = "5e9e3032383ecb6bb234e7ca";
String rocketId = "5e9d0d95eda69973a809d1ec";
void main() {
  group("Bloc Information Test", () {
    late MockInformationRepository repository;
    late InformationBloc informationBloc;
    late LaunchProgram launchProgram;
    late Rocket rocket;
    late List<LaunchPad> pad;
    late List<CrewInformation> crew;

    setUp(() {
      repository = MockInformationRepository();
      informationBloc = InformationBloc(repository);
      launchProgram = LaunchProgram();
      rocket = Rocket();
      pad = [LaunchPad(), LaunchPad()];
      crew = [CrewInformation()];
    });
    blocTest<InformationBloc, InformationState>(
      'get API when successful',
      build: () {
        // when(() => repository.getOneLaunchRepo(mockId))
        //     .thenAnswer((_) => Future.value(launchProgram));
        // when(() => repository.getLaunchPadAndLandPadRepo(launch, land))
        //     .thenAnswer((_) => Future.value(pad));
        // when(() => repository.getCrewInformationRepo(launchProgram.crew))
        //     .thenAnswer((_) => Future.value(crew));
        when(() => repository.getOneRocketRepo(rocketId))
            .thenAnswer((_) => Future.value(rocket));
        return informationBloc;
      },
      // wait: const Duration(milliseconds: 3000),
      skip: 1,
      act: (bloc) => bloc.add(InformationRequest(id: mockId)),
      expect: () => [
        informationBloc.state.copyWith(
            loading: false,
            launch: launchProgram,
            landAndLaunchPad: pad,
            crew: crew,
            rocket: rocket),
      ],
    );
    tearDown(() => informationBloc.close());
  });
}
