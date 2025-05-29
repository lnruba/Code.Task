import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(),
      ToursPage(onBackHome: () => _onNavTapped(0)),
      ProfilePage(onBackHome: () => _onNavTapped(0)),
    ];

    return MaterialApp(
      title: 'Enhanced Multi Page App',
      theme: ThemeData(
        primarySwatch: const Color.fromARGB(255, 67, 244, 3),
        scaffoldBackgroundColor: const Color.fromARGB(255, 93, 12, 24),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Enhanced Multi Page App'),
          backgroundColor: Colors.[700],
        ),
        drawer: AppDrawer(
          onSelectItem: (index) {
            Navigator.pop(context);
            _onNavTapped(index);
          },
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 204, 195, 20)0),
          onTap: _onNavTapped,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.tour), label: 'Tours'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppDrawer extends StatelessWidget {
  final Function(int) onSelectItem;
  AppDrawer({required this.onSelectItem});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: const Color.fromARGB(255, 93, 113, 124)),
            child: Text(
              'Menu',
              style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: const Color.fromARGB(255, 209, 2, 23)),
            title: Text('Home', style: TextStyle(color: Colors.black)),
            onTap: () => onSelectItem(0),
          ),
          ListTile(
            leading: Icon(Icons.tour, color: Colors.lightBlue[700]),
            title: Text('Tours', style: TextStyle(color: Colors.black)),
            onTap: () => onSelectItem(1),
          ),
          ListTile(
            leading: Icon(Icons.person, color: const Color.fromARGB(255, 21, 215, 150)),
            title: Text('Profile', style: TextStyle(color: Colors.black)),
            onTap: () => onSelectItem(2),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 70, color: Colors.black),
            SizedBox(height: 10),
            Text(
              'Welcome to the Home Page!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              icon: Icon(Icons.info),
              label: Text('Show Info'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue[700],
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onPressed: () =>
                  _showSnackbar(context, 'You are on the Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class ToursPage extends StatelessWidget {
  final VoidCallback onBackHome;

  ToursPage({required this.onBackHome});

  final List<Map<String, String>> tours = [
    {
      'name': 'Beach Paradise',
      'description': 'Relax on white sandy beaches',
      'image':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
    },
    {
      'name': 'Mountain Adventure',
      'description': 'Explore breathtaking mountains',
      'image':
          'https://images.unsplash.com/photo-1500534623283-312aade485b7?auto=format&fit=crop&w=800&q=80',
    },
    {
      'name': 'City Lights',
      'description': 'Discover vibrant city life',
      'image':
          'https://images.unsplash.com/photo-1468071174046-657d9d351a40?auto=format&fit=crop&w=800&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: tours.length,
            itemBuilder: (context, index) {
              final tour = tours[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      tour['image']!,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    tour['name']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(tour['description']!),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Colors.lightBlue[700],
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('You selected ${tour['name']}')),
                    );
                  },
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton.icon(
            icon: Icon(Icons.home),
            label: Text('Back to Home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue[700],
            ),
            onPressed: onBackHome,
          ),
        ),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  final VoidCallback onBackHome;

  ProfilePage({required this.onBackHome});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              'https://randomuser.me/api/portraits/women/44.jpg',
            ),
          ),
          SizedBox(height: 15),
          Text(
            'LN Ruba ',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Travel Enthusiast',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          SizedBox(height: 20),

          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(Icons.email, color: Colors.lightBlue[700]),
              title: Text(
                'xlanruba@gmail.com',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 10),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(Icons.phone, color: Colors.lightBlue[700]),
              title: Text('01636918522', style: TextStyle(color: Colors.black)),
            ),
          ),
          SizedBox(height: 10),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(Icons.location_city, color: Colors.lightBlue[700]),
              title: Text(
                'Sylhet, Bangladesh',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            icon: Icon(Icons.home),
            label: Text('Back to Home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue[700],
            ),
            onPressed: onBackHome,
          ),
        ],
      ),
    );
  }
}
