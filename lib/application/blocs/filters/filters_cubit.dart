import 'package:app/application/blocs/filters/filters_form.dart';
import 'package:app/application/blocs/filters/filters_presentation_event.dart';
import 'package:app/domain/core/common/unique_prop_provider.dart';
import 'package:app/domain/core/errors/ui_error.dart';
import 'package:app/domain/core/errors/user_input/user_input_error.dart';
import 'package:app/domain/core/extensions/extensions.dart';
import 'package:app/domain/models/filters.dart';
import 'package:app/domain/services/filters_validation_service.dart';
import 'package:app/domain/services/user_location_service.dart';
import 'package:app/infrastructure/networking/models/map_position.dart';
import 'package:app/presentation/common/presentation_events.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filters_cubit.g.dart';
part 'filters_state.dart';

class FiltersCubit extends Cubit<FiltersState> with FiltersForm, BlocPresentationMixin {
  final FiltersValidationService filtersValidator;
  final UserLocationService userLocationService;

  FiltersCubit({
    required this.filtersValidator,
    required this.userLocationService,
  }) : super(const FiltersState.empty());

  @override
  Future<void> close() {
    disposeForm();
    return super.close();
  }

  Future<void> saveFilters() async {
    final MapPosition? userLocation;
    if (maxDistanceInKm != null) {
      // TODO Show something to the user before asking for location

      final bool hasLocationPermission = await userLocationService.checkAndRequestLocationPermissions();
      if (!hasLocationPermission) {
        emitPresentation(const FiltersMissingLocationPermission());
        return;
      }

      userLocation = await userLocationService.location;
      final UserInputError? validationException = filtersValidator.validate(
        maxDistanceInKm: maxDistanceInKm,
        userPosition: userLocation,
      );
      final bool isFormValid = validationException == null;

      if (!isFormValid) {
        emitPresentation(
          ValidationFailed(
            error: DialogError.fromException(validationException),
          ),
        );
        return;
      }
    } else {
      userLocation = null;
    }

    emit(
      FiltersState(
        filters: Filters(
          maxDistanceInKm: maxDistanceInKm,
          equipment: equipmentNotifiers.takeSelectedValues(),
          sizes: sizeNotifiers.takeSelectedValues(),
          surfaces: surfaceNotifiers.takeSelectedValues(),
          query: query,
        ),
        userPosition: userLocation,
      ),
    );
  }

  void clearFilters() {
    maxDistanceInKmTFE.clearText();
    queryTFE.clearText();

    for (final Iterable<ValueNotifier<bool>> notifierList in [
      equipmentNotifiers.values,
      sizeNotifiers.values,
      surfaceNotifiers.values,
    ]) {
      for (final ValueNotifier<bool> notifier in notifierList) {
        notifier.value = false;
      }
    }

    emit(
      const FiltersState.empty(),
    );
  }

  void updateQuery(String query) {
    queryController.updateQuery(
      query,
      action: () => emit(
        state.updateQuery(query.isBlank ? null : query),
      ),
    );
  }
}
