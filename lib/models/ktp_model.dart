import 'package:equatable/equatable.dart';

class KtpModel extends Equatable {
  final String? nik;
  final String? namaLengkap;
  final String? tempatLahir;
  final String? tanggalLahir;
  final String? jenisKelamin;
  final String? golDarah;
  final String? alamatFull;
  final String? alamat;
  final String? rtrw;
  final String? kelDesa;
  final String? kecamatan;
  final String? agama;
  final String? statusPerkawinan;
  final String? pekerjaan;
  final String? kewarganegaraan;

  const KtpModel({
    this.nik,
    this.namaLengkap,
    this.tempatLahir,
    this.tanggalLahir,
    this.jenisKelamin,
    this.golDarah,
    this.alamatFull,
    this.alamat,
    this.rtrw,
    this.kelDesa,
    this.kecamatan,
    this.agama,
    this.statusPerkawinan,
    this.pekerjaan,
    this.kewarganegaraan,
  });

  KtpModel copyWith(
    String? nik,
    String? namaLengkap,
    String? tempatLahir,
    String? tanggalLahir,
    String? jenisKelamin,
    String? golDarah,
    String? alamatFull,
    String? alamat,
    String? rtrw,
    String? kelDesa,
    String? kecamatan,
    String? agama,
    String? statusPerkawinan,
    String? pekerjaan,
    String? kewarganegaraan,
  ) =>
      KtpModel(
        nik: this.nik ?? nik,
        namaLengkap: this.namaLengkap ?? namaLengkap,
        tempatLahir: this.tempatLahir ?? tempatLahir,
        jenisKelamin: this.jenisKelamin ?? jenisKelamin,
        golDarah: this.golDarah ?? golDarah,
        alamatFull: this.alamatFull ?? alamatFull,
        alamat: this.alamat ?? alamat,
        rtrw: this.rtrw ?? rtrw,
        kelDesa: this.kelDesa ?? kelDesa,
        agama: this.agama ?? agama,
        statusPerkawinan: this.statusPerkawinan ?? statusPerkawinan,
        pekerjaan: this.pekerjaan ?? pekerjaan,
        kewarganegaraan: this.kewarganegaraan ?? kewarganegaraan,
      );

  factory KtpModel.fromJson(Map<String, dynamic> json) => KtpModel(
        nik: json['nik'],
        namaLengkap: json['nama_lengkap'],
        tempatLahir: json['tempat_lahir'],
        tanggalLahir: json['tanggal_lahir'],
        jenisKelamin: json['jenis_kelamin'],
        golDarah: json['gol_darah'],
        alamatFull: json['alamat_full'],
        alamat: json['alamat'],
        rtrw: json['rtrw'],
        kelDesa: json['kel_desa'],
        kecamatan: json['kecamatan'],
        agama: json['agama'],
        statusPerkawinan: json['status_perkawinan'],
        pekerjaan: json['pekerjaan'],
        kewarganegaraan: json['kewarganegaraan'],
      );

  Map<String, dynamic> toJson() => {
        "nik": nik,
        "nama_lengkap": namaLengkap,
        "tempat_lahir": tempatLahir,
        "tanggal_lahir": tanggalLahir,
        "jenis_kelamin": jenisKelamin,
        "gol_darah": golDarah,
        "alamat_full": alamatFull,
        "alamat": alamat,
        "rtrw": rtrw,
        "kel_desa": kelDesa,
        "kecamatan": kecamatan,
        "agama": agama,
        "status_perkawinan": statusPerkawinan,
        "pekerjaan": pekerjaan,
        "kewarganegaraan": kewarganegaraan,
      };

  @override
  List<Object?> get props => [
        nik,
        namaLengkap,
        tempatLahir,
        tanggalLahir,
        jenisKelamin,
        golDarah,
        alamatFull,
        alamat,
        rtrw,
        kelDesa,
        kecamatan,
        agama,
        statusPerkawinan,
        pekerjaan,
        kewarganegaraan
      ];
}
