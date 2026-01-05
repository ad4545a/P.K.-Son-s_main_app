import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';
import 'services/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PKSonsApp());
}

class PKSonsApp extends StatelessWidget {
  const PKSonsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeController(),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'P.K. & Sons Jewellery',
          themeMode: ThemeController().themeMode,
          
          // LIGHT THEME - Soft Champagne Gold
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: const Color(0xFFD4AF37), // Border/Accent Gold
            scaffoldBackgroundColor: const Color(0xFFF7F2E7), // Soft Champagne Cream
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFD4AF37), // Border/Accent Gold
              secondary: Color(0xFFB8962E), // Icon/Star Gold (deeper)
              surface: Colors.white,
              background: Color(0xFFF7F2E7), // Soft Champagne Cream
              onBackground: Colors.black,
              onSurface: Colors.black,
            ),
            cardTheme: CardThemeData(
              color: Colors.white,
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              centerTitle: true,
            ),
            textTheme: const TextTheme(
              headlineLarge: TextStyle(color: Color(0xFFD4AF37), fontSize: 32, fontWeight: FontWeight.bold),
              headlineMedium: TextStyle(color: Color(0xFFD4AF37), fontSize: 24, fontWeight: FontWeight.w600),
              bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
              bodyMedium: TextStyle(color: Colors.black87, fontSize: 14),
            ),
            dividerColor: Colors.grey[300],
            useMaterial3: true,
          ),

          // DARK THEME
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: const Color(0xFFD4AF37),
            scaffoldBackgroundColor: const Color(0xFF0A0A0A), // Matte Black
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFD4AF37),
              secondary: Color(0xFFFFD700),
              surface: Color(0xFF1E1E1E), // Slightly lighter for contrast
              background: Color(0xFF0A0A0A),
              onBackground: Colors.white,
              onSurface: Colors.white,
            ),
            cardTheme: CardThemeData(
              color: const Color(0xFF1E1E1E),
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Soft rounded
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF0A0A0A),
              elevation: 0,
              centerTitle: true,
            ),
            textTheme: const TextTheme(
              headlineLarge: TextStyle(color: Color(0xFFD4AF37), fontSize: 32, fontWeight: FontWeight.bold),
              headlineMedium: TextStyle(color: Color(0xFFD4AF37), fontSize: 24, fontWeight: FontWeight.w600),
              bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
              bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            dividerColor: const Color(0xFFD4AF37).withOpacity(0.2),
            useMaterial3: true,
          ),
          
          home: SplashScreen(),
        );
      },
    );
  }
}