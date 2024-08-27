enum AppRoutes {
  register,
  login,
  main,
  home,
  profile,
  detailCapster,
  detailBooking,
  addMetodePembayaran,
  getMetodePembayaran,
  myOrder,
  laporanPerHari,
  laporanPerBulan,
  laporanPerTahun,
  addCapster,
  kelolaJadwalCuti,
  addMenu,
  selectMenu,
  viewDetailBooking,
  detailMyOrder,
  kelolaHairStyle,
  kelolaHairColor,
  kelolaDataPelanggan,
  detailDataCustomer,
}

extension AppRoutesExtention on AppRoutes {
  String get name {
    switch (this) {
      case AppRoutes.register:
        return '/register';
      case AppRoutes.login:
        return '/login';
      case AppRoutes.main:
        return '/main';
      case AppRoutes.home:
        return '/home';
      case AppRoutes.profile:
        return '/profile';
      case AppRoutes.detailCapster:
        return '/detail-capster';
      case AppRoutes.detailBooking:
        return '/detail-booking';
      case AppRoutes.myOrder:
        return '/my-order';
      case AppRoutes.laporanPerHari:
        return '/lap-per-hari';
      case AppRoutes.laporanPerBulan:
        return '/lap-per-bulan';
      case AppRoutes.laporanPerTahun:
        return '/lap-per-tahun';
      case AppRoutes.addCapster:
        return '/add-capster';
      case AppRoutes.kelolaJadwalCuti:
        return '/kelola-jadwal-cuti-capster';
      case AppRoutes.addMetodePembayaran:
        return '/add-metode-pembayaran';
      case AppRoutes.getMetodePembayaran:
        return '/get-metode-pembayaran';
      case AppRoutes.addMenu:
        return '/add-menu';
      case AppRoutes.selectMenu:
        return '/select-menu';
      case AppRoutes.viewDetailBooking:
        return '/view-detail-booking';
      case AppRoutes.detailMyOrder:
        return '/detail-my-order';
      case AppRoutes.kelolaHairStyle:
        return '/kelola-hair-style';
      case AppRoutes.kelolaHairColor:
        return '/kelola-hair-color';
      case AppRoutes.kelolaDataPelanggan:
        return '/kelola-data-pelanggan';
      case AppRoutes.detailDataCustomer:
        return '/detail-data-customer';
    }
  }
}
