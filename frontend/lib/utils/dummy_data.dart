import '../models/waffle_cone.dart';

class DummyData {
  DummyData._();

  static const List<String> categories = [
    'Small Cone',
    'Regular Cone',
    'Large Cone',
    'Flavours',
    'Biscuits',
  ];

  static const List<WaffleCone> cones = [
    WaffleCone(
      id: 'small_cone',
      name: 'Small Cone',
      category: 'Small Cone',
      description: 'Compact waffle cone for light orders, school kiosks, and quick counter service.',
      imageUrl: 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=900&fit=crop',
      price: 25,
      rating: 4.7,
      reviewCount: 84,
      isTrending: true,
      ordersToday: 38,
      productTypes: ['Standard Small Cone', 'Rim Finish Small Cone'],
      sizePricing: {'Small Cone': 25},
      tintOptions: ['Natural', 'Chocolate Tint', 'Strawberry Tint'],
      tintPrice: 5,
    ),
    WaffleCone(
      id: 'regular_cone',
      name: 'Regular Cone',
      category: 'Regular Cone',
      description: 'Balanced waffle cone built for everyday service with a stable shape and clean presentation.',
      imageUrl: 'https://images.unsplash.com/photo-1570197571499-166b36435e9f?w=900&fit=crop',
      price: 35,
      rating: 4.8,
      reviewCount: 121,
      isTrending: true,
      ordersToday: 52,
      productTypes: ['Standard Regular Cone', 'Wide Mouth Regular Cone'],
      sizePricing: {'Regular Cone': 35},
      tintOptions: ['Natural', 'Vanilla Gold', 'Chocolate Tint', 'Berry Tint'],
      tintPrice: 5,
    ),
    WaffleCone(
      id: 'large_cone',
      name: 'Large Cone',
      category: 'Large Cone',
      description: 'Premium large waffle cone designed for generous scoops and higher-value presentation.',
      imageUrl: 'https://images.unsplash.com/photo-1551024601-bec78aea704b?w=900&fit=crop',
      price: 50,
      rating: 4.9,
      reviewCount: 97,
      isTrending: true,
      ordersToday: 44,
      productTypes: ['Classic Large Cone', 'Premium Rim Large Cone'],
      sizePricing: {'Large Cone': 50},
      tintOptions: ['Natural', 'Chocolate Tint', 'Strawberry Tint', 'Caramel Tint'],
      tintPrice: 8,
    ),
    WaffleCone(
      id: 'flavours',
      name: 'Flavours',
      category: 'Flavours',
      description: 'Flavor add-on selection for cone service with smooth scoop presentation and tint-ready finish.',
      imageUrl: 'https://images.unsplash.com/photo-1488900128323-21503983a07e?w=900&fit=crop',
      price: 50,
      rating: 4.8,
      reviewCount: 76,
      isTrending: false,
      ordersToday: 21,
      productTypes: ['Vanilla', 'Chocolate', 'Strawberry', 'Mango'],
      sizePricing: {'Standard Flavour': 50},
      tintOptions: ['Plain Finish', 'Chocolate Swirl', 'Strawberry Swirl'],
      tintPrice: 10,
    ),
    WaffleCone(
      id: 'biscuits',
      name: 'Biscuits',
      category: 'Biscuits',
      description: 'Biscuit add-ons for cone orders, suitable for topping support or side serving.',
      imageUrl: 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=900&fit=crop',
      price: 20,
      rating: 4.6,
      reviewCount: 63,
      isTrending: false,
      ordersToday: 19,
      productTypes: ['Butter Biscuit', 'Chocolate Biscuit', 'Wafer Bite'],
      sizePricing: {'Biscuit Pack': 20},
      tintOptions: ['Plain Coat', 'Chocolate Coat'],
      tintPrice: 5,
    ),
  ];

  static const List<Map<String, String>> onboardingSlides = [
    {
      'title': 'Choose your cone category',
      'description': 'Browse small, regular, large, flavour, and biscuit options in one focused catalog.',
    },
    {
      'title': 'Customize with type, size, and tint',
      'description': 'Review product type, apply optional tint selections, and see the live rupee total before checkout.',
    },
    {
      'title': 'Complete checkout your way',
      'description': 'Use cash, card UI, or account transfer with payment slip upload and verification tracking.',
    },
  ];

  static const List<Map<String, String>> notificationItems = [
    {'title': 'Order verified', 'body': 'Your last bank transfer order was approved and sent to preparation.'},
    {'title': 'Delivery update', 'body': 'Rider dispatched for order CC-20341.'},
    {'title': 'Support', 'body': 'Saved address change completed successfully.'},
  ];
}
