import 'package:flutter/material.dart';

class SoonScreen extends StatelessWidget {
  const SoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coming soon"),
      ),
      backgroundColor: Theme.of(context).canvasColor,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Transform.rotate(
                angle: -0.25, // Tilting the "Coming Soon!" text
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(
                          0xFFD30132), // Ternary color for the border
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(
                        10), // Optional rounded corners for the border
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Coming Soon!',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD30132), // Ternary color for text
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'We\'re working on something amazing.\nStay tuned!',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF233645), // Primary color
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
