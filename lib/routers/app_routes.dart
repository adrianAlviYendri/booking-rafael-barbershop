enum AppRoutes {
  register,
  login,
  loginAdmin,
  main,
  home,
  profile,
  addCapster,
  detailCapster,
}

extension AppRoutesExtention on AppRoutes {
  String get name {
    switch (this) {
      case AppRoutes.register:
        return '/register';
      case AppRoutes.login:
        return '/login';
      case AppRoutes.loginAdmin:
        return '/login-admin';
      case AppRoutes.main:
        return '/main';
      case AppRoutes.home:
        return '/home';
      case AppRoutes.profile:
        return '/profile';
      case AppRoutes.addCapster:
        return '/add-model';
      case AppRoutes.detailCapster:
        return '/detail-capster';
    }
  }
}
