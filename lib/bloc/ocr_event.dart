part of 'ocr_bloc.dart';

sealed class OcrEvent extends Equatable {
  const OcrEvent();

  @override
  List<Object> get props => [];
}

final class OnScanningProccess extends OcrEvent {
  final File? selectedImage;

  const OnScanningProccess({this.selectedImage});
}
