import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(emailUri);
  }

  Future<void> _openLink(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF7F2E7);
    final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : const Color(0xFF2B2B2B);
    final Color subtitleColor = isDark ? Colors.white60 : Colors.grey[600]!;
    final Color accentColor = const Color(0xFFD4AF37);

    return Container(
      color: bgColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.store_mall_directory, color: accentColor, size: 40),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'P.K. & SONS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We\'re available to assist you',
                    style: TextStyle(
                      fontSize: 14,
                      color: subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black26 : Colors.grey[100],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time, size: 14, color: accentColor),
                        const SizedBox(width: 8),
                        Text(
                          'Open 10:00 AM - 8:00 PM',
                          style: TextStyle(
                            fontSize: 13,
                            color: textColor.withOpacity(0.8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    context,
                    icon: Icons.phone_in_talk,
                    title: 'Call Now',
                    subtitle: '+91 8535047868',
                    onTap: () => _makePhoneCall('8535047868'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionCard(
                    context,
                    icon: Icons.email_outlined,
                    title: 'Email Us',
                    subtitle: 'Send Inquiry',
                    onTap: () => _sendEmail('jity7770@gmail.com'),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
             _buildHorizontalActionCard(
                context,
                icon: Icons.phone_iphone,
                title: 'Mobile',
                subtitle: '+91 9634347770',
                onTap: () => _makePhoneCall('9634347770'),
              ),

             const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(20),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: accentColor),
                      const SizedBox(width: 12),
                      Text(
                        'Store Location',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Rohta, Dist. Agra (U.P.)\nPIN: 282009',
                    style: TextStyle(
                      fontSize: 15,
                      color: subtitleColor,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _openLink('https://maps.app.goo.gl/9t5jLxmsoEuw5FMi9');
                      },
                      icon: const Icon(Icons.map_outlined, size: 18),
                      label: const Text("Open in Maps"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Center(
              child: _buildSocialButton(
                context,
                icon: Icons.camera_alt_outlined,
                label: 'Follow on Instagram',
                onTap: () => _openLink('https://www.instagram.com/pk_sons_jewellers?igsh=MTIzY3lpbHk5eTE2bw=='),
              ),
            ),
             
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : const Color(0xFF2B2B2B);
    final Color accentColor = const Color(0xFFD4AF37);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(color: isDark ? Colors.white10 : Colors.transparent),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: accentColor, size: 28),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white54 : Colors.grey,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
  
   Widget _buildHorizontalActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : const Color(0xFF2B2B2B);
    final Color accentColor = const Color(0xFFD4AF37);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
           border: Border.all(color: isDark ? Colors.white10 : Colors.transparent),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: accentColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                   Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.white54 : Colors.grey,
                    ),
                  ),
                ]
              )
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: isDark ? Colors.white30 : Colors.grey[300]),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
     return TextButton.icon(
       onPressed: onTap,
       icon: Icon(icon, color: Colors.grey, size: 20),
       label: Text(
         label, 
         style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
       ),
    );
  }
}