import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File? _image;
  List<File> listImage = [];

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        listImage.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 16.0;
    return Container(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Color(0xFF2F80ED),
            width: 1.11053,
          ),
          color: Colors.grey[200]!.withOpacity(0.7),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextButton(
                onPressed: _pickImage,
                child: Row(
                  children: [
                    Icon(
                      Icons.add_photo_alternate_rounded,
                      color: Color(0xFF2F80ED),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Add Image",
                      style: TextStyle(
                        color: Color(0xFF2F80ED),
                        fontSize: 17.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                ...listImage
                    .map((image) => Image.file(
                          image!,
                          height: 100.0,
                          width: 100.0,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
              ],
            )
          ],
        ));
  }
}
