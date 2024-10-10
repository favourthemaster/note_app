import 'package:flutter/material.dart';
import 'package:noted/pages/first_time_page.dart';
import 'package:noted/pages/home_page.dart';
import 'package:noted/utils/providers/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late bool isFirstLaunch;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  isFirstLaunch = await checkFirstLaunch();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NoteProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

Future<bool> checkFirstLaunch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? firstLaunch = prefs.getBool('firstLaunch');

  if (firstLaunch == null || firstLaunch == true) {
    // First ever launch, so we set it to false for future launches
    await prefs.setBool('firstLaunch', false);
    return true;
  } else {
    getUserName();
    return false;
  }
}

String userName = "";

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(29, 62, 106, 1.0),
          brightness: Brightness.dark,
        ),
      ),
      home: isFirstLaunch ? FirstTimePage() : HomePage(userName: userName),
    );
  }
}

Future<void> getUserName() async {
  final prefs = await SharedPreferences.getInstance();
  userName = prefs.getString('username')!;
}
