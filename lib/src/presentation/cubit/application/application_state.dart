import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_state.freezed.dart';

@freezed
class ApplicationState with _$ApplicationState {
  const factory ApplicationState.loading() = ApplicationLoading;

  const factory ApplicationState.loaded() = ApplicationLoaded;

  const factory ApplicationState.error() = ApplicationError;
}
