import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class divide_exercises extends StatefulWidget {
  const divide_exercises({super.key});

  @override
  State<divide_exercises> createState() => _divide_exercisesState();
}

class _divide_exercisesState extends State<divide_exercises> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        backgroundColor: const Color(0xff1f1835),
      ),
       body: Container(
        color: const Color(0xff1f1835),
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2, 
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.70,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                // handle tap
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [Color(0xff7c49de), Color(0xffdcb383)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.asset(
                          'asset/Pilates_Toning.png',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Text
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Ease Yoga for Beginners",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}