enum Flavor { dev, stage, prod }

class DukoinFlavors {
  static DukoinFlavors? _instance;
  final Flavor _flavor;

  /// Private constructor
  DukoinFlavors._(this._flavor);

  /// Factory constructors for each flavor
  factory DukoinFlavors.dev() {
    _instance ??= DukoinFlavors._(Flavor.dev);
    return _instance!;
  }

  factory DukoinFlavors.stage() {
    _instance ??= DukoinFlavors._(Flavor.stage);
    return _instance!;
  }

  factory DukoinFlavors.prod() {
    _instance ??= DukoinFlavors._(Flavor.prod);
    return _instance!;
  }

  /// Access the current instance (throws if not initialized)
  static DukoinFlavors get instance {
    if (_instance == null) {
      throw Exception(
        "DukoinFlavors has not been initialized. "
        "Call one of the factory constructors first.",
      );
    }
    return _instance!;
  }

  /// Getters
  bool get isDev => _flavor == Flavor.dev;
  bool get isStage => _flavor == Flavor.stage;
  bool get isProd => _flavor == Flavor.prod;

  Flavor get flavor => _flavor;
}
