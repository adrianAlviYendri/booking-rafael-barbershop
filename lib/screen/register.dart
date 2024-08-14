import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/component/app_eleveted_button_widgets.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-data-customer.dart/customer_controller.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RegisterController());

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white
                        .withOpacity(0.9), // Transparansi latar belakang
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildTextField(
                        controller: controller.namaLengkapController,
                        label: 'Nama Lengkap',
                        isPassword: false,
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        controller: controller.noHandphoneController,
                        label: 'No Handphone',
                        isPassword: false,
                        icon: Icons.phone,
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        controller: controller.emailController,
                        label: 'Email',
                        isPassword: false,
                        icon: Icons.email,
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        controller: controller.passwordController,
                        label: 'Password',
                        isPassword: true,
                        icon: Icons.lock,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: controller.alamatController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
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
                      const SizedBox(height: 30),
                      AppElevetedButtonWidgets(
                        onPressed: () {
                          controller.handleRegister();
                        },
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30),
                        backgroundColor: Colors.grey[
                            800], // Ubah warna tombol menjadi abu-abu gelap
                        shadowColor: Colors.grey[600],
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.login.name);
                        },
                        child: Text(
                          'Back to Login',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
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
