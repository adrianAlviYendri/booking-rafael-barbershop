// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-data-customer.dart/customer_models.dart';

class DetailDataCustomer extends StatelessWidget {
  final CustomerModels customerData;
  const DetailDataCustomer({required this.customerData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Details'),
        backgroundColor: Colors.deepPurple, // AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.deepPurple,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Customer Information
            buildDetailCard(
              title: 'Name',
              value: customerData.namaCustomer ?? 'No name',
              icon: Icons.person,
            ),
            buildDetailCard(
              title: 'Email',
              value: customerData.email ?? 'No email',
              icon: Icons.email,
            ),
            buildDetailCard(
              title: 'Phone Number',
              value: customerData.noHp ?? 'No phone number',
              icon: Icons.phone,
            ),
            buildDetailCard(
              title: 'Address',
              value: customerData.alamat ?? 'No address',
              icon: Icons.location_on,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailCard(
      {required String title, required String value, required IconData icon}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Icon(
          icon,
          color: Colors.deepPurple,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        subtitle: Text(value),
      ),
    );
  }
}
