import 'package:flutter/material.dart';
import '../data/lecture_model.dart';
import '../data/lecture_repo.dart';
import 'add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Lecture>> _list;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() => _list = LectureRepo().fetchAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('جدولي (نسخة تجريبية)')),
      body: FutureBuilder<List<Lecture>>(
        future: _list,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.data!.isEmpty) {
            return const Center(child: Text('لا توجد محاضرات بعد'));
          }
          return ListView.builder(
            itemCount: snap.data!.length,
            itemBuilder: (_, i) {
              final lec = snap.data![i];
              return Card(
                child: ListTile(
                  title: Text(lec.title),
                  subtitle: Text('${lec.type} | ${lec.startTime} | ${lec.place}'),
                  trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await LectureRepo().delete(lec.id!);
                        setState(() => _refresh());
                      }),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddPage()));
          setState(() => _refresh());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
