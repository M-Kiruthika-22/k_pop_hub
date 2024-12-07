import 'package:flutter/material.dart';
import 'package:k_pop_hub/providers/theme_provider.dart';
import 'package:k_pop_hub/screens/home_screen.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = "";

  void _login() {
    if (_usernameController.text == 'user' && _passwordController.text == 'password') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      setState(() {
        _errorMessage = "Invalid credentials!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Hero animation for logo
              Hero(
                tag: 'app-logo',
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage("https://via.placeholder.com/120"),
                ),
              ),
              const SizedBox(height: 20),
              // Username TextField
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: "Username"),
              ),
              const SizedBox(height: 10),
              // Password TextField
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              const SizedBox(height: 20),
              // Login Button
              ElevatedButton(
                onPressed: _login,
                child: const Text("Login"),
              ),
              // Error Message
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              // Toggle Theme Button
              TextButton(
                onPressed: () {
                  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                  themeProvider.toggleTheme();
                },
                child: const Text("Toggle Theme"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
