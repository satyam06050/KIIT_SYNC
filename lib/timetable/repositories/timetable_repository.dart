import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/timetable_model.dart';

class TimetableRepository {
  Future<List<TimetableModel>> getTimetableForDay(String day) async {
    final raw = await rootBundle.loadString('lib/mockdata/timetable.json');
    final List data = jsonDecode(raw);
    final filtered = data.where((e) => e['day'] == day).toList();
    // fallback to all entries if no data for selected day (mock only)
    final source = filtered.isNotEmpty ? filtered : data;
    return source.map((e) => TimetableModel.fromJson(e)).toList();
  }
}
