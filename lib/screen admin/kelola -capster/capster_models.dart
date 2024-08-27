// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class CapsterModels {
  String? idCapster;
  String? namaCapster;
  String? imageCapster;

  CapsterModels({
    this.idCapster,
    this.namaCapster,
    this.imageCapster,
  });

  CapsterModels.fromJson(Map<String, dynamic> json) {
    idCapster = json['id_capster'];
    namaCapster = json['nama_capster'];
    imageCapster = json['image_capster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_capster'] = this.idCapster;
    data['nama_capster'] = this.namaCapster;
    data['image_capster'] = this.imageCapster;
    return data;
  }
}
