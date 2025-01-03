import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Mengimpor file baca_buku.dart untuk akses ke halaman daftar isi
import 'baca_buku.dart';  // Pastikan nama file benar

class FavoriteBookPage extends StatelessWidget {
  const FavoriteBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Favorite Books',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FavoriteBooksPage(),
    );
  }
}

class FavoriteBooksPage extends StatefulWidget {
  const FavoriteBooksPage({Key? key}) : super(key: key);

  @override
  State<FavoriteBooksPage> createState() => _FavoriteBooksPageState();
}

class _FavoriteBooksPageState extends State<FavoriteBooksPage> {
  List<Map<String, dynamic>> _favoriteBooks = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteBooks();
  }

  Future<void> _loadFavoriteBooks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final books = prefs.getStringList('favorites');
      if (books != null) {
        _favoriteBooks = books.map((book) => jsonDecode(book) as Map<String, dynamic>).toList();
      }
    });
  }

  Future<void> _removeBook(Map<String, dynamic> book) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoriteBooks.remove(book);
    });
    await prefs.setStringList(
      'favorites',
      _favoriteBooks.map((book) => jsonEncode(book)).toList(),
    );
  }

  void _confirmRemoveBook(Map<String, dynamic> book) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Buku'),
          content: Text('Apakah Anda yakin ingin menghapus buku "${book['title']}" dari favorit?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _removeBook(book);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Buku "${book['title']}" telah dihapus dari favorit.'),
                  ),
                );
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _rereadBook(Map<String, dynamic> book) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ulangi Baca'),
          content: Text('Apakah Anda ingin membaca ulang buku "${book['title']}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Mengarahkan ke halaman daftar isi yang ada pada file baca_buku.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailBukuPage(), // Halaman daftar isi
                  ),
                );
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Books'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _favoriteBooks.isEmpty
            ? const Center(
                child: Text(
                  'No favorite books yet!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: _favoriteBooks.length,
                itemBuilder: (context, index) {
                  final book = _favoriteBooks[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Image.asset(
                        book['image'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(book['title']),
                      subtitle: Text(
                          'Author: ${book['author']}\nPages: ${book['pages']}'),
                      isThreeLine: true,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.repeat, color: Colors.green),
                            onPressed: () => _rereadBook(book),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _confirmRemoveBook(book),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
