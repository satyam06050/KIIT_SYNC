import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/app_res.dart';
import '../data/services/supabase_service.dart';

class SupabaseTestPage extends StatelessWidget {
  SupabaseTestPage({super.key});

  final _service = SupabaseService();
  final _rollNoController = TextEditingController();
  final _result = ''.obs;
  final _isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppRes.black,
      appBar: AppBar(
        backgroundColor: AppRes.transparent,
        foregroundColor: AppRes.white,
        title: Text('[TEST] Supabase Service', style: AppRes.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _rollNoController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: AppRes.white),
              decoration: InputDecoration(
                labelText: 'Roll No',
                labelStyle: TextStyle(color: AppRes.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppRes.white10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppRes.accentOrange),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _TestButton(
                    label: 'Get Student',
                    onTap: () => _testGetStudent(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _TestButton(
                    label: 'Get Timetable',
                    onTap: () => _testGetTimetable(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppRes.tileColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Obx(() {
                  if (_isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SingleChildScrollView(
                    child: Text(
                      _result.value.isEmpty ? 'Results will appear here...' : _result.value,
                      style: AppRes.caption,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _testGetStudent() async {
    final rollNo = int.tryParse(_rollNoController.text.trim());
    if (rollNo == null) {
      _result.value = '[ERROR] Enter a valid roll number';
      return;
    }
    _isLoading.value = true;
    _result.value = '';
    try {
      final data = await _service.getStudent(rollNo);
      _result.value = '[getStudent] SUCCESS\n\n${_format(data)}';
      debugPrint('[TEST] getStudent: $data');
    } catch (e) {
      _result.value = '[getStudent] ERROR\n\n$e';
      debugPrint('[TEST ERROR] getStudent: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _testGetTimetable() async {
    final rollNo = int.tryParse(_rollNoController.text.trim());
    if (rollNo == null) {
      _result.value = '[ERROR] Enter a valid roll number';
      return;
    }
    _isLoading.value = true;
    _result.value = '';
    try {
      final data = await _service.getTimetable(rollNo);
      _result.value = '[getTimetable] SUCCESS — ${data.length} entries\n\n${data.map(_format).join('\n\n')}';
      debugPrint('[TEST] getTimetable: $data');
    } catch (e) {
      _result.value = '[getTimetable] ERROR\n\n$e';
      debugPrint('[TEST ERROR] getTimetable: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  String _format(Map<String, dynamic> map) =>
      map.entries.map((e) => '  ${e.key}: ${e.value}').join('\n');
}

class _TestButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _TestButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: AppRes.buttonGradient,
      child: MaterialButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Text(label, style: AppRes.roboto.copyWith(fontSize: 13, color: AppRes.white)),
      ),
    );
  }
}
