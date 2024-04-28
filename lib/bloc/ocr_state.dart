part of 'ocr_bloc.dart';

sealed class OcrState extends Equatable {
  const OcrState();

  @override
  List<Object> get props => [];
}

final class OcrInitial extends OcrState {}

final class ScanningProcess extends OcrState {}

final class ScanningFailed extends OcrState {
  final String? message;

  const ScanningFailed({this.message});
}

final class ScanningSuccess extends OcrState {
  final KtpModel? ktpModel;

  const ScanningSuccess({this.ktpModel});
}
