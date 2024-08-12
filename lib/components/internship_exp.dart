import 'package:flutter/material.dart';
import 'package:frontend/components/date.dart';
import 'package:frontend/components/dropdown_button.dart';
import 'package:frontend/components/formfield.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/UserModel.dart';


class InternshipExperienceFormWidget extends StatefulWidget {
  InternshipExperienceFormWidget(
      {Key? key, required this.internshipExperience, required this.onRemove, required this.index})
      : super(key: key);

  final index;
  Internship internshipExperience;
  final Function onRemove;
  final state = _InternshipExperienceFormWidgetState();

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
  DropdownOptionController skillsController = DropdownOptionController();
}

class _InternshipExperienceFormWidgetState extends State<InternshipExperienceFormWidget> {
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
            padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0, bottom: 16.0),
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
                                widget.internshipExperience.company = null;
                                widget.internshipExperience.role = null;
                                widget.internshipExperience.description = null;
                                widget.internshipExperience.domain = null;
                                widget.internshipExperience.skills = null;
                                widget.internshipExperience.startDate = null;
                                widget.internshipExperience.endDate = null;
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
                  onChanged: (value) => widget.internshipExperience.company = value,
                  onSaved: (value) => widget.internshipExperience.company = value,
                  hintText: "Company name",
                ),
                MyTextField(
                  controller: widget._jobRoleController,
                  onChanged: (value) => widget.internshipExperience.role = value,
                  onSaved: (value) => widget.internshipExperience.role = value,
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
                        onChanged: (value) => widget.internshipExperience.startDate = DateTime.parse(value!),
                        onSaved: (value) => widget.internshipExperience.startDate = DateTime.parse(value!),
                        initialText: "Start Date"
                      ),
                    ),
                    const SizedBox(width: 10.0), // Add some space between the fields
                    !checked ? Expanded(
                      child: DateCal(
                        controller: widget.endDateController,
                        onChanged: (value) => widget.internshipExperience.endDate = DateTime.parse(value!),
                        onSaved: (value) => widget.internshipExperience.endDate = DateTime.parse(value!),
                        initialText: "End Date"
                      ),
                    ) : Expanded(child: Container())
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Checkbox(
                        value: checked,
                        onChanged: (_) {
                          setState(() {
                            checked = !checked;
                          });
                        }
                      ),
                      Text(
                        'I Currently Work Here',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                        )
                      )
                    ],
                  ),

                ),
                const SizedBox(
                  height: 15.0,
                ),
                DropdownOption(
                  controller: widget.domainController,
                  onChanged: (value) => widget.internshipExperience.domain = value,
                  onSaved: (value) => widget.internshipExperience.domain = value,
                  caption: "Domain",
                ),
                const SizedBox(
                  height: 15.0,
                ),
                DropdownOption(
                  controller: widget.skillsController,
                  onChanged: (value) => widget.internshipExperience.skills = [value],
                  onSaved: (value) => widget.internshipExperience.skills = [value],
                  caption: "Skills",
                ),
                MyTextField(
                  controller: widget._descriptionController,
                  onChanged: (value) => widget.internshipExperience.description = value,
                  onSaved: (value) => widget.internshipExperience.description = value,
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
