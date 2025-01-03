import 'package:ebook/screen/history.dart';
import 'package:ebook/screen/profile.dart';
import 'package:flutter/material.dart';
import 'home.dart';  


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  List<String> _allItems = [
    'Selena - Tere Liye',
    'Pulang Pergi - Tere Liye',
    'Bulan - Tere Liye',
    'Matahari - Tere Liye',
    'Bumi - Tere Liye',
    'Hujan - Tere Liye'
  ];

  int _selectedIndex = 1;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _searchResults = _allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigation logic
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), 
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HistoryPages()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: const Color.fromARGB(255, 133, 136, 138),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                _performSearch(value);
              },
              decoration: InputDecoration(
                hintText: 'Cari buku...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _searchResults.isNotEmpty
                  ? ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            title: Text(_searchResults[index]),
                            onTap: () {
                              // Add logic for item tap if needed
                            },
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'Tidak ada hasil pencarian',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
            ),
          ],
        ),
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
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SearchPage(),
  ));
}
