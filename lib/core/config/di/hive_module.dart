import 'package:hive_ce/hive_ce.dart';
import 'package:injectable/injectable.dart';

import '../constants/hive_boxes.dart';

@module
abstract class HiveModule {
  @lazySingleton
  @Named(HiveBoxes.settings)
  Box get settingsBox => Hive.box(HiveBoxes.settings);
}
