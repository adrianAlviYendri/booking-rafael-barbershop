// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class MenuModels {
  String? namaMenu;
  int? harga;

  MenuModels({
    this.namaMenu,
    this.harga,
  });

  MenuModels.fromJson(Map<String, dynamic> json) {
    namaMenu = json['nama_menu'];
    harga = json['harga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_menu'] = this.namaMenu;
    data['harga'] = this.harga;
    return data;
  }
}
