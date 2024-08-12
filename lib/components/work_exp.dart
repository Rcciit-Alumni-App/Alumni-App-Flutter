import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/date.dart';
import 'package:frontend/components/Dropdown/dropdown_button.dart';
import 'package:frontend/components/Dropdown/dropdown_multiselect.dart';
import 'package:frontend/components/formfield.dart';
import 'package:frontend/models/UserModel.dart';


class WorkExperienceFormWidget extends StatefulWidget {
  WorkExperienceFormWidget(
      {Key? key, required this.workExperience, required this.onRemove, required this.index})
      : super(key: key);

  final index;
  WorkExperience workExperience;
  final Function onRemove;
  final state = _WorkExperienceFormWidgetState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _jobRoleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateCalController startDateController = DateCalController();
  DateCalController endDateController = DateCalController();
  DropdownOptionController domainController = DropdownOptionController();
  DropdownMultiController skillsController = DropdownMultiController();

  // bool isValidated() => state.validate();
}

class _WorkExperienceFormWidgetState extends State<WorkExperienceFormWidget> {
  final formKey = GlobalKey<FormState>();

  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 1.11053,
              color: Color(0xFF2F80ED),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 15.0, right: 15.0, bottom: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Enter Job Details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                //Clear All forms Data
                                widget.workExperience.company = null;
                                widget.workExperience.role = null;
                                widget.workExperience.description = null;
                                widget.workExperience.domain = null;
                                widget.workExperience.skills = null;
                                widget.workExperience.startDate = null;
                                widget.workExperience.endDate = null;
                                widget._nameController.clear();
                                widget._jobRoleController.clear();
                                widget._descriptionController.clear();
                                widget.startDateController.clear();
                                widget.endDateController.clear();
                                widget.domainController.clear();
                                widget.skillsController.clear();
                              });
                            },
                            child: const Text(
                              "Clear",
                              style: TextStyle(color: Colors.blue),
                            )),
                        TextButton(
                            onPressed: () => widget.onRemove(),
                            child: const Text(
                              "Remove",
                              style: TextStyle(color: Colors.blue),
                            )),
                      ],
                    ),
                  ],
                ),
                MyTextField(
                  controller: widget._nameController,
                  onChanged: (value) => widget.workExperience.company = value,
                  onSaved: (value) => widget.workExperience.company = value,
                  hintText: "Company name",
                ),
                MyTextField(
                  controller: widget._jobRoleController,
                  onChanged: (value) => widget.workExperience.role = value,
                  onSaved: (value) => widget.workExperience.role = value,
                  hintText: "Job role",
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: DateCal(
                        controller: widget.startDateController,
                        onChanged: (value) => widget.workExperience.startDate = DateTime.parse(value!),
                        onSaved: (value) => widget.workExperience.startDate = DateTime.parse(value!),
                        initialText: "Start Date"
                      ),
                    ),
                    const SizedBox(width: 10.0), // Add some space between the fields
                    Expanded(
                      child: DateCal(
                        controller: widget.endDateController,
                        onChanged: (value) => widget.workExperience.endDate = DateTime.parse(value!),
                        onSaved: (value) => widget.workExperience.endDate = DateTime.parse(value!),
                        initialText: "End Date"
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                DropdownOption(
                  controller: widget.domainController,
                  onChanged: (value) => widget.workExperience.domain = value,
                  onSaved: (value) => widget.workExperience.domain = value,
                  caption: "Domain",
                ),
                const SizedBox(
                  height: 15.0,
                ),
                DropdownMulti(
                  controller: widget.skillsController,
                  onChanged: (value) => widget.workExperience.skills = value,
                  onSaved: (value) => widget.workExperience.skills = value,
                  caption: "Skills",
                ),
                MyTextField(
                  controller: widget._descriptionController,
                  onChanged: (value) => widget.workExperience.description = value,
                  onSaved: (value) => widget.workExperience.description = value,
                  hintText: "Description",
                  maxLines: 4,
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
