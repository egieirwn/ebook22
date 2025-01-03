import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  void _togglePasswordView() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> _registerUser() async {
    try {
      // Register user in Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Save additional user details in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'fullName': _fullNameController.text.trim(),
        'dob': _dobController.text.trim(),
        'address': _addressController.text.trim(),
        'phone': _phoneController.text.trim(),
        'email': _emailController.text.trim(),
      });

      // Navigate to success or home screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi berhasil!')),
      );
      Navigator.pop(context);
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 134, 188),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                'Registrasi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              _buildLabelText('Nama Lengkap'),
              _buildTextField(_fullNameController, 'Nama Lengkap',
                  icon: Icons.person),
              const SizedBox(height: 10),
              _buildLabelText('Tanggal Lahir'),
              _buildTextField(_dobController, 'Tanggal Lahir',
                  icon: Icons.calendar_today),
              const SizedBox(height: 10),
              _buildLabelText('Alamat'),
              _buildTextField(_addressController, 'Alamat',
                  icon: Icons.location_on),
              const SizedBox(height: 10),
              _buildLabelText('Nomor Handphone'),
              _buildTextField(_phoneController, 'Nomor Handphone',
                  icon: Icons.phone),
              const SizedBox(height: 10),
              _buildLabelText('Email'),
              _buildTextField(_emailController, 'Email', icon: Icons.email),
              const SizedBox(height: 10),
              _buildLabelText('Password'),
              _buildTextField(
                _passwordController,
                'Password',
                isPassword: true,
                icon: Icons.lock,
              ),
              const SizedBox(height: 30),
              _buildRegisterButton(context),
              const SizedBox(height: 10),
              _buildBackButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabelText(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.start,
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {bool isPassword = false, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? !_isPasswordVisible : false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          prefixIcon: icon != null ? Icon(icon) : null,
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: _togglePasswordView,
                  child: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _registerUser,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 3, 57, 138),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Registrasi',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Kembali',
          style: TextStyle(
            fontSize: 16,
            color: const Color.fromARGB(255, 74, 74, 75),
          ),
        ),
      ),
    );
  }
}
