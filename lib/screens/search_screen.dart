import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Search",
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                // Add search functionality here
              },
            ),
            const Expanded(
              child: Center(
                child: Text("Search results will appear here."),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
