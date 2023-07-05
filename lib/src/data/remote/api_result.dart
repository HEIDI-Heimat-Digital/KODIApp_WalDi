import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/remote/network_exceptions.dart';

part 'api_result.freezed.dart';

@freezed
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;

  const factory ApiResult.failure({
    @Default(NetworkExceptions.defaultError('Error')) NetworkExceptions error,
  }) = Failure<T>;
}
