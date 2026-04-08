import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/home_models.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';
import '../utils/home_mock_data.dart';
import '../widgets/home/category_chip.dart';
import '../widgets/home/featured_card.dart';
import '../widgets/home/home_header.dart';
import '../widgets/home/product_card.dart';
import '../widgets/home/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeCategoryItem _selectedCategory = HomeMockData.categories.first;

  List<HomeProductItem> get _filteredProducts {
    final linkedCategory = _selectedCategory.linkedCategory;
    if (linkedCategory == null) {
      return HomeMockData.featuredProducts;
    }

    return HomeMockData.featuredProducts.where((item) {
      return HomeMockData.coneById(item.coneId).category == linkedCategory;
    }).toList();
  }

  List<HomeFeatureItem> get _filteredRecommendations {
    final linkedCategory = _selectedCategory.linkedCategory;
    if (linkedCategory == null) {
      return HomeMockData.recommendedDesserts;
    }

    return HomeMockData.recommendedDesserts.where((item) {
      return HomeMockData.coneById(item.coneId).category == linkedCategory;
    }).toList();
  }

  void _showQuickMenu(BuildContext context) {
    final parentContext = context;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3D7CB),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Quick access',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Jump to the most-used areas of Puffy Woffle.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 18),
                _QuickMenuTile(
                  icon: Icons.receipt_long_outlined,
                  label: 'My Orders',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(parentContext, AppRoutes.myOrders);
                  },
                ),
                _QuickMenuTile(
                  icon: Icons.help_outline_rounded,
                  label: 'Help & Support',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(parentContext, AppRoutes.help);
                  },
                ),
                _QuickMenuTile(
                  icon: Icons.person_outline_rounded,
                  label: 'Profile',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(parentContext, AppRoutes.editProfile);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final featuredProducts = _filteredProducts;
    final recommendedDesserts = _filteredRecommendations;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeader(
                      locationLabel: HomeMockData.locationLabel,
                      locationValue: HomeMockData.locationValue,
                      greeting: HomeMockData.greeting,
                      badgeCount: 2,
                      onMenuTap: () => _showQuickMenu(context),
                      onActionTap: () =>
                          Navigator.pushNamed(context, AppRoutes.notifications),
                    ),
                    const SizedBox(height: 20),
                    HomeSearchBar(
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.productListing,
                        arguments: _selectedCategory.linkedCategory,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _SectionHeader(
                      title: 'All Categories',
                      actionLabel: 'See All',
                      onActionTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.productListing,
                        arguments: _selectedCategory.linkedCategory,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 58,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                  scrollDirection: Axis.horizontal,
                  itemCount: HomeMockData.categories.length,
                  itemBuilder: (context, index) {
                    final category = HomeMockData.categories[index];
                    return HomeCategoryChip(
                      category: category,
                      isSelected: _selectedCategory.label == category.label,
                      onTap: () => setState(() => _selectedCategory = category),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 14),
                child: _SectionHeader(
                  title: 'Featured Waffle Cones',
                  actionLabel: 'See All',
                  onActionTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.productListing,
                    arguments: _selectedCategory.linkedCategory,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 312,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: featuredProducts.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    final item = featuredProducts[index];
                    final cone = HomeMockData.coneById(item.coneId);
                    return HomeProductCard(
                      item: item,
                      startingPrice: cone.price,
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.productDetail,
                        arguments: cone,
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 14),
                child: _SectionHeader(
                  title: 'Recommended Desserts',
                  actionLabel: 'See All',
                  onActionTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.productListing,
                    arguments: _selectedCategory.linkedCategory,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
              sliver: SliverList.separated(
                itemCount: recommendedDesserts.length,
                itemBuilder: (context, index) {
                  final item = recommendedDesserts[index];
                  return HomeFeaturedCard(
                    item: item,
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.productDetail,
                      arguments: HomeMockData.coneById(item.coneId),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionLabel;
  final VoidCallback onActionTap;

  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        TextButton(
          onPressed: onActionTap,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textSecondary,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                actionLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 2),
              const Icon(Icons.chevron_right_rounded, size: 18),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickMenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickMenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFF8EFE6),
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    );
  }
}
