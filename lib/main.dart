import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopin/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var appDocDir = await getApplicationDocumentsDirectory();
  Hive.init('${appDocDir.path}/db');
  await Hive.openBox('prefs');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: const ScrollBehavior(
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      ),
      initialRoute: '/login', // Routes.testPage, //
      theme: ThemeData(),

      getPages: AppRouter.routes,
      debugShowCheckedModeBanner:
          const String.fromEnvironment('BUILD_MODE') != 'RELEASE',
    );
  }
}
