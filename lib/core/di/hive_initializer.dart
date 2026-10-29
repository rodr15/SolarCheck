import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:solar_check/core/di/injection.dart';
import 'package:solar_check/core/user/data/models/user_model.dart';
import '../constants/hive_boxes.dart';

class HiveInitializer {
  static Future<void> init(GetIt sl) async {
    await Hive.initFlutter();

    if (kDebugMode) {
      await Hive.deleteBoxFromDisk(HiveBoxes.settings);
    }
    await configureHiveBoxes(sl);
  }

  static Future<void> configureHiveBoxes(GetIt sl) async {
    await Hive.openBox(HiveBoxes.settings);

    Hive.registerAdapter(UserModelAdapter());
  }
}
