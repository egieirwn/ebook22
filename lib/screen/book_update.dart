import 'package:flutter/material.dart';

class UpdateBookPage extends StatefulWidget {
  final String title;
  final String author;
  final String image;
  final String page;
  final String id;

  UpdateBookPage({
    required this.title,
    required this.author,
    required this.image,
    required this.id,
    required this.page,
  });

  @override
  _UpdateBookPageState createState() => _UpdateBookPageState();
}

class _UpdateBookPageState extends State<UpdateBookPage> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _authorController = TextEditingController(text: widget.author);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Buku'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Judul Buku'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Pengarang'),
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Pages'),
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Tambahkan foto'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'title': _titleController.text,
                  'author': _authorController.text,
                });
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
