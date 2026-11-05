import 'package:hive_ce/hive_ce.dart';
import 'package:injectable/injectable.dart';
import '../../../config/constants/hive_boxes.dart';
import '../../../config/constants/hive_keys.dart';

abstract class UserLocalDataSource {
  Future<void> saveUser({required String name, required String email});
  Map<String, String?> getUser();
}

@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box _settingsBox;

  UserLocalDataSourceImpl(@Named(HiveBoxes.settings) this._settingsBox);

  @override
  Future<void> saveUser({required String name, required String email}) async {
    await _settingsBox.put(HiveKeys.settings.userName, name);
    await _settingsBox.put(HiveKeys.settings.userEmail, email);
  }

  @override
  Map<String, String?> getUser() {
    return {
      'name': _settingsBox.get(HiveKeys.settings.userName),
      'email': _settingsBox.get(HiveKeys.settings.userEmail),
    };
  }
}
