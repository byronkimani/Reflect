import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/features/gcal/domain/repositories/gcal_repository.dart';
import 'package:reflect/features/gcal/presentation/g_cal_sync_cubit.dart';
import 'package:reflect/features/gcal/presentation/g_cal_sync_state.dart';

class MockGCalRepository extends Mock implements IGCalRepository {}

void main() {
  late MockGCalRepository mockRepository;
  late StreamController<int> queueDepthController;

  setUp(() {
    mockRepository = MockGCalRepository();
    queueDepthController = StreamController<int>();
    when(() => mockRepository.watchQueueDepth())
        .thenAnswer((_) => queueDepthController.stream);
  });

  tearDown(() {
    queueDepthController.close();
  });

  group('GCalSyncCubit', () {
    test('initial state and queue monitoring', () async {
      final cubit = GCalSyncCubit(mockRepository);
      expect(cubit.state, const GCalSyncState());
      
      queueDepthController.add(5);
      // Wait for stream to emit
      await Future.delayed(Duration.zero);
      expect(cubit.state.queueDepth, 5);
      
      cubit.close();
    });

    blocTest<GCalSyncCubit, GCalSyncState>(
      'signIn emits [isSyncing=true, isSignedIn=true] on success',
      build: () {
        when(() => mockRepository.signIn())
            .thenAnswer((_) async => const Right(unit));
        return GCalSyncCubit(mockRepository);
      },
      act: (cubit) => cubit.signIn(),
      expect: () => [
        const GCalSyncState(isSyncing: true),
        const GCalSyncState(isSyncing: false, isSignedIn: true),
      ],
    );

    blocTest<GCalSyncCubit, GCalSyncState>(
      'signIn emits [isSyncing=true, lastError] on failure',
      build: () {
        when(() => mockRepository.signIn())
            .thenAnswer((_) async => Left(ServerFailure(errorMessage: 'Login failed')));
        return GCalSyncCubit(mockRepository);
      },
      act: (cubit) => cubit.signIn(),
      expect: () => [
        const GCalSyncState(isSyncing: true),
        const GCalSyncState(isSyncing: false, lastError: 'Login failed'),
      ],
    );

    blocTest<GCalSyncCubit, GCalSyncState>(
      'signOut emits [isSyncing=true, isSignedIn=false] on success',
      build: () {
        when(() => mockRepository.signOut())
            .thenAnswer((_) async => const Right(unit));
        return GCalSyncCubit(mockRepository);
      },
      seed: () => const GCalSyncState(isSignedIn: true),
      act: (cubit) => cubit.signOut(),
      expect: () => [
        const GCalSyncState(isSignedIn: true, isSyncing: true),
        const GCalSyncState(isSignedIn: false, isSyncing: false),
      ],
    );

    blocTest<GCalSyncCubit, GCalSyncState>(
      'signOut emits [isSyncing=true, lastError] on failure',
      build: () {
        when(() => mockRepository.signOut())
            .thenAnswer((_) async => Left(ServerFailure(errorMessage: 'Logout failed')));
        return GCalSyncCubit(mockRepository);
      },
      seed: () => const GCalSyncState(isSignedIn: true),
      act: (cubit) => cubit.signOut(),
      expect: () => [
        const GCalSyncState(isSignedIn: true, isSyncing: true),
        const GCalSyncState(isSignedIn: true, isSyncing: false, lastError: 'Logout failed'),
      ],
    );

    blocTest<GCalSyncCubit, GCalSyncState>(
      'processQueue emits [isSyncing=true, isSyncing=false] on success',
      build: () {
        when(() => mockRepository.processQueue())
            .thenAnswer((_) async => const Right(unit));
        return GCalSyncCubit(mockRepository);
      },
      act: (cubit) => cubit.processQueue(),
      expect: () => [
        const GCalSyncState(isSyncing: true),
        const GCalSyncState(isSyncing: false),
      ],
    );

    blocTest<GCalSyncCubit, GCalSyncState>(
      'processQueue does not emit if already syncing',
      build: () => GCalSyncCubit(mockRepository),
      seed: () => const GCalSyncState(isSyncing: true),
      act: (cubit) => cubit.processQueue(),
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockRepository.processQueue());
      },
    );
  });
}
