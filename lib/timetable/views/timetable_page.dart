import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_res.dart';
import '../controllers/timetable_controller.dart';
import '../widgets/day_selector.dart';
import '../widgets/timetable_card.dart';

class TimetablePage extends GetView<TimetableController> {
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppRes.backgroundGradient,
        child: Column(
          children: [
            _buildAppBar(),

            _buildAnnouncement(),

            _buildEffectiveDate(),

            _buildTodayRow(),

            const DaySelector(),
            Expanded(child: _buildTimetable()),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: AppRes.transparent,
      foregroundColor: AppRes.white,
      title: Text('KIIT SYNC', style: AppRes.appBarTitle),
      actions: [
        Obx(
          () => DropdownButton<String>(
            value: controller.selectedMode.value,
            dropdownColor: AppRes.black,
            style: AppRes.dropdownText,
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(value: 'Roll No', child: Text('Roll No')),
              DropdownMenuItem(value: 'Manual', child: Text('Manual')),
              DropdownMenuItem(value: 'Custom', child: Text('Custom')),
            ],
            onChanged: (value) {
              if (value != null) {
                controller.setMode(value);
              }
            },
          ),
        ),

        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildAnnouncement() {
    return Obx(() {
      if (controller.announcement.value.isEmpty) {
        return const SizedBox.shrink();
      }

      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppRes.tileColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(controller.announcement.value, style: AppRes.body),
      );
    });
  }

  Widget _buildEffectiveDate() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(
              'Effective From: ${controller.effectiveDate.value}',
              style: AppRes.effectiveDate.copyWith(color: AppRes.white),
            ),
            const Spacer(),
            if (controller.section.value.isNotEmpty)
              Text(
                'Section: ${controller.section.value}',
                style: AppRes.effectiveDate.copyWith(color: AppRes.white),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Obx(
            () => Text(
              controller.todayLabel.value,
              style: AppRes.todayLabel.copyWith(color: AppRes.white),
            ),
          ),

          const Spacer(),

          Container(
            height: 32,
            decoration: AppRes.buttonGradient,
            child: MaterialButton(
              onPressed: controller.addClass,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Add',
                style: AppRes.roboto.copyWith(
                  fontSize: 12,
                  color: AppRes.white,
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          IconButton(
            onPressed: controller.showReminder,
            icon: const Icon(
              Icons.notifications_none,
              color: AppRes.white,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimetable() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.value.isNotEmpty) {
        return Center(
          child: Text(controller.errorMessage.value, style: AppRes.body),
        );
      }

      if (controller.todayClasses.isEmpty) {
        return Center(child: Text('No classes scheduled', style: AppRes.body));
      }

      return ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        itemCount: controller.todayClasses.length,
        itemBuilder: (context, index) {
          final timetable = controller.todayClasses[index];
          final isNext = controller.isNextClass(timetable);
          return TimetableCard(
            item: {
              'subject_code': timetable.subjectCode,
              'faculty': timetable.faculty,
              'room': timetable.room,
              'start_time': '${timetable.startTime.hour.toString().padLeft(2, '0')}:${timetable.startTime.minute.toString().padLeft(2, '0')}',
              'end_time': '${timetable.endTime.hour.toString().padLeft(2, '0')}:${timetable.endTime.minute.toString().padLeft(2, '0')}',
            },
            isNow: controller.isCurrentClass(timetable),
            isNext: isNext,
            minutesUntilNext: isNext ? controller.minutesUntilNext(timetable) : null,
          );
        },
      );
    });
  }
}
