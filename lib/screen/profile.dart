import 'package:ebook/model/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = 'Egie Irawan'; // Default name
  String major = 'Teknik Informatika'; // Default major
  String phoneNumber = '08123456789'; // Default phone number
  String birthDate = '01 Januari 1990'; // Default birth date
  XFile? profileImage; // Profile picture

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        profileImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 85, 177, 238),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'AKUN PENGGUNA',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: _pickImage, // Allow user to change profile picture
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color.fromARGB(255, 180, 201, 231),
                  backgroundImage: profileImage != null
                      ? FileImage(File(profileImage!.path))
                      : null,
                  child: profileImage == null
                      ? const Icon(
                          Icons.person,
                          size: 60,
                          color: Color.fromARGB(255, 27, 111, 221),
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              major,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'No. Telp: $phoneNumber',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tanggal Lahir: $birthDate',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: const [
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ProfileMenuItems(
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    onTap: () async {
                      final updatedData = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(
                            currentName: userName,
                            currentMajor: major,
                            currentPhoneNumber: phoneNumber,
                            currentBirthDate: birthDate,
                          ),
                        ),
                      );

                      if (updatedData != null && updatedData is Map<String, String>) {
                        setState(() {
                          userName = updatedData['name']!;
                          major = updatedData['major']!;
                          phoneNumber = updatedData['phoneNumber']!;
                          birthDate = updatedData['birthDate']!;
                        });
                      }
                    },
                  ),
                  ProfileMenuItems(
                    icon: Icons.dark_mode,
                    title: 'Toggle Dark Mode',
                    onTap: () {
                      final brightness = Theme.of(context).brightness;
                      final isDarkMode = brightness == Brightness.dark;
                      setState(() {
                        Theme.of(context).copyWith(
                          brightness: isDarkMode ? Brightness.light : Brightness.dark,
                        );
                      });
                    },
                  ),
                  ProfileMenuItems(
                    icon: Icons.privacy_tip,
                    title: 'Privacy Settings',
                    onTap: () {
                      // Navigate to Privacy Settings page
                    },
                  ),
                  ProfileMenuItems(
                    icon: Icons.logout,
                    title: 'Logout',
                    color: Colors.red,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Konfirmasi Logout'),
                          content: const Text('Apakah Anda yakin ingin keluar?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Handle logout
                                Navigator.pop(context);
                              },
                              child: const Text('Logout'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuItems extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  final Color color;

  ProfileMenuItems({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[600],
        ),
        onTap: () => onTap(),
      ),
    );
  }
}