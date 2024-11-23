import 'dart:convert'; // this converting JSON decoding
import 'package:flutter/material.dart'; // import material as usual from flutter package
import 'package:http/http.dart' as http; // importing http.dart dependency

// contact data here
class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

// User model class, where creating variables for name and email
class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}

// creating state for a data page
class _DataPageState extends State<DataPage> {
  late Future<List<User>>
      _users; // here is the future to hold the list of users
// using initState function like in react useEffect() for initial load, and called fetchUsers() function
  @override
  void initState() {
    super.initState();
    _users = fetchUsers(); // fetch users when the widget initializes
  }

// fetching data (just as we do with js promise, try and catch)
  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse('https://randomuser.me/api/?results=15'), // fetching 15 users
      );

      if (response.statusCode == 200) {
        // Parse the JSON
        final data = jsonDecode(response.body);
        final List results = data['results'];

        // mapping JSON to User objects as i will be only extracting name and email
        return results
            .map((user) => User(
                  name: '${user['name']['first']} ${user['name']['last']}',
                  email: user['email'],
                ))
            .toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

// creating widget to display the data fetched above
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('App Two'),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.lightBlue,
          child: FutureBuilder<List<User>>(
            future: _users, // using the Future to display the data
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show loader, when fetching shows data is loading
                return const Center(child: CircularProgressIndicator());

                //show error if snapshot is not loading
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));

                // show no users found if snapshot is empty or does not has data
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No users found'));
              } else {
                // Build ListView with user data
                final users = snapshot.data!;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      leading:
                          const Icon(Icons.person), // user icon from material
                      title: Text(user.name), // displaying name
                      subtitle: Text(user.email), // displaying email
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}
