import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraState();
}

class _CameraState extends State<CameraPage> {
  //1. Buat dl controller camera
  late CameraController cameraController;

  //2. Deklarasikan index kamera mana yang akan dipakai
  late List cameras;

  @override
  void initState() {
    super.initState();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[EnumCameraDescription.back.index],
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    try {
      await cameraController.initialize();
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: initCamera(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: CameraPreview(cameraController)),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/images/overlay.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 1 / 4,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: const Text(
                          'POSISIKAN KTP PADA BINGKAI',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFa0a0a0).withOpacity(1),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 40,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.camera_enhance,
                          size: 40,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.flash_on,
                          size: 40,
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

enum EnumCameraDescription { back, front }
