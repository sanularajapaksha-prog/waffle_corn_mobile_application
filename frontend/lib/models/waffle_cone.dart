/// Product model for the waffle cone ordering app.
class WaffleCone {
  final String id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final double price;
  final double rating;
  final int reviewCount;
  final bool isTrending;
  final int ordersToday;
  final List<String> productTypes;
  final Map<String, double> sizePricing;
  final List<String> tintOptions;
  final double tintPrice;

  const WaffleCone({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.isTrending,
    required this.ordersToday,
    required this.productTypes,
    required this.sizePricing,
    required this.tintOptions,
    required this.tintPrice,
  });
}
