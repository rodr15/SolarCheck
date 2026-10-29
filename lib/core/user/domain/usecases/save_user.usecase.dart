import 'package:injectable/injectable.dart';
import 'package:solar_check/core/user/domain/entities/user.entity.dart';
import 'package:solar_check/core/user/domain/repositories/user.repository.dart';

@injectable
class SaveUserUseCase {
  final UserRepository _repository;

  SaveUserUseCase(this._repository);

  Future<void> call(UserEntity user) async {
    return await _repository.saveUser(user);
  }
}
