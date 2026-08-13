import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Map<String, dynamic>?> getStudent(int rollNo) async {
    return await _supabase
        .from('student')
        .select('roll_no, section, batch, semester')
        .eq('roll_no', rollNo)
        .maybeSingle();
  }

  Future<List<Map<String, dynamic>>> getTimetable(int rollNo) async {
    final student = await getStudent(rollNo);
    if (student == null) {
      throw StateError('No student found for roll number $rollNo');
    }

    final data = await _supabase
        .from('timetable')
        .select(
          'section, batch, semester, '
          'day, start_time, end_time, '
          'subject_code, room, faculty',
        )
        .eq('section', student['section'])
        .eq('batch', student['batch'])
        .eq('semester', student['semester'])
        .order('day')
        .order('start_time');

    return List<Map<String, dynamic>>.from(data);
  }
}
