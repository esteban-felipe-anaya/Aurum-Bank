/// Centralised runtime configuration.
///
/// `baseUrl` can be overridden at build/run time without code changes:
///   flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000
class AppConfig {
  const AppConfig._();

  /// Base URL of the mock REST API.
  ///
  /// Defaults to localhost:3000 (json-server). On the Android emulator the
  /// host machine is reachable at 10.0.2.2 — pass it via --dart-define.
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );

  /// When true, the [ChaosInterceptor] injects artificial latency and
  /// occasional failures so loading/error states are exercised in dev.
  static const bool simulateNetworkConditions = bool.fromEnvironment(
    'SIMULATE_NETWORK',
    defaultValue: true,
  );

  /// Probability (0..1) that a request fails artificially.
  static const double simulatedErrorRate = 0.12;
}
