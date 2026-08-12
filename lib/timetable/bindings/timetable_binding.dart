import 'package:get/get.dart';
import '../controllers/timetable_controller.dart';
import '../repositories/timetable_repository.dart';

class TimetableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TimetableRepository());
    Get.lazyPut(() => TimetableController(repository: Get.find()));
  }
}
