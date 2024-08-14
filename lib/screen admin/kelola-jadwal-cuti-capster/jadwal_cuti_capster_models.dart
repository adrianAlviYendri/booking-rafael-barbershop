class JadwalCutiCapsterModels {
  final String idCuti;
  final int tanggalBooking;
  final String bulanBooking;
  final int tahunBooking;
  final String namaCapster;

  JadwalCutiCapsterModels({
    required this.idCuti,
    required this.tanggalBooking,
    required this.bulanBooking,
    required this.tahunBooking,
    required this.namaCapster,
  });

  factory JadwalCutiCapsterModels.fromJson(Map<String, dynamic> json) {
    return JadwalCutiCapsterModels(
      idCuti: json['id_cuti'] ?? '',
      tanggalBooking: json['tanggal_booking'] ?? 0,
      bulanBooking: json['bulan_booking'] ?? '',
      tahunBooking: json['tahun_booking'] ?? 0,
      namaCapster: json['nama_capster'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_cuti': idCuti,
      'tanggal_booking': tanggalBooking,
      'bulan_booking': bulanBooking,
      'tahun_booking': tahunBooking,
      'nama_capster': namaCapster,
    };
  }
}
