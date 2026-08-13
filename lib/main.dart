import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/app_res.dart';
import 'timetable/bindings/timetable_binding.dart';
import 'timetable/controllers/timetable_controller.dart';
import 'timetable/data/services/supabase_service.dart';
import 'timetable/repositories/timetable_repository.dart';
import 'timetable/views/timetable_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await _loadEnv();
    debugPrint('[ENV] .env loaded successfully');
  } catch (e) {
    debugPrint('[ENV ERROR] Failed to load .env: $e');
    return;
  }

  final url = dotenv.env['SUPABASE_URL'];
  final publishableKey = dotenv.env['SUPABASE_PUBLISHABLE_KEY'];

  if (url == null || url.isEmpty || publishableKey == null || publishableKey.isEmpty) {
    debugPrint('[ENV ERROR] SUPABASE_URL or SUPABASE_PUBLISHABLE_KEY is missing in .env');
    return;
  }

  try {
    await Supabase.initialize(url: url, publishableKey: publishableKey);
    debugPrint('[SUPABASE] Initialized successfully');
  } catch (e) {
    debugPrint('[SUPABASE ERROR] Failed to initialize Supabase: $e');
    return;
  }

  _initDependencies();
  runApp(const KiitSyncApp());
}

Future<void> _loadEnv() async {
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    await dotenv.load(fileName: 'assets/.env');
  }
}

void _initDependencies() {
  final service = SupabaseService();
  final repository = TimetableRepository(service: service);
  Get.put(service);
  Get.put(repository);
  Get.put(TimetableController(repository: repository));
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
      home: const TimetablePage(),
    );
  }
}
