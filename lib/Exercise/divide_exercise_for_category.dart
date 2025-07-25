import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class divide_exercises extends StatefulWidget {
  final String yogaPlanId;
  const divide_exercises({super.key, required this.yogaPlanId});

  @override
  State<divide_exercises> createState() => _divide_exercisesState();
}

class _divide_exercisesState extends State<divide_exercises> {

   List category = [];
  bool isLoading = true;

  Future<void> yogaplans() async {
    String uri = "http://192.168.31.71/namaste_guide_api/feach_category.php";

    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {'yoga_plan_id': widget.yogaPlanId}, 
      );

      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        setState(() {
          category = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Exception: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    yogaplans();
  }


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
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : category.isEmpty
                ? const Center(
                    child: Text(
                      "No categories found",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.70,
                    children: List.generate(category.length, (index) {
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
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10)),
                                  child: Image.asset(
                                    'assets/${category[index]['image']?? "image not found"}',
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Text
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  category[index]['category_name'] ?? '',
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