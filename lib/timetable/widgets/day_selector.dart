import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_res.dart';
import '../controllers/timetable_controller.dart';

class DaySelector extends GetView<TimetableController> {
  const DaySelector({super.key});

  static const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final day = days[index];
          return Obx(() {
            final isSelected = controller.selectedDay.value == day;
            return GestureDetector(
              onTap: () => controller.selectDay(day),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 55,
                decoration: BoxDecoration(
                  color: isSelected ? AppRes.accentOrange : AppRes.tileColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppRes.accentOrange : AppRes.white10,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      day.toUpperCase(),
                      style: AppRes.tabLabel.copyWith(
                        color: isSelected ? AppRes.white : AppRes.white70,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _getDate(index),
                      style: AppRes.tabDate.copyWith(
                        color: isSelected ? AppRes.white : AppRes.white70,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  String _getDate(int index) {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final date = monday.add(Duration(days: index));
    return date.day.toString();
  }
}
