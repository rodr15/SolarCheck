import 'package:hive_ce/hive_ce.dart';
import 'package:solar_check/core/user/domain/entities/user.entity.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends UserEntity {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  const UserModel({
    required this.name,
    required this.email,
  }) : super(name: name, email: email);

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      name: entity.name,
      email: entity.email,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      name: name,
      email: email,
    );
  }
}
