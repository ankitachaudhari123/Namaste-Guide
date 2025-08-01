import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'expersics.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List yogaplanlist = [];
  bool isLoading = true; // 👈 Added loading state

  Future<void> yogaplans() async {
    String uri = "http://192.168.31.71/namaste_guide_api/feach_yoga_plans.php";

    try {
      var response = await http.post(Uri.parse(uri));

      if (response.statusCode == 200) {
        setState(() {
          yogaplanlist = jsonDecode(response.body);
          isLoading = false; // 👈 Stop loading
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Exception: $e");
      setState(() {
        isLoading = false;
      });
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
        title: const Text("All Plans"),
        backgroundColor: const Color(0xff1f1835),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff1f1835),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: yogaplanlist.isNotEmpty ? yogaplanlist.length : 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              String yogaPlanId =
                                  yogaplanlist[index]['yoga_plan_id'].toString();
                              print("Selected yogaPlanId: $yogaPlanId");

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Breathing_expercise(yogaPlanId: yogaPlanId),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 185,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                  colors: [Color(0xff7c49de), Color(0xffdcb383)],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 170,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40, horizontal: 20),
                                    child: Text(
                                      yogaplanlist[index]['yoga_plan_name'] ??
                                          "No Name",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'asset/${yogaplanlist[index]['yoga_plan_image'] ?? 'default_image.png'}',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
