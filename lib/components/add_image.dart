import 'dart:io';
import 'package:flutter/material.dart';

class AddImage extends StatefulWidget {
  final File? image;
  final VoidCallback? pickImage;

  const AddImage({this.image, this.pickImage});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
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
                onPressed: widget.pickImage,
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
            Center(
              child: widget.image != null
                  ? Image.file(
                      widget.image!,
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.cover,
                    )
                  : Container(),
            )
          ],
        ));
  }
}
