// ignore_for_file: prefer_collection_literals, unnecessary_new, unnecessary_this

class BookingModel {
  String? namaCapster;
  String? imageCapster;
  String? jamBooking;
  String? hariBooking;
  int? tanggalBooking;
  String? bulanBooking;
  int? tahunBooking;

  BookingModel({
    this.namaCapster,
    this.imageCapster,
    this.jamBooking,
    this.hariBooking,
    this.tanggalBooking,
    this.bulanBooking,
    this.tahunBooking,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_capster'] = this.namaCapster;
    data['image_capster'] = this.imageCapster;
    data['jam_booking'] = this.jamBooking;
    data['hari_booking'] = this.hariBooking;
    data['tanggal_booking'] = this.tanggalBooking;
    data['bulan_booking'] = this.bulanBooking;
    data['tahun_booking'] = this.tahunBooking;
    return data;
  }
}
