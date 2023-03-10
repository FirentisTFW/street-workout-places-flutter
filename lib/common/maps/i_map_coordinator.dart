import 'package:app/common/maps/open_street_map/open_streeet_map_map_coordinator.dart';
import 'package:app/models/map_bounds_model.dart';
import 'package:app/models/map_cluster_model.dart';
import 'package:app/models/map_essentials.dart';
import 'package:app/models/workout_spot_model.dart';
import 'package:app/networking/models/map_position.dart';
import 'package:flutter/material.dart';

abstract class IMapCoordinator {
  const IMapCoordinator();

  static IMapCoordinator create() => OpenStreetMapMapCoordinator();

  MapBoundsModel? get bounds;

  double get zoom;

  Widget buildMapWithSpots(
    BuildContext context, {
    List<MapClusterModel> clusters,
    required MapEssentials mapEssentials,
    VoidCallback? onPositionChanged,
    void Function(WorkoutSpotModel)? onSpotPressed,
  });

  Widget buildSimpleMap(
    BuildContext context, {
    required MapEssentials mapEssentials,
    List<MapPosition> positions,
    VoidCallback? onPositionChanged,
    void Function(MapPosition)? onPositionSelected,
  });

  void close();

  void moveToPosition(MapPosition position);
}
