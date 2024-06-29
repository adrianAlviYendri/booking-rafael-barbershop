// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class CapsterModels {
  String? namaCapster;
  String? imageCapster;

  CapsterModels({
    this.namaCapster,
    this.imageCapster,
  });

  CapsterModels.fromJson(Map<String, dynamic> json) {
    namaCapster = json['nama_capster'];
    imageCapster = json['image_capster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_capster'] = this.namaCapster;
    data['image_capster'] = this.imageCapster;
    return data;
  }
}
