import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String hospitalName;

  DetailPage({Key? key, required this.hospitalName}) : super(key: key);

  // Sample hospital details
  final Map<String, Map<String, dynamic>> hospitalDetails = {
    'Hospital A': {
      'address': 'Connaught Place, Delhi',
      'contact': '+91 12345 67890',
      'services': 'Emergency, ICU, Maternity, Surgery'
    },
    'Hospital B': {
      'address': 'North Delhi, Near University',
      'contact': '+91 98765 43210',
      'services': 'Cardiology, Pediatrics, Neurology'
    },
    'Hospital C': {
      'address': 'South Delhi, Saket',
      'contact': '+91 11223 44556',
      'services': 'Orthopedics, Cancer Care, Dialysis'
    },
    'Hospital D': {
      'address': 'Gurgaon, Near Cyber City',
      'contact': '+91 66789 01234',
      'services': 'Trauma Care, Emergency, OPD'
    },
    'Hospital E': {
      'address': 'Noida, Sector 18',
      'contact': '+91 99887 66554',
      'services': 'Radiology, General Medicine, Surgery'
    },
  };

  @override
  Widget build(BuildContext context) {
    final details = hospitalDetails[hospitalName] ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text(hospitalName),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hospital Name: $hospitalName',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Address: ${details['address'] ?? 'No address available'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Contact: ${details['contact'] ?? 'No contact available'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Services: ${details['services'] ?? 'No services available'}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
