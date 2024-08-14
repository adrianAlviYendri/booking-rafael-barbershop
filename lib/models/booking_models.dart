// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this
class BookingModel {
  String? idBooking;
  String? userId;
  String? namaPelanggan;
  String? noHandphone;
  String? namaCapster;
  String? imageCapster;
  String? jamBooking;
  String? hariBooking;
  int? tanggalBooking;
  String? bulanBooking;
  int? tahunBooking;
  String? buktiPembayaran;
  String? menu;
  int? harga;
  String? statusPembayaran;

  BookingModel({
    this.idBooking,
    this.userId,
    this.namaCapster,
    this.imageCapster,
    this.jamBooking,
    this.hariBooking,
    this.tanggalBooking,
    this.bulanBooking,
    this.tahunBooking,
    this.buktiPembayaran,
    this.menu,
    this.harga,
    this.namaPelanggan,
    this.noHandphone,
    this.statusPembayaran,
  });

  BookingModel.fromJson(Map<String, dynamic> json) {
    idBooking = json['id_booking'];
    userId = json['user_id'];
    namaPelanggan = json['nama_pelanggan'];
    namaCapster = json['nama_capster'];
    noHandphone = json['no_handphone'];
    imageCapster = json['image_capster'];
    jamBooking = json['jam_booking'];
    hariBooking = json['hari_booking'];
    tanggalBooking = json['tanggal_booking'];
    bulanBooking = json['bulan_booking'];
    tahunBooking = json['tahun_booking'];
    buktiPembayaran = json['bukti_pembayaran'];
    menu = json['nama_menu'];
    harga = json['harga'];
    statusPembayaran = json['status_pembayaran'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_booking'] = this.idBooking;
    data['user_id'] = this.userId;
    data['nama_pelanggan'] = this.namaPelanggan;
    data['nama_capster'] = this.namaCapster;
    data['no_handphone'] = this.noHandphone;
    data['image_capster'] = this.imageCapster;
    data['jam_booking'] = this.jamBooking;
    data['hari_booking'] = this.hariBooking;
    data['tanggal_booking'] = this.tanggalBooking;
    data['bulan_booking'] = this.bulanBooking;
    data['tahun_booking'] = this.tahunBooking;
    data['bukti_pembayaran'] = this.buktiPembayaran;
    data['nama_menu'] = this.menu;
    data['harga'] = this.harga;
    data['status_pembayaran'] = this.statusPembayaran;
    return data;
  }
}
