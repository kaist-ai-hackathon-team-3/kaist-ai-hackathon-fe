import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<String> categories;

  const HomePage(this.categories, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                categories[index],
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
