import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class YourInfo extends StatefulWidget {
  const YourInfo({super.key});

  @override
  State<YourInfo> createState() => _YourInfoState();
}

class _YourInfoState extends State<YourInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Info",
          ),
          backgroundColor: Color(0xff1f1835),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff1f1835),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow("Username", "Ankita Balram Chaudhari"),
            _buildInfoRow("Weight", "55 kg"),
            _buildInfoRow("Height", "165 cm"),
            _buildInfoRow("BMI", "20.2"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label : ",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
