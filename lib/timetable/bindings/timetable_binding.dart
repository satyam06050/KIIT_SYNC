import 'package:get/get.dart';
import '../controllers/timetable_controller.dart';
import '../data/services/supabase_service.dart';
import '../repositories/timetable_repository.dart';

class TimetableBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SupabaseService());
    Get.put(TimetableRepository(service: Get.find()));
    Get.put(TimetableController(repository: Get.find()));
  }
}
