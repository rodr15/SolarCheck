import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_check/core/user/domain/entities/user.entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'email') required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
        name: entity.name,
        email: entity.email,
      );

  UserEntity toEntity() => UserEntity(
        name: name,
        email: email,
      );
}
