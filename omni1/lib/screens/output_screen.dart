import 'package:flutter/material.dart';


class ImageOutput extends StatefulWidget {
  const ImageOutput({Key? key}) : super(key: key);
  @override
  State<ImageOutput> createState() => _ImageOutputState();
}

class _ImageOutputState extends State<ImageOutput> {
  var output;
  @override
  void didChangeDependencies() {
    output = ModalRoute.of(context)!.settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: sized_box_for_whitespace
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Image Process Results :',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(output['image1']),
                ),
              ),
            ),
            Text(
              output['gender1'] == '0 Men' ? 'Men' : 'Women',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(output['image2']),
                ),
              ),
            ),
            Text(
              output['gender2'] == '0 Men' ? 'Men' : 'Women',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
