import 'package:flutter/material.dart';
import 'service.dart';
import 'services_data.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 30,
                ),
                ...servicesList.map((service) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: Service(
                      name: service.name,
                      icon: Icon(
                        service.icon,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
