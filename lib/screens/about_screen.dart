import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _openMap() async {
    const url = 'https://maps.app.goo.gl/9t5jLxmsoEuw5FMi9';
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error launching map: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF7F2E7);
    final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : const Color(0xFF2B2B2B);
    final Color accentColor = const Color(0xFFD4AF37);

    return Container(
      color: bgColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(
              'About P.K. & Sons',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: accentColor,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Trusted Jewellery Store with certified purity & transparent pricing.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.white70 : Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.verified_outlined, color: accentColor),
                      const SizedBox(width: 10),
                      Text(
                        'Our Commitment',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildCommitmentRow(context, '100% Hallmarked & Certified Jewellery'),
                  _buildCommitmentRow(context, 'Transparent & Real-Time Pricing'),
                  _buildCommitmentRow(context, 'Customer Satisfaction First'),
                  _buildCommitmentRow(context, 'Proper Certification with Every Purchase'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionHeader(context, 'Our Services'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildServiceChip(context, Icons.whatshot, 'Gold Jewellery (916, 999)'),
                _buildServiceChip(context, Icons.diamond_outlined, 'Pure Silver Ornaments'),
                _buildServiceChip(context, Icons.design_services, 'Custom Designs'),
                _buildServiceChip(context, Icons.currency_exchange, 'Buyback & Exchange'),
                _buildServiceChip(context, Icons.build_circle_outlined, 'Repair Services'),
                _buildServiceChip(context, Icons.trending_up, 'Live Rate Updates'),
              ],
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFBEA),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accentColor.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    children: [
                      Icon(Icons.star_outline, color: accentColor),
                      const SizedBox(width: 10),
                      Text(
                        'Why Choose Us?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTrustRow(context, '100% Certified Gold & Silver'),
                  _buildTrustRow(context, 'Transparent Pricing'),
                  _buildTrustRow(context, 'Traditional & Modern Designs'),
                  _buildTrustRow(context, 'Expert Craftsmanship'),
                  _buildTrustRow(context, 'Trusted by Local Customers'),
                ],
              ),
            ),

            const SizedBox(height: 30),

            InkWell(
              onTap: _openMap,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFD4AF37), Color(0xFFEBC96F)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(Icons.storefront, color: Colors.white, size: 36),
                    const SizedBox(height: 12),
                    const Text(
                      'Visit Our Store',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Rohta, District Agra (U.P.)\nPIN: 282009',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.map, size: 16, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Open in Maps',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : const Color(0xFF2B2B2B),
        ),
      ),
    );
  }

  Widget _buildCommitmentRow(BuildContext context, String text) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFFD4AF37), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: isDark ? Colors.white70 : Colors.grey[800],
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceChip(BuildContext context, IconData icon, String label) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: (MediaQuery.of(context).size.width - 52) / 2,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFD4AF37), size: 28),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustRow(BuildContext context, String text) {
     final bool isDark = Theme.of(context).brightness == Brightness.dark;
     return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.star, color: Color(0xFFD4AF37), size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: isDark ? Colors.white70 : const Color(0xFF444444),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
     );
  }
}