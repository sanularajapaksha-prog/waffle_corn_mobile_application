import 'package:flutter/material.dart';

class HomeCategoryItem {
  final String label;
  final IconData icon;
  final String? linkedCategory;

  const HomeCategoryItem({
    required this.label,
    required this.icon,
    this.linkedCategory,
  });
}

class HomeProductItem {
  final String coneId;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String badge;

  const HomeProductItem({
    required this.coneId,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.badge,
  });
}

class HomeFeatureItem {
  final String coneId;
  final String title;
  final String subtitle;
  final String imageUrl;
  final List<String> tags;
  final double rating;
  final String deliveryText;
  final String eta;

  const HomeFeatureItem({
    required this.coneId,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.tags,
    required this.rating,
    required this.deliveryText,
    required this.eta,
  });
}
