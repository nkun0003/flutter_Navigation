import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Contact Us',
                style: TextStyle(fontSize: 24),
              ),
              TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your name',
                  labelText: 'Name',
                ),
                onSaved: (value) {
                  _formData['name'] = value;
                },
                validator: (value) {
                  return value == null || value.isEmpty
                      ? 'Name is required'
                      : null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Enter your email',
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  _formData['email'] = value;
                },
                validator: (value) {
                  return value == null || !value.contains('@')
                      ? 'Enter a valid email'
                      : null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.message),
                  hintText: 'Enter your message',
                  labelText: 'Message',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                onSaved: (value) {
                  _formData['message'] = value;
                },
                validator: (value) {
                  return value == null || value.isEmpty
                      ? 'Message is required'
                      : null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Form submitted successfully!')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
