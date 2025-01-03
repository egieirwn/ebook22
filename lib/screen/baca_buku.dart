import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Daftar Isi Buku',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: DetailBukuPage(),
  ));
}

class DetailBukuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Isi Buku'),
      ),
      body: TableOfContentsScreen(),
    );
  }
}

class TableOfContentsScreen extends StatelessWidget {
  final List<String> chapters = [
    'Pendahuluan',
    'Chapter 1: Perjalanan Awal',
    'Chapter 2: Tantangan yang Datang',
    'Chapter 3: Pencarian Jati Diri',
    'Chapter 4: Duka Yang Datang',
    'Chapter 5: Akhir yang Bahagia',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daftar Isi',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 18, 134, 188),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      chapters[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChapterContentScreen(
                            chapterTitle: chapters[index],
                            totalPages: 113,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChapterContentScreen extends StatefulWidget {
  final String chapterTitle;
  final int totalPages;

  const ChapterContentScreen({
    required this.chapterTitle,
    required this.totalPages,
    Key? key,
  }) : super(key: key);

  @override
  _ChapterContentScreenState createState() => _ChapterContentScreenState();
}

class _ChapterContentScreenState extends State<ChapterContentScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapterTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: widget.totalPages,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Halaman ${index + 1}\n\n',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              'Halaman ${_currentPage + 1} / ${widget.totalPages}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
