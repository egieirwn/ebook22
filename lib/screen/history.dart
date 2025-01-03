import 'package:ebook/screen/profile.dart';
import 'package:flutter/material.dart';
import 'home.dart'; // Import HomePage
import 'searching.dart';



class HistoryPages extends StatefulWidget {
  @override
  _HistoryPagesState createState() => _HistoryPagesState();
}

class _HistoryPagesState extends State<HistoryPages> {
  int _selectedIndex = 2;

  final List<Map<String, String>> bookHistory = [
    {
      "title": "Selena",
      "author": "Tere Liye",
      "image": "assets/images/selena.png",
      "dateViewed": "10 November 2024, 14:00"
    },
    {
      "title": "Pulang Pergi",
      "author": "Tere Liye",
      "image": "assets/images/pulangpergi.png",
      "dateViewed": "9 November 2024, 16:30"
    },
    {
      "title": "Bulan",
      "author": "Tere Liye",
      "image": "assets/images/bulan.png",
      "dateViewed": "8 November 2024, 11:45"
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Membaca'),
        backgroundColor: const Color.fromARGB(255, 60, 169, 241),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: bookHistory.length,
        itemBuilder: (context, index) {
          final book = bookHistory[index];
          return Card(
            margin: EdgeInsets.only(bottom: 10),
            elevation: 4,
            child: ListTile(
              leading: Image.asset(
                book['image']!,
                width: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                book['title']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book['author']!),
                  SizedBox(height: 4),
                  Text(
                    'Dibaca pada: ${book['dateViewed']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
