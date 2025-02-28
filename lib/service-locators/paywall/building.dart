

// BuildingService get buildingService => serviceLocator<BuildingService>();
// BuildingApi get buildingApi => serviceLocator<BuildingApi>();
// BuildingViewModel get buildingViewModel => serviceLocator<BuildingViewModel>();

// class BuildingServiceLocator {
//   static Future<void> initialize() async {
//     serviceLocator.registerLazySingleton<BuildingApi>(() => BuildingApiImpl());
//     serviceLocator
//         .registerLazySingleton<BuildingService>(() => BuildingServiceImpl());
//     serviceLocator
//         .registerFactory<BuildingViewModel>(() => BuildingViewModel());
//   }
// }
