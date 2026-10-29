import 'package:fpdart/fpdart.dart';
import 'package:solar_check/core/user/domain/entities/user.entity.dart';

abstract class UserRepository {
  Future<void> saveUser(UserEntity user);
  Either<UserEntity, String> getUser();
  Future<void> clearUser();
}
