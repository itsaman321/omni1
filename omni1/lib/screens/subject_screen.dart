import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../providers/services.dart';

class SubjectScreen extends StatefulWidget {
  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

enum ImageType {
  subject,
  evidence,
}

class _SubjectScreenState extends State<SubjectScreen> {
  GenderClassification gc = GenderClassification();
  // ignore: prefer_typing_uninitialized_variables
  var _subjectImage;
  var modelOutput;
  var _evidenceImage;

  // ignore: prefer_final_fields
  bool _isLoading = false;

  Future getGalleryImage(ImageType imageType) async {
    if (imageType == ImageType.subject) {
      _subjectImage = null;
    }
    if (imageType == ImageType.evidence) {
      _evidenceImage = null;
    }
    final image =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      if (imageType == ImageType.subject) {
        _subjectImage = image;
      } else {
        _evidenceImage = image;
      }
    });
  }

  Future getCameraImage(ImageType imageType) async {
    if (imageType == ImageType.subject) {
      _subjectImage = null;
    }
    if (imageType == ImageType.evidence) {
      _evidenceImage = null;
    }

    final image =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.getImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        if (imageType == ImageType.subject) {
          _subjectImage = image ;
        } else {
          _evidenceImage = image ;
        }
      }
    });
  }

  @override
  void didChangeDependencies() async {
    _subjectImage = null;

    _evidenceImage = null;

    await gc.loadModel().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/main_logo.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Subject',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      image: _subjectImage != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(_subjectImage.path),
                              ),
                            )
                          : null,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12,
                    ),
                    height: 150,
                    child: Center(
                      child: _subjectImage != null
                          ? null
                          : const Center(
                              child: Text('Add an Image'),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(15),
                          ),
                        ),
                        onPressed: () {
                          getCameraImage(ImageType.subject);
                        },
                        child: const Text('Take from Camera'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(15),
                          ),
                        ),
                        onPressed: () {
                          getGalleryImage(ImageType.subject);
                        },
                        child: const Text('Upload from Gallery'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      image: _evidenceImage != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(_evidenceImage.path),
                              ),
                            )
                          : null,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12,
                    ),
                    height: 150,
                    child: Center(
                      child: _evidenceImage != null
                          ? null
                          : const Center(
                              child: Text('Add an Image'),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(15),
                          ),
                        ),
                        onPressed: () {
                          getCameraImage(ImageType.evidence);
                        },
                        child: const Text('Take from Camera'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(15),
                          ),
                        ),
                        onPressed: () {
                          getGalleryImage(ImageType.evidence);
                        },
                        child: const Text('Upload from Gallery'),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(15),
                  ),
                ),
                onPressed: () async {
                  modelOutput = await gc.classifyImage(
                      File(_subjectImage.path), File(_evidenceImage.path));
                  Navigator.of(context).pushNamed('/output', arguments: {
                    'gender1': modelOutput['1'][0]['label'],
                    'gender2': modelOutput['2'][0]['label'],
                    'image1': File(_subjectImage.path),
                    'image2': File(_evidenceImage.path),
                  });
                },
                child: const Text('Process Model'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
