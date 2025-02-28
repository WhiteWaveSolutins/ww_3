

// DashboardService get dashboardService => serviceLocator<DashboardService>();
// DashboardApi get dashboardApi => serviceLocator<DashboardApi>();
// DashboardViewModel get dashboardViewModel =>
//     serviceLocator<DashboardViewModel>();

// class DashboardServiceLocator {
//   static Future<void> initialize() async {
//     serviceLocator
//         .registerLazySingleton<DashboardApi>(() => DashboardApiImpl());
//     serviceLocator
//         .registerLazySingleton<DashboardService>(() => DashboardServiceImpl());
//     serviceLocator
//         .registerFactory<DashboardViewModel>(() => DashboardViewModel());
//   }
// }
