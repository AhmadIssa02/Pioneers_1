import 'package:flutter/material.dart';

import '../screens/soon_screen.dart';
class Service extends StatelessWidget {
  final String name;
  final Icon icon;

  const Service({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SoonScreen(),
              ),
            );
          },
          child: CircleAvatar(
            backgroundColor: Colors.red[800],
            radius: 26,
            child: icon,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        SizedBox(
          width: 75,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
              overflow: TextOverflow.fade,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
