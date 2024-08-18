import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/Buttons/button4.dart';
import 'package:frontend/components/Dropdown/dropdown_multiselect.dart';
import 'package:frontend/components/add_image.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/components/formfield.dart';
import 'package:frontend/components/formfield_chips.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/NewsModel.dart';
import 'package:frontend/services/news_service.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CreatePost extends StatefulWidget {
  @override
  State<CreatePost> createState() => _CreatePostState();

  TextfieldMultiController hashtag = TextfieldMultiController();
}

class _CreatePostState extends State<CreatePost> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? title, desc;
  late NewsService newsService;

  File? _image;
  final picker = ImagePicker();
  String? _uploadedFileUrl;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    // 1. Get the pre-signed URL
    final fileName = _image!.path.split('/').last;
    final fileType = 'image/jpeg';
    final presignedUrlResponse = await http.get(
      Uri.parse(
          'http://your-backend-domain.com/upload/s3-url?fileName=$fileName&fileType=$fileType'),
    );

    if (presignedUrlResponse.statusCode == 200) {
      final presignedUrlData = json.decode(presignedUrlResponse.body);
      final presignedUrl = presignedUrlData['url'];
      final key = presignedUrlData['key'];

      // 2. Upload the file to S3 using the pre-signed URL
      final uploadResponse = await http.put(
        Uri.parse(presignedUrl),
        body: _image!.readAsBytesSync(),
        headers: {'Content-Type': fileType},
      );

      if (uploadResponse.statusCode == 200) {
        // 3. Store the file URL in the backend
        final updateResponse = await http.patch(
          Uri.parse(
              'http://your-backend-domain.com/upload/profile-picture/your-user-id'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'key': key}),
        );

        if (updateResponse.statusCode == 200) {
          setState(() {
            _uploadedFileUrl = json.decode(updateResponse.body)['url'];
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile picture uploaded successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update profile picture')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload file to S3')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get pre-signed URL')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    newsService = GetIt.instance<NewsService>();
  }

  Future<void> createNews(NewsSendModel news) async {
    try {
      await newsService.createNews(news);
      _uploadImage();
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundAddDetailsPage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create a New Post",
                    style: kRegisterHeading,
                  ),
                  SizedBox(
                    height: 70.0,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          MyTextField(
                            hintText: "Title",
                            opacity: 0.6,
                            onSaved: (value) {
                              setState(() {
                                title = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          MyTextField(
                            hintText: "Description",
                            opacity: 0.6,
                            height: 100.0,
                            maxLines: 4,
                            onSaved: (value) {
                              setState(() {
                                desc = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          AddImage(
                            image: _image,
                            pickImage: _pickImage,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          FormFieldChips(
                            controller: widget.hashtag,
                            caption: "Hashtag",
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Center(
                            child: CustomButton4(
                              label: "Next",
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _formKey.currentState?.save();
                                  NewsSendModel news = NewsSendModel(
                                    title: title!,
                                    description: desc!,
                                    tags: widget.hashtag.selectedItems,
                                    banner: "https://www.google.com",
                                  );
                                  createNews(news);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Bottomnavbar(),
        )
      ],
    );
  }
}
