// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_form_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegisterFormEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RegisterFormEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RegisterFormEvent()';
  }
}

/// @nodoc
class $RegisterFormEventCopyWith<$Res> {
  $RegisterFormEventCopyWith(
      RegisterFormEvent _, $Res Function(RegisterFormEvent) __);
}

/// Adds pattern-matching-related methods to [RegisterFormEvent].
extension RegisterFormEventPatterns on RegisterFormEvent {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NameChanged value)? nameChanged,
    TResult Function(_EmailChanged value)? emailChanged,
    TResult Function(_FormSubmitted value)? formSubmitted,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NameChanged() when nameChanged != null:
        return nameChanged(_that);
      case _EmailChanged() when emailChanged != null:
        return emailChanged(_that);
      case _FormSubmitted() when formSubmitted != null:
        return formSubmitted(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NameChanged value) nameChanged,
    required TResult Function(_EmailChanged value) emailChanged,
    required TResult Function(_FormSubmitted value) formSubmitted,
  }) {
    final _that = this;
    switch (_that) {
      case _NameChanged():
        return nameChanged(_that);
      case _EmailChanged():
        return emailChanged(_that);
      case _FormSubmitted():
        return formSubmitted(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NameChanged value)? nameChanged,
    TResult? Function(_EmailChanged value)? emailChanged,
    TResult? Function(_FormSubmitted value)? formSubmitted,
  }) {
    final _that = this;
    switch (_that) {
      case _NameChanged() when nameChanged != null:
        return nameChanged(_that);
      case _EmailChanged() when emailChanged != null:
        return emailChanged(_that);
      case _FormSubmitted() when formSubmitted != null:
        return formSubmitted(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(String email)? emailChanged,
    TResult Function()? formSubmitted,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NameChanged() when nameChanged != null:
        return nameChanged(_that.name);
      case _EmailChanged() when emailChanged != null:
        return emailChanged(_that.email);
      case _FormSubmitted() when formSubmitted != null:
        return formSubmitted();
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function() formSubmitted,
  }) {
    final _that = this;
    switch (_that) {
      case _NameChanged():
        return nameChanged(_that.name);
      case _EmailChanged():
        return emailChanged(_that.email);
      case _FormSubmitted():
        return formSubmitted();
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function()? formSubmitted,
  }) {
    final _that = this;
    switch (_that) {
      case _NameChanged() when nameChanged != null:
        return nameChanged(_that.name);
      case _EmailChanged() when emailChanged != null:
        return emailChanged(_that.email);
      case _FormSubmitted() when formSubmitted != null:
        return formSubmitted();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NameChanged implements RegisterFormEvent {
  const _NameChanged(this.name);

  final String name;

  /// Create a copy of RegisterFormEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NameChangedCopyWith<_NameChanged> get copyWith =>
      __$NameChangedCopyWithImpl<_NameChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NameChanged &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, name);
  }

  @override
  String toString() {
    return 'RegisterFormEvent.nameChanged(name: $name)';
  }
}

/// @nodoc
abstract mixin class _$NameChangedCopyWith<$Res>
    implements $RegisterFormEventCopyWith<$Res> {
  factory _$NameChangedCopyWith(
          _NameChanged value, $Res Function(_NameChanged) _then) =
      __$NameChangedCopyWithImpl;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$NameChangedCopyWithImpl<$Res> implements _$NameChangedCopyWith<$Res> {
  __$NameChangedCopyWithImpl(this._self, this._then);

  final _NameChanged _self;
  final $Res Function(_NameChanged) _then;

  /// Create a copy of RegisterFormEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
  }) {
    return _then(_NameChanged(
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _EmailChanged implements RegisterFormEvent {
  const _EmailChanged(this.email);

  final String email;

  /// Create a copy of RegisterFormEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EmailChangedCopyWith<_EmailChanged> get copyWith =>
      __$EmailChangedCopyWithImpl<_EmailChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EmailChanged &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, email);
  }

  @override
  String toString() {
    return 'RegisterFormEvent.emailChanged(email: $email)';
  }
}

/// @nodoc
abstract mixin class _$EmailChangedCopyWith<$Res>
    implements $RegisterFormEventCopyWith<$Res> {
  factory _$EmailChangedCopyWith(
          _EmailChanged value, $Res Function(_EmailChanged) _then) =
      __$EmailChangedCopyWithImpl;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$EmailChangedCopyWithImpl<$Res>
    implements _$EmailChangedCopyWith<$Res> {
  __$EmailChangedCopyWithImpl(this._self, this._then);

  final _EmailChanged _self;
  final $Res Function(_EmailChanged) _then;

  /// Create a copy of RegisterFormEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? email = null,
  }) {
    return _then(_EmailChanged(
      null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _FormSubmitted implements RegisterFormEvent {
  const _FormSubmitted();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _FormSubmitted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RegisterFormEvent.formSubmitted()';
  }
}

/// @nodoc
mixin _$RegisterFormState {
  NameInput get name;
  EmailInput get email;
  FormzSubmissionStatus get status;

  /// Create a copy of RegisterFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegisterFormStateCopyWith<RegisterFormState> get copyWith =>
      _$RegisterFormStateCopyWithImpl<RegisterFormState>(
          this as RegisterFormState, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as RegisterFormState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegisterFormState &&
            (identical(other.name, _this.name) || other.name == _this.name) &&
            (identical(other.email, _this.email) ||
                other.email == _this.email) &&
            (identical(other.status, _this.status) ||
                other.status == _this.status));
  }

  @override
  int get hashCode {
    final _this = this as RegisterFormState;
    return Object.hash(runtimeType, _this.name, _this.email, _this.status);
  }

  @override
  String toString() {
    final _this = this as RegisterFormState;
    return 'RegisterFormState(name: ${_this.name}, email: ${_this.email}, status: ${_this.status})';
  }
}

/// @nodoc
abstract mixin class $RegisterFormStateCopyWith<$Res> {
  factory $RegisterFormStateCopyWith(
          RegisterFormState value, $Res Function(RegisterFormState) _then) =
      _$RegisterFormStateCopyWithImpl;
  @useResult
  $Res call({NameInput name, EmailInput email, FormzSubmissionStatus status});
}

/// @nodoc
class _$RegisterFormStateCopyWithImpl<$Res>
    implements $RegisterFormStateCopyWith<$Res> {
  _$RegisterFormStateCopyWithImpl(this._self, this._then);

  final RegisterFormState _self;
  final $Res Function(RegisterFormState) _then;

  /// Create a copy of RegisterFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? status = null,
  }) {
    return _then(RegisterFormState(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as NameInput,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as EmailInput,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
    ));
  }
}

/// Adds pattern-matching-related methods to [RegisterFormState].
extension RegisterFormStatePatterns on RegisterFormState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RegisterFormState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegisterFormState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_RegisterFormState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterFormState():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_RegisterFormState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterFormState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            NameInput name, EmailInput email, FormzSubmissionStatus status)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegisterFormState() when $default != null:
        return $default(_that.name, _that.email, _that.status);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            NameInput name, EmailInput email, FormzSubmissionStatus status)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterFormState():
        return $default(_that.name, _that.email, _that.status);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            NameInput name, EmailInput email, FormzSubmissionStatus status)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterFormState() when $default != null:
        return $default(_that.name, _that.email, _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RegisterFormState extends RegisterFormState {
  const _RegisterFormState(
      {this.name = const NameInput.pure(),
      this.email = const EmailInput.pure(),
      this.status = FormzSubmissionStatus.initial})
      : super._();

  @override
  @JsonKey()
  final NameInput name;
  @override
  @JsonKey()
  final EmailInput email;
  @override
  @JsonKey()
  final FormzSubmissionStatus status;

  /// Create a copy of RegisterFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegisterFormStateCopyWith<_RegisterFormState> get copyWith =>
      __$RegisterFormStateCopyWithImpl<_RegisterFormState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegisterFormState &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, name, email, status);
  }

  @override
  String toString() {
    return 'RegisterFormState(name: $name, email: $email, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$RegisterFormStateCopyWith<$Res>
    implements $RegisterFormStateCopyWith<$Res> {
  factory _$RegisterFormStateCopyWith(
          _RegisterFormState value, $Res Function(_RegisterFormState) _then) =
      __$RegisterFormStateCopyWithImpl;
  @override
  @useResult
  $Res call({NameInput name, EmailInput email, FormzSubmissionStatus status});
}

/// @nodoc
class __$RegisterFormStateCopyWithImpl<$Res>
    implements _$RegisterFormStateCopyWith<$Res> {
  __$RegisterFormStateCopyWithImpl(this._self, this._then);

  final _RegisterFormState _self;
  final $Res Function(_RegisterFormState) _then;

  /// Create a copy of RegisterFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? status = null,
  }) {
    return _then(_RegisterFormState(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as NameInput,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as EmailInput,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
    ));
  }
}

// dart format on
