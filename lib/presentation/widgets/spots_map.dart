import 'package:app/domain/core/common/constants.dart';
import 'package:app/domain/core/common/controllers/delayed_replacable_action_controller.dart';
import 'package:app/domain/core/common/global_blocs_mixin.dart';
import 'package:app/domain/core/common/root_navigator.dart';
import 'package:app/domain/models/map_cluster_model.dart';
import 'package:app/domain/models/workout_spot_model.dart';
import 'package:app/presentation/pages/map_clusters/map_clusters_cubit.dart';
import 'package:app/presentation/pages/spot_details/spot_details_arguments.dart';
import 'package:app/presentation/routing/dashboard_tabs/spots_routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpotsMap extends StatefulWidget {
  final List<MapClusterModel> clusters;
  final void Function(WorkoutSpotModel) onSpotIconPressed;

  const SpotsMap({
    required this.clusters,
    required this.onSpotIconPressed,
  });

  @override
  State<SpotsMap> createState() => _SpotsMapState();
}

class _SpotsMapState extends State<SpotsMap> with GlobalBlocsMixin {
  final DelayedReplacableActionController _maPositionReationController =
      DelayedReplacableActionController.withDefaultDuration();

  MapClustersCubit get _mapClustersCubit => BlocProvider.of<MapClustersCubit>(context);

  @override
  void dispose() {
    _maPositionReationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _mapClustersCubit.mapCoordinator.buildMapWithSpots(
      context,
      clusters: widget.clusters,
      mapEssentials: Constants.maps.essentials,
      onPositionChanged: () => _maPositionReationController.replaceAction(_updateMapClusters),
      onSpotPressed: _goToSpotDetails,
    );
  }

  void _updateMapClusters() {
    spotsCubit.state.maybeMap(
      fetchSpotsSuccess: (state) => _mapClustersCubit.updateClusters(
        spots: state.spots,
      ),
      orElse: () {
        // No implementation needed
      },
    );
  }

  void _goToSpotDetails(WorkoutSpotModel spot) => RootNavigator.of(context).pushNamed(
        SpotsRouting.spotDetails,
        arguments: SpotDetailsArguments(
          spot: spot,
        ),
      );
}