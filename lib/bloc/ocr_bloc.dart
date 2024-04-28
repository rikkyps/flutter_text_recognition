import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_textrecognition/models/ktp_model.dart';
import 'package:flutter_textrecognition/services/text_recognition_service.dart';

part 'ocr_event.dart';
part 'ocr_state.dart';

class OcrBloc extends Bloc<OcrEvent, OcrState> {
  OcrBloc() : super(OcrInitial()) {
    on<OcrEvent>((event, emit) async {
      if (event is OnScanningProccess) {
        emit(ScanningProcess());

        final result = await TextRecognitionService.scanningKtp(
            image: event.selectedImage!);

        result.fold((l) => {emit(ScanningFailed(message: l))},
            (r) => {emit(ScanningSuccess(ktpModel: r))});
      }
    });
  }
}
