class AppFormatters {
  AppFormatters._();

  static String currency(double amount) {
    final hasDecimals = amount % 1 != 0;
    return 'Rs. ${amount.toStringAsFixed(hasDecimals ? 2 : 0)}';
  }
}
