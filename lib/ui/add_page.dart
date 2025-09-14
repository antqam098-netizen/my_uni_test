import 'package:flutter/material.dart';
import '../data/lecture_model.dart';
import '../data/lecture_repo.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _place = TextEditingController();
  String _type = 'نظري';
  String _day = 'الأحد';
  TimeOfDay _time = const TimeOfDay(hour: 8, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('أضف محاضرة')),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'اسم المحاضرة'),
                validator: (v) => v!.isEmpty ? 'مطلوب' : null),
            DropdownButtonFormField<String>(
                value: _type,
                items: ['نظري', 'عملي']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => _type = v!,
                decoration: const InputDecoration(labelText: 'النوع')),
            TextFormField(
                controller: _place,
                decoration: const InputDecoration(labelText: 'المكان'),
                validator: (v) => v!.isEmpty ? 'مطلوب' : null),
            ListTile(
                title: Text('الوقت: ${_time.format(context)}'),
                trailing: const Icon(Icons.access_time),
                onTap: _pickTime),
            DropdownButtonFormField<String>(
                value: _day,
                items: ['الأحد', 'الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => _day = v!,
                decoration: const InputDecoration(labelText: 'اليوم')),
            const SizedBox(height: 24),
            ElevatedButton(
                onPressed: _save,
                child: const Text('حفظ', style: TextStyle(fontSize: 18)))
          ],
        ),
      ),
    );
  }

  void _pickTime() async {
    final t = await showTimePicker(context: context, initialTime: _time);
    if (t != null) setState(() => _time = t);
  }

  void _save() async {
    if (!_form.currentState!.validate()) return;
    final lec = Lecture(
        title: _title.text,
        type: _type,
        doctor: null,
        startTime: _time.format(context),
        place: _place.text,
        day: _day);
    await LectureRepo().insert(lec);
    if (!mounted) return;
    Navigator.pop(context);
  }
}
