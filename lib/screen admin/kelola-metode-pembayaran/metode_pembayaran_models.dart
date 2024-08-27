// ignore_for_file: prefer_collection_literals, unnecessary_new, unnecessary_this

class MetodePembayaranModels {
  String? idMetode;
  String? imageQr;
  String? jenisMetode;
  String? keterangan;

  MetodePembayaranModels({
    this.idMetode,
    this.imageQr,
    this.jenisMetode,
    this.keterangan,
  });

  MetodePembayaranModels.fromJson(Map<String, dynamic> json) {
    idMetode = json['id_metode'];
    imageQr = json['image_qr'];
    jenisMetode = json['jenis_metode'];
    keterangan = json['keterangan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_metode'] = this.idMetode;
    data['image_qr'] = this.imageQr;
    data['jenis_metode'] = this.jenisMetode;
    data['keterangan'] = this.keterangan;
    return data;
  }
}
