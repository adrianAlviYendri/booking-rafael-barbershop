// ignore_for_file: deprecated_member_use, prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:rafael_barbershop_app/component/app_eleveted_button_widgets.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-laporan-booking/get_data_booking_controller.dart';
import 'package:rafael_barbershop_app/models/booking_models.dart';

class LaporanPerBulanScreen extends StatelessWidget {
  const LaporanPerBulanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(GetDataBookingController());

    // Use RxInt for observables; initialize with 0 or any default value
    RxInt selectedMonth = RxInt(0);
    RxInt selectedYear = RxInt(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Per Bulan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () async {
              if (controller.dataBooking.isNotEmpty) {
                final pdfData = await controller.generatePdf(
                    controller.dataBooking,
                    controller.totalRevenuePerMonth,
                    'Bulan');
                await Printing.layoutPdf(
                    onLayout: (PdfPageFormat format) async => pdfData);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Obx(() => InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 7),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            hint: Text(selectedMonth.value > 0
                                ? DateFormat.MMMM()
                                    .format(DateTime(0, selectedMonth.value))
                                : 'Pilih Bulan'),
                            value: selectedMonth.value > 0
                                ? selectedMonth.value
                                : null,
                            items: List.generate(12, (index) => index + 1)
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(DateFormat.MMMM()
                                          .format(DateTime(0, e))),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              selectedMonth.value = value ?? 0;
                              controller.getDataBooking(
                                  month: selectedMonth.value,
                                  year: selectedYear.value);
                            },
                          ),
                        ),
                      )),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Obx(
                    () => InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 7),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          hint: Text(selectedYear.value > 0
                              ? selectedYear.value.toString()
                              : 'Pilih Tahun'),
                          value: selectedYear.value > 0
                              ? selectedYear.value
                              : null,
                          items: List.generate(
                                  5, (index) => DateTime.now().year - index)
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.toString()),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            selectedYear.value = value ?? 0;
                            controller.getDataBooking(
                                month: selectedMonth.value,
                                year: selectedYear.value);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Obx(
              () => Text(
                'Total Pendapatan bulan Ini : Rp.${controller.totalRevenuePerMonth}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(
                () {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (controller.dataBooking.isEmpty) {
                    return const Center(
                      child: Text('Data Tidak Ditemukan'),
                    );
                  }
                  RxList<BookingModel> listBooking = controller.dataBooking;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 12,
                      dataRowHeight: 60,
                      headingRowHeight: 60,
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey[200]!),
                      columns: const [
                        DataColumn(label: Text('No')),
                        DataColumn(label: Text('Nama Pelanggan')),
                        DataColumn(label: Text('Nama Capster')),
                        DataColumn(label: Text('Menu Booking')),
                        DataColumn(label: Text('Jam Booking')),
                        DataColumn(label: Text('Hari Booking')),
                        DataColumn(label: Text('Tanggal Booking')),
                        DataColumn(label: Text('Bulan Booking')),
                        DataColumn(label: Text('Tahun Booking')),
                        DataColumn(label: Text('Bukti Pembayaran')),
                        DataColumn(label: Text('Jumlah Pembayaran')),
                        DataColumn(label: Text('Status Pembookingan')),
                        DataColumn(label: Text('Aksi')),
                      ],
                      rows: listBooking.asMap().entries.map((entry) {
                        int index = entry.key + 1; // Penomoran mulai dari 1
                        BookingModel e = entry.value;
                        return DataRow(
                          cells: [
                            DataCell(Text(index.toString())),
                            DataCell(Text(e.namaPelanggan ?? '')),
                            DataCell(Text(e.namaCapster ?? '')),
                            DataCell(Text(e.menu ?? '')),
                            DataCell(Text(e.jamBooking ?? '')),
                            DataCell(Text(e.hariBooking ?? '')),
                            DataCell(Text(e.tanggalBooking.toString())),
                            DataCell(Text(e.bulanBooking ?? '')),
                            DataCell(Text(e.tahunBooking.toString())),
                            DataCell(
                              GestureDetector(
                                onTap: () {
                                  if (e.buktiPembayaran != null) {
                                    controller.buktiPaymentDialog(
                                        context, e.buktiPembayaran!);
                                  }
                                },
                                child: e.buktiPembayaran != null
                                    ? Image.network(
                                        e.buktiPembayaran!,
                                        fit: BoxFit.cover,
                                        width: 80,
                                        height: 50,
                                        loadingBuilder:
                                            (context, child, progress) {
                                          if (progress == null) {
                                            return child;
                                          } else {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: progress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? progress
                                                            .cumulativeBytesLoaded /
                                                        (progress
                                                                .expectedTotalBytes ??
                                                            1)
                                                    : null,
                                              ),
                                            );
                                          }
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Center(
                                            child: Text('Error loading image'),
                                          );
                                        },
                                      )
                                    : const Placeholder(
                                        color: Colors.grey,
                                        fallbackHeight: 120,
                                      ),
                              ),
                            ),
                            DataCell(Text(e.harga.toString())),
                            DataCell(
                              Row(
                                children: [
                                  if (e.statusPembayaran == 'Pending')
                                    AppElevetedButtonWidgets(
                                      onPressed: () {
                                        controller
                                            .showUpdatePaymentStatusDialog(
                                          context,
                                          e.idBooking!,
                                        );
                                      },
                                      elevation: 8,
                                      borderRadius: BorderRadius.circular(30),
                                      backgroundColor:
                                          Colors.amber[700]!, // Updated color
                                      child: Text(
                                        'Pending',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  if (e.statusPembayaran == 'Success')
                                    AppElevetedButtonWidgets(
                                      onPressed: () {},
                                      elevation: 8,
                                      borderRadius: BorderRadius.circular(30),
                                      backgroundColor:
                                          Colors.green[600]!, // Updated color
                                      child: Text(
                                        'Success',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            DataCell(
                              IconButton(
                                onPressed: () {
                                  controller.showDeleteConfirmationBooking(
                                      context, e);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
