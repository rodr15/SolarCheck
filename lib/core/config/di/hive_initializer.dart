import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:solar_check/core/user/data/models/user_model.dart';

import 'package:solar_check/features/projects/data/models/inspection.model.dart';
import 'package:solar_check/features/projects/data/models/project.model.dart';

import '../constants/hive_boxes.dart';

class HiveInitializer {
  static Future<void> init(GetIt sl) async {
    await Hive.initFlutter();

    // if (kDebugMode) {
    //   await Hive.deleteBoxFromDisk(HiveBoxes.settings);
    // }
    await configureHiveBoxes(sl);
  }

  static Future<void> configureHiveBoxes(GetIt sl) async {
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(ProjectModelAdapter());
    Hive.registerAdapter(InspectionModelAdapter());

    await Hive.openBox(HiveBoxes.settings);
    await Hive.openBox<ProjectModel>(HiveBoxes.projects);
    await Hive.openBox<InspectionModel>(HiveBoxes.inspections);
  }
}
