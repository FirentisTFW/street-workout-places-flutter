import 'package:app/domain/core/common/bloc_page_state.dart';
import 'package:app/domain/core/extensions/extensions.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/infrastructure/networking/models/surface.dart';
import 'package:app/infrastructure/networking/models/workout_spot_size.dart';
import 'package:app/presentation/pages/new_spot/equipment/new_spot_equipment_arguments.dart';
import 'package:app/presentation/pages/new_spot/form/new_spot_form_cubit.dart';
import 'package:app/presentation/pages/new_spot/form/widgets/new_spot_coordinates_section.dart';
import 'package:app/presentation/routing/dashboard_tabs/form_routing.dart';
import 'package:app/presentation/styles/app_dimensions.dart';
import 'package:app/presentation/styles/app_padding.dart';
import 'package:app/presentation/styles/app_text_styles.dart';
import 'package:app/presentation/widgets/app_app_bar.dart';
import 'package:app/presentation/widgets/app_text_field.dart';
import 'package:app/presentation/widgets/button.dart';
import 'package:app/presentation/widgets/dropdown_menu/app_dropdown_menu_item.dart';
import 'package:app/presentation/widgets/dropdown_menu/dropdown_item_style.dart';
import 'package:app/presentation/widgets/dropdown_menu/dropdown_menu.dart' as app;
import 'package:app/presentation/widgets/form_gesture_detector.dart';
import 'package:app/presentation/widgets/space.dart';
import 'package:app/presentation/widgets/widget_with_possible_error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewSpotFormPage extends StatefulWidget {
  const NewSpotFormPage({
    super.key,
  });

  @override
  State<NewSpotFormPage> createState() => _NewSpotFormPageState();
}

class _NewSpotFormPageState extends BlocPageState<NewSpotFormPage, NewSpotFormCubit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: BlocConsumer<NewSpotFormCubit, NewSpotFormState>(
          listener: _onStateChanged,
          builder: (_, __) {
            return FormGestureDetector(
              child: SingleChildScrollView(
                padding: AppPadding.defaultAll,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildNameTextField(),
                    _buildSizeAndSurfaceSelectors(),
                    _buildCoordinatesSection(),
                    ..._buildAddressSection(),
                    _buildDescriptionTextField(),
                    _buildRequiredFieldInformation(),
                    _buildNextButton(),
                  ].separatedBy(
                    const Space.vertical(20.0),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onStateChanged(BuildContext context, NewSpotFormState state) {
    if (state is NewSpotFormValidationSuccessful) {
      Navigator.pushNamed(
        context,
        FormRouting.equipment,
        arguments: NewSpotEquipmentArguments(
          formData: state.formData,
        ),
      );
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppAppBar(
      title: S.of(context).newSpotFormAppBarTitle,
    );
  }

  Widget _buildNameTextField() {
    return AppTextField(
      bloc.nameTFE,
      labelText: S.of(context).name,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildSizeAndSurfaceSelectors() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: _buildSizeSelector(),
        ),
        const Space.horizontal(20.0),
        Flexible(
          child: _buildSurfaceSelector(),
        ),
      ],
    );
  }

  Widget _buildCoordinatesSection() {
    return ValueListenableBuilder(
      valueListenable: bloc.mapPositionNotifier.notifier,
      builder: (_, mapPosition, __) => WidgetWithPossibleErrorMessage(
        errorMessage: bloc.mapPositionNotifier.provideErrorMessageIfShouldBeDisplayed(S.of(context)),
        child: NewSpotCoordinatesSection(
          bloc: bloc,
          mapPosition: mapPosition,
        ),
      ),
    );
  }

  Widget _buildSizeSelector() {
    return ValueListenableBuilder(
      valueListenable: bloc.sizeNotifier.notifier,
      builder: (context, size, _) {
        return WidgetWithPossibleErrorMessage(
          errorMessage: bloc.sizeNotifier.provideErrorMessageIfShouldBeDisplayed(S.of(context)),
          key: ValueKey(bloc.sizeNotifier),
          child: app.DropdownMenu<WorkoutSpotSize>(
            dropdownItemStyle: DropdownItemStyle(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius.basic),
            ),
            value: size,
            items: WorkoutSpotSize.values
                .map(
                  (size) => AppDropdownMenuItem<WorkoutSpotSize>(
                    text: size.getDescription(S.of(context)),
                    value: size,
                  ),
                )
                .toList(),
            placeholderText: S.of(context).size,
            shouldAlwaysDisplayPlaceholder: true,
            onItemSelected: (value) => bloc.sizeNotifier.value = value,
          ),
        );
      },
    );
  }

  Widget _buildSurfaceSelector() {
    return ValueListenableBuilder(
      valueListenable: bloc.surfaceNotifier.notifier,
      builder: (context, surface, _) {
        return WidgetWithPossibleErrorMessage(
          errorMessage: bloc.surfaceNotifier.provideErrorMessageIfShouldBeDisplayed(S.of(context)),
          key: ValueKey(bloc.surfaceNotifier),
          child: app.DropdownMenu<Surface>(
            dropdownItemStyle: DropdownItemStyle(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius.basic),
            ),
            value: surface,
            items: Surface.values
                .map(
                  (surface) => AppDropdownMenuItem<Surface>(
                    text: surface.getDescription(S.of(context)),
                    value: surface,
                  ),
                )
                .toList(),
            placeholderText: S.of(context).surface,
            shouldAlwaysDisplayPlaceholder: true,
            onItemSelected: (value) => bloc.surfaceNotifier.value = value,
          ),
        );
      },
    );
  }

  List<Widget> _buildAddressSection() {
    return [
      _buildCityTextField(),
      Row(
        children: [
          Flexible(
            flex: 2,
            child: _buildStreetTextField(),
          ),
          const Space.horizontal(20.0),
          Flexible(
            child: _buildHouseNumberTextField(),
          ),
        ],
      ),
    ];
  }

  Widget _buildCityTextField() {
    return AppTextField(
      bloc.cityTFE,
      keyboardType: TextInputType.name,
      labelText: S.of(context).city,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildStreetTextField() {
    return AppTextField(
      bloc.streetTFE,
      keyboardType: TextInputType.streetAddress,
      labelText: S.of(context).street,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildHouseNumberTextField() {
    return AppTextField(
      bloc.houseNumberTFE,
      keyboardType: TextInputType.number,
      labelText: S.of(context).hosueNumber,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildDescriptionTextField() {
    return AppTextField(
      bloc.descriptionTFE,
      keyboardType: TextInputType.multiline,
      labelText: S.of(context).description,
      minLines: 6,
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildRequiredFieldInformation() {
    return Text(
      S.of(context).newSpotFormRequiredFieldInformation,
      style: AppTextStyles.content(),
    );
  }

  Widget _buildNextButton() {
    return Button(
      S.of(context).next,
      onPressed: bloc.proceedToNextStep,
    );
  }
}
