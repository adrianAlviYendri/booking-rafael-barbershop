// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-data-customer.dart/customer_controller.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';

class KelolaCustomerScreen extends StatelessWidget {
  const KelolaCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.put(RegisterController());
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pelanggan'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Field
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Cari Pelanggan',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                controller.searchCustomers(value);
              },
            ),
            const SizedBox(height: 16), // Spacing between search and list
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.dataCustomer.isEmpty) {
                  return const Center(child: Text('Tidak ada data Pelanggan.'));
                } else {
                  return ListView.builder(
                    itemCount: controller.filteredCustomers.length,
                    itemBuilder: (context, index) {
                      var customer = controller.filteredCustomers[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.detailDataCustomer.name,
                              arguments: customer);
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 4,
                          child: ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Colors.blueGrey,
                              size: 40,
                            ),
                            title: Text(
                              customer.namaCustomer ?? 'No Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Email: ${customer.email ?? 'Tidak ada'}',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                controller.showDeleteConfirmationCustomer(
                                    context, customer);
                              },
                              icon: Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.showAddDataCustomer(context);
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(
          Icons.add,
          size: 24,
        ),
      ),
    );
  }
}
