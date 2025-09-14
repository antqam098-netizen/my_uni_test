import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'ui/home_page.dart';
import 'main_background.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  // تذكير وهمي الساعة ٦ ص
  await AndroidAlarmManager.periodic(
      const Duration(hours: 24), 0, dailyDummyTask,
      startAt: DateTime.now().add(const Duration(minutes: 1)));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'جامعتي-تجريبي',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const Directionality(
          textDirection: TextDirection.rtl, child: HomePage()),
      debugShowCheckedModeBanner: false,
    );
  }
}
