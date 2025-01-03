import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String currentName;
  final String currentMajor;
  final String currentPhoneNumber;
  final String currentBirthDate;

  EditProfilePage({
    required this.currentName,
    required this.currentMajor,
    required this.currentPhoneNumber,
    required this.currentBirthDate,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _majorController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _birthDateController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _majorController = TextEditingController(text: widget.currentMajor);
    _phoneNumberController = TextEditingController(text: widget.currentPhoneNumber);
    _birthDateController = TextEditingController(text: widget.currentBirthDate);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _majorController.dispose();
    _phoneNumberController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _majorController,
              decoration: InputDecoration(
                labelText: 'Major',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _birthDateController,
              decoration: InputDecoration(
                labelText: 'Birth Date',
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode()); // Dismiss the keyboard
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    _birthDateController.text =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  });
                }
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'name': _nameController.text,
                  'major': _majorController.text,
                  'phoneNumber': _phoneNumberController.text,
                  'birthDate': _birthDateController.text,
                });
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
