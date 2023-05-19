class AppDimensions {
  const AppDimensions._();

  // TODO Move to _Height and fix default height in AdaptiveButton
  static const double actionButtonHeight = 50.0;

  static final _BorderRadius borderRadius = _BorderRadius();
  static final _Height height = _Height();
  static final _Size size = _Size();
}

class _BorderRadius {
  final double basic = 20.0;
  final double tabBarButton = 20.0;
}

class _Height {
  final double actionButton = 50.0;
  final double bottomNavgationBar = 70.0;
  final double newSpotImageCell = 160.0;
}

class _Size {
  final double floatingActionButtonIcon = 30.0;
  final double mapIcon = 40.0;
}
