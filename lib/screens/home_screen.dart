import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'about_screen.dart';
import 'bank_details_screen.dart';
import 'contact_screen.dart';
import '../widgets/premium_rate_card.dart';
import '../widgets/premium_rtgs_card.dart';
import '../widgets/animated_bottom_nav.dart';
import '../services/theme_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  Map<String, dynamic> _rates = {};
  String _tickerText = '';
  int _selectedIndex = 2; // Start with Live (Home) tab

  @override
  void initState() {
    super.initState();
    _fetchRates();
    _fetchTicker();
  }

  void _fetchRates() {
    _database.child('live_rates').onValue.listen((event) {
      if (event.snapshot.value != null) {
        final newData = event.snapshot.value as Map;
        setState(() {
          // Deep copy to ensure nested Maps trigger change detection
          _rates = {
            'gold': newData['gold'] != null 
              ? Map<String, dynamic>.from(newData['gold'] as Map)
              : {},
            'silver': newData['silver'] != null
              ? Map<String, dynamic>.from(newData['silver'] as Map)
              : {},
            'last_updated': newData['last_updated'],
            'usdinr': newData['usdinr'],
            'status': newData['status'],
          };

        });
      } else {
        debugPrint('⚠️ Firebase snapshot is null');
      }
    });
  }

  void _fetchTicker() {
    _database.child('admin_settings/ticker_text').onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          _tickerText = event.snapshot.value.toString();
        });
      }
    });
  }

  void _onItemTapped(int index) {
    if (index == 4) {
      // Menu - open drawer
      Scaffold.of(context).openDrawer();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'About Us';
      case 1:
        return 'Bank Details';
      case 2:
        return 'P.K & Son\'s Jewellers';
      case 3:
        return 'Contact Us';
      default:
        return 'P.K & Son\'s Jewellers';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getAppBarTitle(),
          style: const TextStyle(
            color: Color(0xFFD4AF37),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      drawer: _buildDrawer(),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const AboutScreen(),
          const BankDetailsScreen(),
          _buildHomeContent(),
          const ContactScreen(),
          _buildHomeContent(), // Menu
        ],
      ),
      bottomNavigationBar: AnimatedBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildHomeContent() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF7F2E7);
    
    return Container(
      color: bgColor,
      child: SingleChildScrollView(
        child: Column(
        children: [
          // Live Clock
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return Text(
                      DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: TextStyle(
                        color: isDark ? const Color(0xFFD4AF37) : const Color(0xFFD4AF37).withOpacity(0.8),
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),



          const SizedBox(height: 16),

          // Top Info Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                  ? [const Color(0xFF2A2416), const Color(0xFF1A1510)]
                  : [const Color(0xFFFFF9E6), const Color(0xFFFFFAF0)],
              ),
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFFD4AF37).withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: SizedBox(
              height: 20,
              child: Marquee(
                text: _tickerText.isNotEmpty
                    ? _tickerText
                    : 'P.K. & SONS – Agra\'s Trusted Jewellers',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFFD4AF37) : const Color(0xFF8B7355),
                  letterSpacing: 0.5,
                ),
                blankSpace: 100.0,
                velocity: 30.0,
                pauseAfterRound: const Duration(seconds: 2),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Three Metric Cards Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // INR vs USD
                Expanded(
                  child: _buildMetricCard(
                    context,
                    'INR/USD',
                    '₹${(_rates['usdinr']?['price']?.toDouble() ?? 0.0).toStringAsFixed(2)}',
                    isDark,
                  ),
                ),
                const SizedBox(width: 8),
                // Gold Spot
                Expanded(
                  child: _buildMetricCard(
                    context,
                    'Gold Spot',
                    '\$${(_rates['gold']?['spot_price']?.toDouble() ?? 0.0).toStringAsFixed(1)}',
                    isDark,
                  ),
                ),
                const SizedBox(width: 8),
                // Silver Spot
                Expanded(
                  child: _buildMetricCard(
                    context,
                    'Silver Spot',
                    '\$${(_rates['silver']?['spot_price']?.toDouble() ?? 0.0).toStringAsFixed(2)}',
                    isDark,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // LIVE RATE TABLE Heading
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'LIVE RATE TABLE',
              style: TextStyle(
                color: const Color(0xFFD4AF37),
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.2,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Gold 24K Card
          if (_rates['gold'] != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: PremiumRateCard(
                title: 'Gold 99.50',
                subtitle: 'per 10gm',
                rate: _rates['gold']['rate_9950']?.toDouble() ?? 0.0,
                change: _rates['gold']['change']?.toDouble() ?? 0.0,
                mcxRate: _rates['gold']['mcx_price']?.toDouble() ?? 0.0,
                high: _rates['gold']['high']?.toDouble(),
                low: _rates['gold']['low']?.toDouble(),
                isGold: true,
              ),
            ),

          // Silver Card
          if (_rates['silver'] != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: PremiumRateCard(
                title: 'Silver (999)',
                subtitle: 'Per Kg',
                rate: _rates['silver']['rate_9999']?.toDouble() ?? 0.0,
                change: _rates['silver']['change']?.toDouble() ?? 0.0,
                mcxRate: _rates['silver']['mcx_price']?.toDouble() ?? 0.0,
                high: _rates['silver']['high']?.toDouble(),
                low: _rates['silver']['low']?.toDouble(),
                isGold: false,
              ),
            ),

          const SizedBox(height: 28),

          // RTGS (ONLINE PAYMENT) RATES Heading
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'RTGS (ONLINE PAYMENT) RATES',
              style: TextStyle(
                color: const Color(0xFFD4AF37),
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // RTGS Rates
          if (_rates['gold'] != null && _rates['silver'] != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: PremiumRtgsCard(
                gold24k: _rates['gold']['rate_9950']?.toDouble() ?? 0.0,
                gold22k: _rates['gold']['rate_999']?.toDouble() ?? 0.0,
                silver: _rates['silver']['rate_9999']?.toDouble() ?? 0.0,
              ),
            ),

          const SizedBox(height: 100),
        ],
      ),
      ),
    );
  }

  Widget _buildDrawer() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color goldColor = const Color(0xFFD4AF37);
    
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark 
                  ? [const Color(0xFF2A2416), const Color(0xFF1A1510)]
                  : [Colors.black, Colors.grey[900]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/splash_logo.png',
                    height: 72,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'P.K & Son\'s',
                    style: TextStyle(
                      color: goldColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'Jewellers',
                    style: TextStyle(
                      color: goldColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildDrawerItem(
                  icon: Icons.home,
                  title: 'Home',
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _selectedIndex = 2);
                  },
                  isSelected: _selectedIndex == 2,
                ),
                _buildDrawerItem(
                  icon: Icons.info_outline,
                  title: 'About Us',
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _selectedIndex = 0);
                  },
                  isSelected: _selectedIndex == 0,
                ),
                _buildDrawerItem(
                  icon: Icons.account_balance,
                  title: 'Bank Details',
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _selectedIndex = 1);
                  },
                  isSelected: _selectedIndex == 1,
                ),
                _buildDrawerItem(
                  icon: Icons.phone_in_talk,
                  title: 'Contact Us',
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _selectedIndex = 3);
                  },
                  isSelected: _selectedIndex == 3,
                ),
                Divider(color: goldColor.withOpacity(0.2)),
                ListTile(
                  leading: Icon(
                    isDark ? Icons.light_mode : Icons.dark_mode,
                    color: goldColor,
                  ),
                  title: Text(
                    isDark ? 'Light Mode' : 'Dark Mode',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Switch(
                    value: isDark,
                    activeColor: goldColor,
                    onChanged: (value) {
                      ThemeController().toggleTheme();
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'App Version 1.0.1',
              style: TextStyle(
                color: isDark ? Colors.white30 : Colors.black26,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color goldColor = const Color(0xFFD4AF37);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: isSelected
        ? BoxDecoration(
            color: goldColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          )
        : null,
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? goldColor : (isDark ? Colors.white70 : Colors.black54),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? goldColor : (isDark ? Colors.white : Colors.black87),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildMetricCard(BuildContext context, String label, String value, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFD4AF37).withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white60 : Colors.grey[600],
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFD4AF37),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
