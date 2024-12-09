

// CompaniesApi get companyApi => serviceLocator<CompaniesApi>();
// CompanyService get companyService => serviceLocator<CompanyService>();
// CompanyViewModel get companyViewModel => serviceLocator<CompanyViewModel>();

// class CompanyServiceLocator {
//   static Future<void> initialize() async {
//     serviceLocator
//         .registerLazySingleton<CompaniesApi>(() => CompaniesApiImpl());
//     serviceLocator
//         .registerLazySingleton<CompanyService>(() => CompanyServiceImpl());
//     serviceLocator.registerFactory<CompanyViewModel>(() => CompanyViewModel());
//   }
// }
