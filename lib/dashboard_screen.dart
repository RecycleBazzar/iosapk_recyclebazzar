import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // For Lottie animations
import 'package:shared_preferences/shared_preferences.dart';
import 'collection_page.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late SharedPreferences _prefs;
  String _username = "";

  final List<String> _categoryImages = [
    'https://img.freepik.com/premium-vector/garbage-basket-icon-cartoon-vector-cleaner-job-waste-collector_98402-63968.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjQeZvmOgLW9g-U_glFMLqpJnrg2FFmE8IjA&s',
    'https://thumbs.dreamstime.com/b/mom-son-donated-their-old-clothes-recycling-charity-donations-to-needy-homeless-recyce-textiles-raising-246400923.jpg',
    'https://cdn-icons-png.flaticon.com/512/3581/3581139.png',
  ];

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      setState(() {
        _username = _prefs.getString('username') ?? '';
      });
    } catch (e) {
      print('Error loading username: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.recycling, color: Colors.white), // Icon on the leading position
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Aligns the items in the row
          crossAxisAlignment: CrossAxisAlignment.center, // Center items vertically
          children: <Widget>[
            SizedBox(width: 0), // Optional: Adjust spacing if needed
            Text(
              'Recycle Bazzar',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Text(
            'Welcome Rony Saha',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 50),
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Total balance',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Image.network(
                              'https://cdn-icons-png.flaticon.com/512/25/25473.png',
                              width: 28,
                              height: 28,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '200',
                                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis, // Prevent overflow
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10), // Add some spacing
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Insufficient wallet')),
                        );
                      },
                      child: Text('Withdraw'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Category',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 350,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _categoryImages.length,
                      itemBuilder: (context, index) {
                        return _buildCategoryItem(
                          context,
                          _getCategoryTitle(index),
                          _categoryImages[index], // Use the corresponding image URL
                        );
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String title, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CollectionPage(pageTitle: title),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFAFADAD), width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(Icons.error, color: Colors.red),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  String _getCategoryTitle(int index) {
    switch (index) {
      case 0:
        return 'Garbage Collection';
      case 1:
        return 'Scrap Collection';
      case 2:
        return 'Cloth Collection';
      case 3:
        return 'Housekeeping';
      default:
        return 'Unknown Category';
    }
  }
}
