// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class HairStyleModels {
  String? idHairStyle;
  String? namaHairStyle;
  String? imageHairStyle;

  HairStyleModels({
    this.idHairStyle,
    this.namaHairStyle,
    this.imageHairStyle,
  });

  HairStyleModels.fromJson(Map<String, dynamic> json) {
    idHairStyle = json['id_hair_style'];
    namaHairStyle = json['nama_gaya_rambut'];
    imageHairStyle = json['gambar_gaya_rambut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_hair_style'] = this.idHairStyle;
    data['nama_gaya_rambut'] = this.namaHairStyle;
    data['gambar_gaya_rambut'] = this.imageHairStyle;
    return data;
  }
}
