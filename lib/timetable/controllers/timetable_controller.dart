import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../models/timetable_model.dart';
import '../repositories/timetable_repository.dart';

class TimetableController extends GetxController {
  final TimetableRepository repository;

  TimetableController({required this.repository});

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final selectedMode = 'Roll No'.obs;

  final announcement = ''.obs;
  final effectiveDate = ''.obs;
  final section = ''.obs;
  final todayLabel = ''.obs;

  final todayClasses = <TimetableModel>[].obs;

  static const _dayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  static const _dayKeys = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  final selectedDay = ''.obs;

  // TODO: replace with actual roll no from auth/prefs
  final int rollNo = 2328120;

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    selectedDay.value = _dayKeys[now.weekday - 1];
    todayLabel.value = _dayNames[now.weekday - 1];
    effectiveDate.value = '${now.day}/${now.month}/${now.year}';
    loadTimetable();
  }

  void selectDay(String day) {
    selectedDay.value = day;
    final i = _dayKeys.indexOf(day);
    if (i != -1) todayLabel.value = _dayNames[i];
    loadTimetable();
  }

  Future<void> loadTimetable() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final classes = await repository.getTimetableForDay(
        rollNo,
        selectedDay.value,
      );
      if (classes.isNotEmpty) {
        todayClasses.assignAll(classes);
        return;
      }

      final allClasses = await repository.getTimetable(rollNo);
      if (allClasses.isEmpty) {
        todayClasses.clear();
        return;
      }

      final fallbackDay = allClasses.first.day;
      selectedDay.value = fallbackDay;
      final dayIndex = _dayKeys.indexWhere(
        (day) => day.toLowerCase() == fallbackDay.toLowerCase(),
      );
      if (dayIndex != -1) todayLabel.value = _dayNames[dayIndex];
      todayClasses.assignAll(
        allClasses
            .where((item) => item.day.toLowerCase() == fallbackDay.toLowerCase())
            .toList(),
      );
    } catch (e) {
      errorMessage.value = 'Unable to load timetable';
      debugPrint('[TIMETABLE ERROR] $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setMode(String mode) {
    selectedMode.value = mode;
    loadTimetable();
  }

  bool isCurrentClass(TimetableModel timetable) {
    final now = DateTime.now();
    return now.isAfter(timetable.startTime) && now.isBefore(timetable.endTime);
  }

  bool isNextClass(TimetableModel timetable) {
    return timetable.startTime.isAfter(DateTime.now());
  }

  int minutesUntilNext(TimetableModel timetable) {
    return timetable.startTime.difference(DateTime.now()).inMinutes;
  }

  void addClass() {}

  void showReminder() {}
}
