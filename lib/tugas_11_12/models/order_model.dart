class OrderModel {
  int? id;
  String namaCustomer;
  String namaProduk;
  int jumlah;
  int totalHarga;
  String alamat;

  OrderModel({
    this.id,
    required this.namaCustomer,
    required this.namaProduk,
    required this.jumlah,
    required this.totalHarga,
    required this.alamat,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'namaCustomer': namaCustomer,
      'namaProduk': namaProduk,
      'jumlah': jumlah,
      'totalHarga': totalHarga,
      'alamat': alamat,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      namaCustomer: map['namaCustomer'],
      namaProduk: map['namaProduk'],
      jumlah: map['jumlah'],
      totalHarga: map['totalHarga'],
      alamat: map['alamat'],
    );
  }
}
