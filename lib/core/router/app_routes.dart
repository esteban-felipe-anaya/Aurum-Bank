/// Centralised route paths and names for type-safe navigation.
abstract final class AppRoutes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';

  static const dashboard = '/';
  static const transactions = '/transactions';
  static const cards = '/cards';
  static const insights = '/insights';
  static const settings = '/settings';

  static const transfer = '/transfer';
  static const notifications = '/notifications';
  static const addCard = '/add-card';

  static String transactionDetail(String id) => '/transactions/$id';
  static String cardDetail(String id) => '/cards/$id';
}
