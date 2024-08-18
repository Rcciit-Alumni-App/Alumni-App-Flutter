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


class CreatePost extends StatefulWidget {
  @override
  State<CreatePost> createState() => _CreatePostState();

  TextfieldMultiController hashtag = TextfieldMultiController();
}

class _CreatePostState extends State<CreatePost> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? title, desc;
  late NewsService newsService;

  @override
  void initState() {
    super.initState();
    newsService = GetIt.instance<NewsService>();
  }

  Future<void> createNews(NewsSendModel news) async {
    try {
      await newsService.createNews(news);
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
                          AddImage(),
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
                                if (_formKey.currentState?.validate() ?? false) {
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
