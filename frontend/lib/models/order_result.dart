enum PaymentMethod {
  card,
  cash,
  bankTransfer,
}

extension PaymentMethodLabel on PaymentMethod {
  String get label {
    switch (this) {
      case PaymentMethod.card:
        return 'Credit / Debit Card';
      case PaymentMethod.cash:
        return 'Cash on Delivery';
      case PaymentMethod.bankTransfer:
        return 'Account Transfer / Bank Transfer';
    }
  }

  bool get requiresSlip => this == PaymentMethod.bankTransfer;
}

class OrderResult {
  final String orderNumber;
  final PaymentMethod paymentMethod;
  final String? slipFileName;

  const OrderResult({
    required this.orderNumber,
    required this.paymentMethod,
    this.slipFileName,
  });

  bool get isBankTransfer => paymentMethod == PaymentMethod.bankTransfer;
}
