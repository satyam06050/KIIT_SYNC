import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/app_res.dart';
import 'timetable/bindings/timetable_binding.dart';
import 'timetable/views/timetable_page.dart';

void main() {
  runApp(const KiitSyncApp());
}

class KiitSyncApp extends StatelessWidget {
  const KiitSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KIIT SYNC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppRes.seedColor),
        useMaterial3: true,
      ),
      initialBinding: TimetableBinding(),
      home: const TimetablePage(),
    );
  }
}
