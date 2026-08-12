import 'package:flutter/material.dart';
import '../../core/app_res.dart';
import '../../core/utils/accessibility_utils.dart';

class TimetableCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isNow;
  final bool isNext;
  final int? minutesUntilNext;

  const TimetableCard({
    super.key,
    required this.item,
    this.isNow = false,
    this.isNext = false,
    this.minutesUntilNext,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = AccessibilityUtils.getScaledSpacing(context, 12.0);
    final semanticLabel = AccessibilityUtils.formatTimeForScreenReader(
      _formatScheduleTime(item['start_time']),
      _formatScheduleTime(item['end_time']),
    );

    return Semantics(
      label: '${item['subject_code'] ?? 'Unknown Subject'}. $semanticLabel. Room ${item['room'] ?? 'not specified'}${isNow ? '. Currently ongoing' : ''}${isNext ? '. Next class in $minutesUntilNext minutes' : ''}',
      button: false,
      child: Container(
        margin: EdgeInsets.only(bottom: spacing),
        decoration: BoxDecoration(
          color: AppRes.tileColor,
          borderRadius: BorderRadius.circular(8),
          border: isNow ? Border.all(color: const Color(0xFF4CAF50), width: 2) : null,
          boxShadow: [
            BoxShadow(
              color: isNow
                  ? const Color(0xFF4CAF50).withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.3),
              blurRadius: isNow ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            if (isNow)
              Container(
                width: 4,
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
              ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(AccessibilityUtils.getScaledSpacing(context, 16.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFFFF7E4A), Color(0xFFFF5722)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds),
                            child: Text(
                              item['subject_code'] ?? 'Unknown Subject',
                              style: AppRes.roboto.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppRes.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${_formatScheduleTime(item['start_time'])} - ${_formatScheduleTime(item['end_time'])}',
                          style: AppRes.roboto.copyWith(fontSize: 14, color: AppRes.white),
                        ),
                      ],
                    ),
                    SizedBox(height: AccessibilityUtils.getScaledSpacing(context, 8.0)),
                    if (isNow)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'ONGOING',
                          style: AppRes.roboto.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppRes.white,
                          ),
                        ),
                      ),
                    if (isNext && minutesUntilNext != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFB300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'NEXT IN $minutesUntilNext MIN',
                          style: AppRes.roboto.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppRes.white,
                          ),
                        ),
                      ),
                    if (item['room'] != null) ...[
                      SizedBox(height: AccessibilityUtils.getScaledSpacing(context, 4.0)),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16, color: Colors.white70),
                          const SizedBox(width: 4),
                          Text(
                            'Room: ${item['room']}',
                            style: AppRes.roboto.copyWith(fontSize: 14, color: AppRes.white),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatScheduleTime(dynamic time) {
    if (time == null) return 'N/A';
    final timeStr = time.toString();
    if (timeStr.contains(':')) {
      final parts = timeStr.split(':');
      if (parts.length >= 2) return '${parts[0]}:${parts[1]}';
    }
    return timeStr;
  }
}
