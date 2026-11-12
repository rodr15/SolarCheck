import 'package:hive_ce/hive_ce.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/data/models/inspection.model.dart';
import 'package:solar_check/features/projects/data/models/project.model.dart';

import '../constants/hive_boxes.dart';

@module
abstract class HiveModule {
  @lazySingleton
  @Named(HiveBoxes.settings)
  Box get settingsBox => Hive.box(HiveBoxes.settings);

  @lazySingleton
  @Named(HiveBoxes.projects)
  Box<ProjectModel> get projectBox =>
      Hive.box<ProjectModel>(HiveBoxes.projects);

  @lazySingleton
  @Named(HiveBoxes.inspections)
  Box<InspectionModel> get inspectionsBox =>
      Hive.box<InspectionModel>(HiveBoxes.inspections);
}
