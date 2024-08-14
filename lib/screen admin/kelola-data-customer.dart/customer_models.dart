// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class CustomerModels {
  String? idCustomer;
  String? namaCustomer;
  String? email;
  String? noHp;
  String? alamat;

  CustomerModels({
    this.idCustomer,
    this.namaCustomer,
    this.email,
    this.noHp,
    this.alamat,
  });

  CustomerModels.fromJson(Map<String, dynamic> json) {
    idCustomer = json['uid'];
    namaCustomer = json['nama_lengkap'];
    email = json['email'];
    noHp = json['nomor_handphone'];
    alamat = json['alamat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.idCustomer;
    data['nama_lengkap'] = this.namaCustomer;
    data['email'] = this.email;
    data['nomor_handphone'] = this.noHp;
    data['alamat'] = this.alamat;
    return data;
  }
}
