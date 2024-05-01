import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_textrecognition/bloc/ocr_bloc.dart';
import 'package:flutter_textrecognition/camera_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OcrBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final XFile? image;

  const MyHomePage({super.key, required this.title, this.image});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;
  Future<void> getImageFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setState(() {
          image = File(pickedImage.path);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OcrBloc, OcrState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              if (image == null)
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                ),
              if (image != null)
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: Image.file(image!),
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      child: const Text('Upload'),
                      onPressed: () {
                        getImageFromGallery();
                        if (image != null) {
                          context
                              .read<OcrBloc>()
                              .add(OnScanningProccess(selectedImage: image));
                        }
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      child: const Text('Ambil Gambar'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CameraPage()));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              (state is ScanningSuccess)
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.60,
                      child: Column(
                        children: [
                          Text(state.ktpModel!.namaLengkap!),
                          Text(state.ktpModel!.agama!),
                          Text(state.ktpModel!.alamat!),
                          Text(state.ktpModel!.alamatFull!),
                          Text(state.ktpModel!.golDarah!),
                          Text(state.ktpModel!.kecamatan!),
                          Text(state.ktpModel!.kelDesa!),
                          Text(state.ktpModel!.kewarganegaraan!),
                          Text(state.ktpModel!.nik!),
                          Text(state.ktpModel!.pekerjaan!),
                          Text(state.ktpModel!.rtrw!),
                          Text(state.ktpModel!.statusPerkawinan!),
                          Text(state.ktpModel!.tanggalLahir!),
                          Text(state.ktpModel!.tempatLahir!),
                          Text(state.ktpModel!.jenisKelamin!),
                        ],
                      ),
                    )
                  : (state is ScanningProcess)
                      ? const Text('Scanning Proccess...')
                      : const SizedBox()
            ],
          ),
        );
      },
    );
  }
}
