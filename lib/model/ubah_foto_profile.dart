import 'dart:io'; // Tambahkan ini untuk File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfilePicturePage extends StatefulWidget {
  @override
  _ChangeProfilePicturePageState createState() => _ChangeProfilePicturePageState();
}

class _ChangeProfilePicturePageState extends State<ChangeProfilePicturePage> {
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<void> _takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 85, 177, 238),
        title: const Text('Change Profile Picture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: _image != null
                    ? FileImage(File(_image!.path)) as ImageProvider<Object>
                    : const NetworkImage('https://example.com/default-avatar.jpg'),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Choose from Gallery'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _takePhoto,
                  child: const Text('Take a Photo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
