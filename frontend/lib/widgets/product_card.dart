import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/waffle_cone.dart';
import '../utils/app_colors.dart';
import '../utils/app_formatters.dart';
import '../utils/app_routes.dart';

class ProductCard extends StatelessWidget {
  final WaffleCone cone;

  const ProductCard({super.key, required this.cone});

  @override
  Widget build(BuildContext context) {
    final gradient = AppColors.categoryGradient(cone.category);
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => Navigator.pushNamed(context, AppRoutes.productDetail, arguments: cone),
        child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: SizedBox(
                height: 136,
                width: double.infinity,
                child: Image.network(
                  cone.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: gradient),
                    ),
                    child: const Icon(Icons.icecream_outlined, color: Colors.white, size: 44),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cone.name,
                    style: GoogleFonts.fraunces(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cone.description,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      height: 1.5,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          AppFormatters.currency(cone.price),
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${cone.rating.toStringAsFixed(1)}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
