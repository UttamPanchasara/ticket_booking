import 'package:booking_app/data/repo/helper/object_box.dart';
import 'package:booking_app/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/colors.dart';

/// Provides access to the ObjectBox Store throughout the app.
late ObjectBox objectBox;

Future<void> main() async {
  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();

  objectBox = await ObjectBox.create();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () {
        return MaterialApp(
          theme: ThemeData(
            primaryColor: AppColors.primaryColor,
            primaryColorDark: AppColors.primaryColorDark,
            backgroundColor: AppColors.backgroundColor,
            appBarTheme: const AppBarTheme(
              color: AppColors.primaryColor,
            ),
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
