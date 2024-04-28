import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_textrecognition/models/ktp_model.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'detector.dart';

class TextRecognitionService {
  static Future<Either<String, KtpModel>> scanningKtp(
      {http.Client? client, required File image}) async {
    String nikResult = "";
    String nameResult = "";
    String tempatLahirResult = "";
    String tglLahirResult = "";
    String jenisKelaminResult = "";
    String alamatFullResult = "";
    String alamatResult = "";
    String rtrwResult = "";
    String kelDesaResult = "";
    String kecamatanResult = "";
    String agamaResult = "";
    String statusKawinResult = "";
    String pekerjaanResult = "";
    String kewarganegaraanResult = "";

    Rect? nikRect;
    Rect? namaRect;
    Rect? alamatRect;
    Rect? rtrwRect;
    Rect? kelDesaRect;
    Rect? kecamatanRect;
    Rect? jenisKelaminRect;
    Rect? tempatTanggalLahirRect;
    Rect? agamaRect;
    Rect? statusKawinRect;
    Rect? pekerjaanRect;
    Rect? kewarganegaraanRect;

    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer();
    final RecognizedText visionText =
        await textRecognizer.processImage(inputImage);

    try {
      for (int i = 0; i < visionText.blocks.length; i++) {
        for (int j = 0; j < visionText.blocks[i].lines.length; j++) {
          for (int k = 0;
              k < visionText.blocks[i].lines[j].elements.length;
              k++) {
            final data = visionText.blocks[i].lines[j].elements[k];

            print("b$i l$j e$k " +
                data.text.toLowerCase().trim().replaceAll(" ", "") +
                " " +
                data.boundingBox.center.toString());

            if (checkNikField(data.text)) {
              nikRect = data.boundingBox;
              print("nik field detected");
            }

            if (checkNamaField(data.text)) {
              namaRect = data.boundingBox;
              print("nama field detected");
            }

            if (checkTglLahirField(data.text)) {
              tempatTanggalLahirRect = data.boundingBox;
              print("tempat tgllahir field detected");
            }

            if (checkJenisKelaminField(data.text)) {
              jenisKelaminRect = data.boundingBox;
              print("jenis kelamin field detected");
            }

            if (checkAlamatField(data.text)) {
              alamatRect = data.boundingBox;
              print("alamat field detected");
            }

            if (checkRtRwField(data.text)) {
              rtrwRect = data.boundingBox;
              print("RT/RW field detected");
            }

            if (checkKelDesaField(data.text)) {
              kelDesaRect = data.boundingBox;
              print("kelurahan / desa field detected");
            }

            if (checkKecamatanField(data.text)) {
              kecamatanRect = data.boundingBox;
              print("kecamatan field detected");
            }

            if (checkAgamaField(data.text)) {
              agamaRect = data.boundingBox;
              print("agama field detected");
            }

            if (checkKawinField(data.text)) {
              statusKawinRect = data.boundingBox;
              print("statusKawin field detected");
            }

            if (checkPekerjaanField(data.text)) {
              pekerjaanRect = data.boundingBox;
              print("pekerjaan field detected");
            }

            if (checkKewarganegaraanField(data.text)) {
              kewarganegaraanRect = data.boundingBox;
              print("kewarganegaraan field detected");
            }
          }
        }
      }
    } catch (e) {
      print(e);
      return left('Gagal scanning');
    }

    try {
      for (int i = 0; i < visionText.blocks.length; i++) {
        for (int j = 0; j < visionText.blocks[i].lines.length; j++) {
          final data = visionText.blocks[i].lines[j];

          if (isInside(data.boundingBox, nikRect)) {
            nikResult = nikResult + " " + data.text;
            print("------ nik");
            print(nikResult);
          }

          if (isInside3rect(
              isThisRect: data.boundingBox,
              isInside: namaRect,
              andAbove: tempatTanggalLahirRect)) {
            if (data.text.toLowerCase() != "nama") {
              print("------ name");
              nameResult = (nameResult + " " + data.text).trim();
              print(nameResult);
            }
          }

          if (isInside(data.boundingBox, tempatTanggalLahirRect)) {
            final temp = data.text.replaceAll("Tempat/Tgi Lahir", "");
            tempatLahirResult = temp.substring(0, temp.indexOf(',') + 1);
            print("------ tempat lahir");
            print(tempatLahirResult);
          }

          if (isInside(data.boundingBox, tempatTanggalLahirRect)) {
            final temp = data.text.replaceAll("Tempat/Tgi Lahir", "");
            final result = temp.substring(0, temp.indexOf(',') + 1);
            print(result);
            if (result.isNotEmpty) {
              tglLahirResult =
                  temp.replaceAll(result, "").replaceAll(":", "").trim();
            }

            print("------ tgllahir");
            print(tglLahirResult);
          }

          if (isInside(data.boundingBox, jenisKelaminRect)) {
            jenisKelaminResult = jenisKelaminResult + " " + data.text;
            print("------ jenis kelamin ");
            print(rtrwResult);
          }

          if (isInside3rect(
              isThisRect: data.boundingBox,
              isInside: alamatRect,
              andAbove: agamaRect)) {
            alamatFullResult = alamatFullResult + " " + data.text;
            print("------ alamat");
            print(alamatFullResult);
          }

          if (isInside(data.boundingBox, alamatRect)) {
            alamatResult = alamatResult + " " + data.text;
            print("------ alamat  ");
            print(alamatResult);
          }

          if (isInside(data.boundingBox, rtrwRect)) {
            rtrwResult = rtrwResult + " " + data.text;
            print("------ rt rw ");
            print(rtrwResult);
          }

          if (isInside(data.boundingBox, kelDesaRect)) {
            kelDesaResult = kelDesaResult + " " + data.text;
            print("------ keldesa");
            print(kelDesaResult);
          }

          if (isInside(data.boundingBox, kecamatanRect)) {
            kecamatanResult = kecamatanResult + " " + data.text;
            print("------ kecamatan");
            print(kecamatanResult);
          }

          if (isInside(data.boundingBox, agamaRect)) {
            agamaResult = agamaResult + " " + data.text;
            print("------ agama : $agamaResult");
          }

          if (isInside(data.boundingBox, statusKawinRect)) {
            statusKawinResult = statusKawinResult + " " + data.text;
            print("------ status kawin result ");
            print(statusKawinResult);
          }

          if (isInside(data.boundingBox, pekerjaanRect)) {
            pekerjaanResult = pekerjaanResult + " " + data.text;
            print("------ status pekerjaan result ");
            print(pekerjaanResult);
          }

          if (isInside(data.boundingBox, kewarganegaraanRect)) {
            kewarganegaraanResult = kewarganegaraanResult + " " + data.text;
            print("------ status kewarganegaraan result ");
            print(kewarganegaraanResult);
          }
        }
      }
    } catch (e) {
      print(e);
      throw Exception("iteration failed");
    }

    final result = KtpModel(
        namaLengkap: nameResult,
        tanggalLahir: tglLahirResult,
        alamatFull: alamatFullResult,
        agama: agamaResult,
        statusPerkawinan: statusKawinResult,
        pekerjaan: pekerjaanResult,
        nik: nikResult,
        kewarganegaraan: kewarganegaraanResult,
        golDarah: "null",
        tempatLahir: tempatLahirResult,
        jenisKelamin: jenisKelaminResult,
        alamat: alamatResult,
        kecamatan: kecamatanResult,
        kelDesa: kelDesaResult,
        rtrw: rtrwResult);

    return right(result);
  }
}
