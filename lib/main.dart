
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bmi_calculator/views/calculate_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('bmi_history');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Color.fromARGB(10, 12, 33, 255),
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(10, 12, 33, 255),
              elevation: 0,
              centerTitle: true,
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
          ),
          home: child,
        );
      },
      child: CalculatePage(),
    );
  }
}
