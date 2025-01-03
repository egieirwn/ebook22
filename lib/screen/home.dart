import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'book_detail.dart';
import 'history.dart';
import 'profile.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // List halaman untuk navigasi
  final List<Widget> _pages = [
    HomePage(),
    HistoryPages(),
    FavoritesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
    );
  }
}

// Halaman HomePage
class HomePage extends StatefulWidget {
  static List<Map<String, dynamic>> newBooks = [
    {
      'title': 'Arah Langkah',
      'author': 'Fiersa Besari',
      'image': 'assets/images/arahlangkah.png',
      'pages': 280,
    },

    {
      'title': 'Bulan',
      'author': 'Dyho Haw',
      'image': 'assets/images/bulan.png',
      'pages': 280,
    },

    {
      'title': 'Garis Waktu',
      'author': 'Kumala',
      'image': 'assets/images/gariswaktu.png',
      'pages': 280,
    },

    {
      'title': 'Komsi Komsa',
      'author': 'Connor',
      'image': 'assets/images/komsikomsa.png',
      'pages': 280,
    },

    {
      'title': 'Buya Hamka',
      'author': 'Fiersa Besari',
      'image': 'assets/images/buyahamka.png',
      'pages': 280,
    },

    {
      'title': 'Bumi',
      'author': 'Tere Liye',
      'image': 'assets/images/bumi.png',
      'pages': 400,
    },
    {
      'title': 'Pulang Pergi',
      'author': 'Tere Liye',
      'image': 'assets/images/pulangpergi.png',
      'pages': 400,
    },

    {
      'title': 'Matahari',
      'author': 'Vierro Berrt',
      'image': 'assets/images/matahari.png',
      'pages': 280,
    },

    {
      'title': 'Perahu Kertas',
      'author': 'Dewi Lestari',
      'image': 'assets/images/perahukertas.png',
      'pages': 280,
    },

    {
      'title': 'Perihal Gendis',
      'author': 'Sapardi Djoko Damono',
      'image': 'assets/images/perihalgendis.png',
      'pages': 280,
    },

    {
      'title': 'Segitiga',
      'author': 'Sapardi Djoko Damono',
      'image': 'assets/images/segitiga.png',
      'pages': 280,
    },

    {
      'title': 'Pulang Pergi',
      'author': 'Tere Liye',
      'image': 'assets/images/pulangpergi.png',
      'pages': 280,
    },

    {
      'title': 'Tapak Jejak',
      'author': 'Brustt',
      'image': 'assets/images/tapakjejak.png',
      'pages': 280,
    },


    {
      'title': 'Tapak Jejak',
      'author': 'Tere Liye',
      'image': 'assets/images/tapakjejak.png',
      'pages': 400,
    },

  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> recommendedBooks = [
    {
      'title': 'Selena',
      'author': 'Tere Liye',
      'image': 'assets/images/selena.png',
      'pages': 300,
    },
    {
      'title': 'Hello',
      'author': 'Tere Liye',
      'image': 'assets/images/hello.png',
      'pages': 250,
    },

    {
      'title': 'Laskar Pelangi',
      'author': 'Andrea Hirata',
      'image': 'assets/images/laskarpelangi.png',
      'pages': 280,
    },

  ];

  void _deleteBook(int index, String listType) {
    setState(() {
      if (listType == 'recommended') {
        recommendedBooks.removeAt(index);
      } else if (listType == 'new') {
        HomePage.newBooks.removeAt(index);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Buku berhasil dihapus!')),
    );
  }

  Image _buildImage(dynamic image) {
    if (image is Uint8List) {
      return Image.memory(image, height: 120, fit: BoxFit.cover);
    } else if (image is String) {
      return Image.asset(image, height: 120, fit: BoxFit.cover);
    } else {
      return Image.asset('assets/images/default.png', height: 120, fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter books based on search query
    List<Map<String, dynamic>> filteredRecommendedBooks = recommendedBooks
        .where((book) =>
            book['title']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
    List<Map<String, dynamic>> filteredNewBooks = HomePage.newBooks
        .where((book) =>
            book['title']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color.fromARGB(255, 18, 134, 188),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text('Ebook',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 18, 134, 188))),
            Image.asset('assets/images/Banner.png',
                height: 166, width: double.infinity),
            SizedBox(height: 20),
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Rekomendasi',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 18, 134, 188))),
            SizedBox(height: 10),
            _buildBookGrid(filteredRecommendedBooks, context, 'recommended'),
            SizedBox(height: 20),
            Text('Buku Terbaru',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 18, 134, 188))),
            SizedBox(height: 10),
            _buildBookGrid(filteredNewBooks, context, 'new'),
          ],
        ),
      ),
    );
  }

  Widget _buildBookGrid(
      List<Map<String, dynamic>> books, BuildContext context, String listType) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailPage(
                  title: books[index]['title'],
                  author: books[index]['author'],
                  image: books[index]['image'],
                  pages: books[index]['pages'],
                ),
              ),
            );
          },
          child: Stack(
            children: [
              Column(
                children: [
                  _buildImage(books[index]['image']),
                  SizedBox(height: 5),
                  Text(
                    books[index]['title'],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    books[index]['author'],
                    style: TextStyle(
                        fontSize: 12,
                        color: const Color.fromARGB(255, 6, 98, 134)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Positioned(
                right: -10,
                top: -10,
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _deleteBook(index, listType);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Halaman Favorites
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Color.fromARGB(255, 18, 134, 188),
      ),
      body: Center(
        child: Text('Halaman Favorites masih kosong.'),
      ),
    );
  }
}
