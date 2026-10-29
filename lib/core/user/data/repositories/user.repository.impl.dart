import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/core/user/data/datasources/user.datasource.dart';
import 'package:solar_check/core/user/domain/entities/user.entity.dart';
import 'package:solar_check/core/user/domain/repositories/user.repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource _localDataSource;

  UserRepositoryImpl(this._localDataSource);

  @override
  Future<void> saveUser(UserEntity user) async {
    await _localDataSource.saveUser(name: user.name, email: user.email);
  }

  @override
  Either<UserEntity, String> getUser() {
    final data = _localDataSource.getUser();
    final name = data['name'];
    final email = data['email'];

    if (name == null || email == null) return Either.right('');

    final user = UserEntity(name: name, email: email);

    return Either.left(user);
  }

  @override
  Future<void> clearUser() async {
    /* [ASRF] TODO: Clean the user */
  }
}
