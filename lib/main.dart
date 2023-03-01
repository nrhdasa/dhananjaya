import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'connectivity.dart';
import 'resources/theme.dart';
import 'routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextTheme textTheme = GoogleFonts.poppinsTextTheme();

  @override
  void initState() {
    super.initState();
    Auth.startAuthStream();
  }

  @override
  void dispose() {
    Auth.closeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: textTheme, useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(textTheme: textTheme, useMaterial3: true, colorScheme: darkColorScheme));
  }
}
