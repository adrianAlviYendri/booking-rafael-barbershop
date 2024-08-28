import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-hair-color/bottom_sheet_add_hair_color.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-hair-color/hair_color_controller.dart';

class AddHairColorScreen extends StatelessWidget {
  const AddHairColorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HairColorController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Kelola Hair Color',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.dataHairColor.isEmpty) {
          return const Center(child: Text('Tidak ada data Hair Color.'));
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 0.75,
            ),
            itemCount: controller.dataHairColor.length,
            itemBuilder: (context, index) {
              final hairColor = controller.dataHairColor[index];
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15)),
                        child: hairColor.imageHairColor != null
                            ? Image.network(
                                hairColor.imageHairColor!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: progress.expectedTotalBytes !=
                                                null
                                            ? progress.cumulativeBytesLoaded /
                                                (progress.expectedTotalBytes ??
                                                    1)
                                            : null,
                                      ),
                                    );
                                  }
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                      child: Text('Error loading image'));
                                },
                              )
                            : const Placeholder(
                                color: Colors.grey,
                                fallbackHeight: 120,
                              ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[800],
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            hairColor.namaHairColor ?? 'Tidak Ada Nama',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 21,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              controller.showDeleteConfirmationHairColor(
                                  context, hairColor);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return const BottomSheetAddHairColor();
            },
          );
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(
          Icons.add,
          size: 24,
          color: Colors.black,
        ),
      ),
    );
  }
}
