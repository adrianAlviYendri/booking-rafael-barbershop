// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class HairColorModels {
  String? idHairColor;
  String? namaHairColor;
  String? imageHairColor;

  HairColorModels({
    this.idHairColor,
    this.namaHairColor,
    this.imageHairColor,
  });

  HairColorModels.fromJson(Map<String, dynamic> json) {
    idHairColor = json['id_hair_color'];
    namaHairColor = json['nama_warna_rambut'];
    imageHairColor = json['gambar_warna_rambut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_hair_color'] = this.idHairColor;
    data['nama_warna_rambut'] = this.namaHairColor;
    data['gambar_warna_rambut'] = this.imageHairColor;
    return data;
  }
}
