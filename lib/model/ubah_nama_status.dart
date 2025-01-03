import 'package:flutter/material.dart';

class EditNameAndJobPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 85, 177, 238),
        title: Text('Edit Name and Job'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Nama
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            // Pekerjaan
            TextField(
              controller: _jobController,
              decoration: InputDecoration(labelText: 'Job/Title'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Simpan perubahan
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
