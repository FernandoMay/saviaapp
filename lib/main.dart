// // pubspec.yaml
// name: savia_app
// description: Savia Medical Crowdfunding Platform

// version: 1.0.0+1

// environment:
//   sdk: '>=3.0.0 <4.0.0'
//   flutter: ">=3.0.0"

// dependencies:
//   flutter:
//     sdk: flutter
//   cupertino_icons: ^1.0.6
//   http: ^1.1.0
//   provider: ^6.0.5
//   shared_preferences: ^2.2.2
//   image_picker: ^1.0.4
//   file_picker: ^6.1.1
//   url_launcher: ^6.2.1
//   intl: ^0.18.1
//   flutter_secure_storage: ^9.0.0
//   qr_code_scanner: ^1.0.1
//   qr_flutter: ^4.1.0
//   crypto: ^3.0.3
//   json_annotation: ^4.8.1
//   flutter_svg: ^2.0.9
//   cached_network_image: ^3.3.0
//   lottie: ^2.7.0
//   flutter_animate: ^4.5.0

// dev_dependencies:
//   flutter_test:
//     sdk: flutter
//   flutter_lints: ^3.0.1
//   build_runner: ^2.4.7
//   json_serializable: ^6.7.1

// flutter:
//   uses-material-design: true
//   assets:
//     - assets/images/
//     - assets/animations/
//     - assets/icons/

// ---

// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/campaign_provider.dart';
import 'providers/wallet_provider.dart';
import 'providers/kyc_provider.dart';
import 'providers/donation_provider.dart';
import 'utils/theme.dart';
import 'utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(SaviaApp());
}

class SaviaApp extends StatelessWidget {
  const SaviaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
        ChangeNotifierProvider(create: (_) => KYCProvider()),
        ChangeNotifierProvider(create: (_) => CampaignProvider()),
        ChangeNotifierProvider(create: (_) => DonationProvider()),
      ],
      child: MaterialApp(
        title: 'Savia',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}