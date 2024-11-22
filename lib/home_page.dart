import 'package:flutter/material.dart'; // Import material.dart from flutter package

// my home page class constructing here
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // the top half with a background image
        Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/home_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // Bottom half with text
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.black,
            child: Center(
              child: Transform.scale(
                scale: 1.5, // Example transformation
                child: Text(
                  'Welcome to the Home Page',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium, // here using my created theme text
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
