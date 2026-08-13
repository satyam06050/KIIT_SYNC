import '../data/services/supabase_service.dart';
import '../models/timetable_model.dart';

class TimetableRepository {
  final SupabaseService _service;

  TimetableRepository({required SupabaseService service}) : _service = service;

  Future<List<TimetableModel>> getTimetable(int rollNo) async {
    final data = await _service.getTimetable(rollNo);
    return data.map((e) => TimetableModel.fromJson(e)).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  Future<List<TimetableModel>> getTimetableForDay(int rollNo, String day) async {
    final data = await _service.getTimetable(rollNo);
    final normalizedDay = day.toLowerCase();
    return data
        .where((e) => e['day'].toString().toLowerCase() == normalizedDay)
        .map((e) => TimetableModel.fromJson(e))
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }
}
