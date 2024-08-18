import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/formfield.dart';
import 'package:frontend/models/UserModel.dart';
import 'package:frontend/components/Socials/socials_regex.dart';

class Socials extends StatefulWidget {
  Socials(
      {Key? key,
      required this.socialLinkModel,
      required this.onRemove,
      required this.label,
      required this.hintText})
      : super(key: key);

  final state = _SocialsState();

  final String? label;
  final String? hintText;
  final SocialLink socialLinkModel;
  final Function() onRemove;

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  TextEditingController _urlController = TextEditingController();

  // bool isValidated() => state.validate();
}

class _SocialsState extends State<Socials> {
  final formKey = GlobalKey<FormState>();

  bool validate() {
    // Validate Form Fields
    bool isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      formKey.currentState?.save();
    }
    return isValid;
  }

  IconData? _icon;
  SocialMediaPlatform _socialMediaPlatform = SocialMediaPlatform.others;

  @override
  void initState() {
    super.initState();
    setState(() {
      _icon = SocialsRegex.getIcon(_socialMediaPlatform);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: MyTextField(
                maxLines: 1,
                iconColor: Theme.of(context).colorScheme.primary,
                icons: _icon,
                label: widget.label,
                controller: widget._urlController,
                onChanged: (value) {
                  widget.socialLinkModel.url = value;
                  widget.socialLinkModel.platform = _socialMediaPlatform.toString().split('.')[1];
                  setState(() {
                    _socialMediaPlatform = SocialsRegex.detectSocialMediaPlatform(value);
                    _icon = SocialsRegex.getIcon(_socialMediaPlatform);
                  });
                },
                hintText: widget.hintText,
              ),
            ),
            TextButton(
              onPressed: widget.onRemove,
              child: const Text(
                "Remove",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
