// Flutter
import 'package:clotthy/providers/LocationsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clotthy/providers/LoginProvider.dart';
import 'package:clotthy/providers/CompanyProvider.dart';

// Components
import 'components/company/Company.dart';
import 'components/company/EditCompany.dart';
import 'components/login/login_screen.dart';
import 'components/splashScreen/splashscreen.dart';

// Utils
// import 'api/AllApi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => LoginProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => CompanyProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => LocationsProvider()),
      ],
      child: const Clotthy(),
    );
  }
}

class Clotthy extends StatelessWidget {
  const Clotthy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clotthy',
      initialRoute: "SplashScreen",
      routes: {
        "SplashScreen": (_) => const SplashScreen(),
        "login": (_) => const LoginScreen(),
        "Company": (_) => const Company(),
      },
    );
  }
}
