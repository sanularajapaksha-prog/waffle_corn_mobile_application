import 'package:flutter/material.dart';

import '../models/home_models.dart';
import '../models/waffle_cone.dart';
import 'dummy_data.dart';

class HomeMockData {
  HomeMockData._();

  static const locationLabel = 'Delivery to';
  static const locationValue = '45 Galle Road, Colombo 03';
  static const greeting = 'Hey Sanula, Good Afternoon!';

  static const List<HomeCategoryItem> categories = [
    HomeCategoryItem(label: 'All', icon: Icons.grid_view_rounded),
    HomeCategoryItem(
      label: 'Small Cone',
      icon: Icons.icecream_outlined,
      linkedCategory: 'Small Cone',
    ),
    HomeCategoryItem(
      label: 'Regular Cone',
      icon: Icons.local_mall_outlined,
      linkedCategory: 'Regular Cone',
    ),
    HomeCategoryItem(
      label: 'Large Cone',
      icon: Icons.workspace_premium_outlined,
      linkedCategory: 'Large Cone',
    ),
    HomeCategoryItem(
      label: 'Flavours',
      icon: Icons.palette_outlined,
      linkedCategory: 'Flavours',
    ),
    HomeCategoryItem(
      label: 'Biscuits',
      icon: Icons.cookie_outlined,
      linkedCategory: 'Biscuits',
    ),
  ];

  static const List<HomeProductItem> featuredProducts = [
    HomeProductItem(
      coneId: 'small_cone',
      title: 'Small Cone',
      subtitle: 'Compact service-ready waffle cone',
      imageUrl:
          'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=900&fit=crop',
      badge: 'Best for kiosks',
    ),
    HomeProductItem(
      coneId: 'regular_cone',
      title: 'Regular Cone',
      subtitle: 'Balanced cone for daily counter orders',
      imageUrl:
          'https://images.unsplash.com/photo-1570197571499-166b36435e9f?w=900&fit=crop',
      badge: 'Most ordered',
    ),
    HomeProductItem(
      coneId: 'large_cone',
      title: 'Large Cone',
      subtitle: 'Premium cone for generous dessert builds',
      imageUrl:
          'https://images.unsplash.com/photo-1551024601-bec78aea704b?w=900&fit=crop',
      badge: 'Premium choice',
    ),
    HomeProductItem(
      coneId: 'flavours',
      title: 'Flavours',
      subtitle: 'Vanilla, chocolate, strawberry, and mango',
      imageUrl:
          'https://images.unsplash.com/photo-1488900128323-21503983a07e?w=900&fit=crop',
      badge: 'Add-on selection',
    ),
    HomeProductItem(
      coneId: 'biscuits',
      title: 'Biscuits',
      subtitle: 'Crunchy biscuit pairings for cone orders',
      imageUrl:
          'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=900&fit=crop',
      badge: 'Crunchy side',
    ),
  ];

  static const List<HomeFeatureItem> recommendedDesserts = [
    HomeFeatureItem(
      coneId: 'small_cone',
      title: 'Everyday Cone Picks',
      subtitle: 'Light waffle cone options suited for quick serve counters.',
      imageUrl:
          'https://images.unsplash.com/photo-1464306076886-da185f6a9d05?w=1200&fit=crop',
      tags: ['Small cone', 'Fast serve', 'Budget-friendly'],
      rating: 4.6,
      deliveryText: 'Free delivery',
      eta: '15-18 min',
    ),
    HomeFeatureItem(
      coneId: 'regular_cone',
      title: 'Puffy Woffle Signature Counter',
      subtitle: 'Fresh waffle cones prepared for same-day service.',
      imageUrl:
          'https://images.unsplash.com/photo-1517093157656-b9eccef91cb1?w=1200&fit=crop',
      tags: ['Classic', 'Hand-finished', 'Daily batch'],
      rating: 4.8,
      deliveryText: 'Free delivery',
      eta: '18-24 min',
    ),
    HomeFeatureItem(
      coneId: 'large_cone',
      title: 'Chocolate Studio Collection',
      subtitle: 'Premium large cones with richer tint finishes.',
      imageUrl:
          'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=1200&fit=crop',
      tags: ['Chocolate', 'Premium', 'Rich finish'],
      rating: 4.9,
      deliveryText: 'Delivery from Rs. 120',
      eta: '22-28 min',
    ),
    HomeFeatureItem(
      coneId: 'flavours',
      title: 'Flavour Finish Bar',
      subtitle: 'Smooth flavour add-ons prepared for cone customization.',
      imageUrl:
          'https://images.unsplash.com/photo-1470324161839-ce2bb6fa6bc3?w=1200&fit=crop',
      tags: ['Vanilla', 'Chocolate', 'Strawberry'],
      rating: 4.8,
      deliveryText: 'Free delivery',
      eta: '18-22 min',
    ),
    HomeFeatureItem(
      coneId: 'biscuits',
      title: 'Crunch & Biscuit Pairings',
      subtitle: 'Biscuit add-ons prepared to complement cone orders.',
      imageUrl:
          'https://images.unsplash.com/photo-1495214783159-3503fd1b572d?w=1200&fit=crop',
      tags: ['Biscuits', 'Sides', 'Counter-ready'],
      rating: 4.7,
      deliveryText: 'Free delivery',
      eta: '16-20 min',
    ),
  ];

  static WaffleCone coneById(String id) {
    return DummyData.cones.firstWhere((cone) => cone.id == id);
  }
}
