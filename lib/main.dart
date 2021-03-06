import 'package:elgam3a_admin/providers/auth_provider.dart';
import 'package:elgam3a_admin/providers/departments_provider.dart';
import 'package:elgam3a_admin/providers/faculities_provider.dart';
import 'package:elgam3a_admin/providers/users_provider.dart';
import 'package:elgam3a_admin/screens/splash_screen.dart';
import 'package:elgam3a_admin/utilities/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<UsersProvider>(create: (_) => UsersProvider()),
        // ChangeNotifierProvider<CoursesProvider>(create: (_) => CoursesProvider()),
        ChangeNotifierProvider<FacultiesProvider>(
            create: (_) => FacultiesProvider()),
        ChangeNotifierProvider<DepartmentsProvider>(
            create: (_) => DepartmentsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'El-Gam3a Admin',
        theme: AppTheme().lightTheme,
        home: SplashScreen(),
      ),
    );
  }
}
