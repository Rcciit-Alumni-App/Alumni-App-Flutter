import 'package:flutter/material.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/Buttons/button4.dart';
import 'package:frontend/components/Dropdown/dropdown_multiselect.dart';
import 'package:frontend/components/add_image.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/components/formfield.dart';
import 'package:frontend/components/formfield_chips.dart';
import 'package:frontend/constants/constants.dart';

class CreatePost extends StatefulWidget {
  @override
  State<CreatePost> createState() => _CreatePostState();

  TextfieldMultiController hashtag = TextfieldMultiController();
}

class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundAddDetailsPage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
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
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        MyTextField(
                          hintText: "Description",
                          opacity: 0.6,
                          height: 100.0,
                          maxLines: 4,
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
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Bottomnavbar(),
        )
      ],
    );
  }
}
