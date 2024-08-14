import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-data-customer.dart/customer_models.dart';

class RegisterController extends GetxController {
  TextEditingController namaLengkapController = TextEditingController();
  TextEditingController noHandphoneController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var dataCustomer = <CustomerModels>[].obs;
  var filteredCustomers = <CustomerModels>[].obs;

  @override
  void onInit() {
    super.onInit();
    getDataCustomers();
  }

  void handleRegister() async {
    try {
      var cradential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      var user = FirebaseFirestore.instance.collection("customer");

      if (cradential.user != null) {
        user
            .add({
              'uid': cradential.user?.uid,
              'email': cradential.user?.email,
              'nama_lengkap': namaLengkapController.text,
              'nomor_handphone': noHandphoneController.text,
              'alamat': alamatController.text,
            })
            .then((value) => debugPrint("user added"))
            .catchError((error) => debugPrint("failed to add user : $error"));
      }
      namaLengkapController.clear();
      noHandphoneController.clear();
      alamatController.clear();
      emailController.clear();
      passwordController.clear();
      Get.snackbar('Pendaftaran akun Berhasil', '');
    } on FirebaseAuthException catch (exception) {
      debugPrint(exception.code);
    }
  }

  Future<void> getDataCustomers() async {
    isLoading.value = true;
    try {
      final snapshot = await _db.collection('customer').get();
      dataCustomer.value = snapshot.docs.map((doc) {
        final menu = CustomerModels.fromJson(doc.data());
        return menu;
      }).toList();
    } finally {
      isLoading.value = false;
    }
  }

  void searchCustomers(String query) {
    if (query.isEmpty) {
      filteredCustomers.value = dataCustomer;
    } else {
      filteredCustomers.value = dataCustomer
          .where((customer) => (customer.namaCustomer ?? '')
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
  }

  Future<void> deleteDataCustomer(CustomerModels customer) async {
    try {
      final querySnapshot = await _db
          .collection('customer')
          .where('uid', isEqualTo: customer.idCustomer)
          .get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      getDataCustomers();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus Data Hair Style: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void showDeleteConfirmationCustomer(
      BuildContext context, CustomerModels customer) {
    Get.dialog(
      AlertDialog(
        title: const Text('Konfirmasi Penghapusan'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete_forever, size: 50, color: Colors.red),
            SizedBox(height: 20),
            Text(
              'Apakah Anda yakin ingin menghapus data Customer?',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Tidak'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              deleteDataCustomer(customer);
              Get.back();
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

  void showAddDataCustomer(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Tambah Data Customer'),
        content: Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              textFieldAddCustomer(
                controller: namaLengkapController,
                label: 'Nama Lengkap',
                isPassword: false,
                icon: Icons.person,
              ),
              const SizedBox(height: 15),
              textFieldAddCustomer(
                controller: noHandphoneController,
                label: 'No Handphone',
                isPassword: false,
                icon: Icons.phone,
              ),
              const SizedBox(height: 15),
              textFieldAddCustomer(
                controller: emailController,
                label: 'Email',
                isPassword: false,
                icon: Icons.email,
              ),
              const SizedBox(height: 15),
              textFieldAddCustomer(
                controller: passwordController,
                label: 'Password',
                isPassword: true,
                icon: Icons.lock,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: alamatController,
                maxLines: 3,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  labelText: 'Alamat',
                  labelStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey[800]!),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Tidak'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              handleRegister();
              Get.back();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Widget textFieldAddCustomer({
    required TextEditingController controller,
    required String label,
    required bool isPassword,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey[800]),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey[800]!),
        ),
      ),
    );
  }
}
