import 'package:app/application/blocs/filters/filters_cubit.dart';
import 'package:app/application/blocs/spots/spots_cubit.dart';
import 'package:app/domain/core/common/app_locales.dart';
import 'package:app/domain/core/errors/app_error.dart';
import 'package:app/domain/core/errors/ui_error.dart';
import 'package:app/domain/services/filters_validation_service.dart';
import 'package:app/domain/services/user_location_service.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/presentation/pages/spots/spots_page.dart';
import 'package:app/presentation/widgets/app_progress_indicator.dart';
import 'package:app/presentation/widgets/app_text_field.dart';
import 'package:app/presentation/widgets/error_view_big.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart';

import '../../helpers/mocks.dart';

void main() {
  late FiltersCubit filtersCubit;
  late SpotsCubit spotsCubit;

  setUp(() {
    filtersCubit = FiltersCubit(
      filtersValidator: FiltersValidationService(),
      userLocationService: UserLocationService(),
    );
    spotsCubit = MockSpotsCubit();

    when(() => spotsCubit.presentation).thenAnswer(
      (_) => const Stream.empty(),
    );
  });

  Widget provideTestablePage() {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
      ],
      supportedLocales: AppLocales.supportedLocales,
      home: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: spotsCubit,
          ),
          BlocProvider.value(
            value: filtersCubit,
          ),
        ],
        child: const SpotsPage(),
      ),
    );
  }

  group('SpotsPageTest -', () {
    patrolTest(
      'When fetching spots is in progress, shows progress indicator',
      ($) async {
        when(() => spotsCubit.state).thenReturn(const SpotsFetchInProgress());

        await $.pumpWidget(provideTestablePage());
        await $.pump();

        expect(find.byType(AppProgressIndicator), equals(findsOneWidget));
      },
    );
    patrolTest(
      'When spots are fetched, shows a loaded page',
      ($) async {
        when(() => spotsCubit.state).thenReturn(
          const SpotsFetchSuccess(
            spots: [],
            filteredSpots: [],
          ),
        );

        await $.pumpWidgetAndSettle(provideTestablePage());

        expect(find.byType(AppTextField), equals(findsOneWidget));
        // expect(find.byType(PageView), equals(findsOneWidget));
        // expect(find.byType(SpotsMap), equals(findsOneWidget));
      },
    );
    patrolTest(
      'When fetching spots fails, shows error page',
      ($) async {
        when(() => spotsCubit.state).thenReturn(
          const SpotsFetchFailure(
            error: ContainerError(UnknownError()),
          ),
        );

        await $.pumpWidgetAndSettle(provideTestablePage());

        expect(find.byType(ErrorViewBig), equals(findsOneWidget));
      },
    );
  });
}
