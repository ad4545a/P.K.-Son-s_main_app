import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF7F2E7);
    final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : const Color(0xFF2B2B2B);
    final Color valueColor = isDark ? Colors.white70 : const Color(0xFF333333);
    final Color accentColor = const Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: accentColor.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.account_balance, color: accentColor, size: 32),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Bank of India',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Verified Business Account',
                        style: TextStyle(
                          fontSize: 14,
                          color: valueColor.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.verified, color: Colors.blue, size: 16),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    context, 
                    icon: Icons.numbers, 
                    title: 'Account Number', 
                    value: '726920110000211',
                    isLast: false,
                  ),
                  _buildDetailRow(
                    context, 
                    icon: Icons.qr_code, 
                    title: 'IFSC Code', 
                    value: 'BKID0007269',
                    isLast: false,
                  ),
                  _buildDetailRow(
                    context, 
                    icon: Icons.account_circle, 
                    title: 'Account Holder Name', 
                    value: 'P.K. & SONS', 
                    isLast: false,
                  ),
                  _buildDetailRow(
                    context, 
                    icon: Icons.location_city, 
                    title: 'Branch Name', 
                    value: 'Rohta', 
                    isLast: false,
                  ),
                  _buildDetailRow(
                    context, 
                    icon: Icons.map, 
                    title: 'District', 
                    value: 'Agra (U.P.) 282009',
                    isLast: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.green.withOpacity(0.3)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Icon(Icons.lock_outline, color: Colors.green, size: 18),
                   SizedBox(width: 8),
                   Flexible(
                     child: Text(
                      'Payments are accepted only on this official bank account',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                  ),
                   ),
                ],
              ),
            ),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, {
    required IconData icon, 
    required String title, 
    required String value,
    required bool isLast,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? Colors.white : const Color(0xFF2B2B2B);
    final Color labelColor = isDark ? Colors.white60 : Colors.grey[600]!;
    final Color accentColor = const Color(0xFFD4AF37);
    
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: value));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 10),
                Text('$title Copied!'),
              ],
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: isLast ? null : Border(
            bottom: BorderSide(
              color: isDark ? Colors.white10 : Colors.grey.withOpacity(0.1),
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF7F2E7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: accentColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      color: labelColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.copy, color: Colors.grey[400], size: 20),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$title Copied!'),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}