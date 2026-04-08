import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import '../utils/dummy_data.dart';
import '../widgets/product_card.dart';

class ProductListingScreen extends StatefulWidget {
  final String? initialCategory;

  const ProductListingScreen({super.key, this.initialCategory});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  String _query = '';
  late String _category;

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory ?? 'All';
  }

  @override
  Widget build(BuildContext context) {
    final items = DummyData.cones.where((item) {
      final matchesCategory = _category == 'All' || item.category == _category;
      final matchesQuery = _query.isEmpty || item.name.toLowerCase().contains(_query) || item.description.toLowerCase().contains(_query);
      return matchesCategory && matchesQuery;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product catalog',
                    style: GoogleFonts.fraunces(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    onChanged: (value) => setState(() => _query = value.toLowerCase()),
                    decoration: const InputDecoration(hintText: 'Search cone categories'),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 38,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (final category in ['All', ...DummyData.categories])
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(category),
                              selected: _category == category,
                              onSelected: (_) => setState(() => _category = category),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 0.62,
                      ),
                itemCount: items.length,
                itemBuilder: (context, index) => ProductCard(cone: items[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
