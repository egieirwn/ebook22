import 'package:flutter/material.dart';

class AddBookPage extends StatefulWidget {
  final Function(String title, String author, int pages) onBookAdded;

  AddBookPage({required this.onBookAdded});

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _pagesController = TextEditingController();

  void _submitBook() {
    final title = _titleController.text.trim();
    final author = _authorController.text.trim();
    final pages = int.tryParse(_pagesController.text.trim());

    if (title.isEmpty || author.isEmpty || pages == null || pages <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Semua bidang harus diisi dengan benar!'),
        ),
      );
      return;
    }

    widget.onBookAdded(title, author, pages);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Buku Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Judul Buku'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Penulis'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _pagesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Total Halaman'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitBook,
              child: Text('Tambahkan Buku'),
            ),
          ],
        ),
      ),
    );
  }
}
