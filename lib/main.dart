import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Generated file dari Firebase CLI
import 'screen/login.dart'; // Pastikan path file sudah sesuai

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Inisialisasi Firebase dengan opsi spesifik platform
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase successfully initialized");
  } catch (e) {
    print('Error initializing Firebase: $e'); // Log jika ada kesalahan
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ebook App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, // Warna utama aplikasi
        scaffoldBackgroundColor: Colors.white, // Warna latar belakang aplikasi
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
        ),
      ),
      home: const LoginPage(), // Halaman utama aplikasi
    );
  }
}
