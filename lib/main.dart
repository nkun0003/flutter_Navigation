import 'package:flutter/material.dart'; // Importing material package

// Importing components from the lib directory
import 'home_page.dart';
import 'data_page.dart';
import 'contact_page.dart';

void main() {
  runApp(const MyApp()); // Entry point of the application
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation App', // App title
      theme: ThemeData(
        useMaterial3: true, // Enables Material 3 design
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal, // Defines primary color
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
          titleLarge: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      home: const MainNavigation(), // Main navigation widget
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex =
      0; //the state variable,here tracking the current selected screen

  // when creating a list of screens, each has its own Scaffold
  static const List<Widget> _screens = [
    HomePage(),
    DataPage(),
    ContactPage(),
  ];

  // here updating the selected screen index when a navigation item is tapped
  void _whenItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

// constructing the state variable for the selected screen and update the selected index when a navigation item is tapped.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // to display the selected screen
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _whenItemTapped, // handling screen switching
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.data_usage), label: 'Data'),
          NavigationDestination(
              icon: Icon(Icons.contact_mail), label: 'Contact'),
        ],
      ),
    );
  }
}
