import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/date.dart';
import 'package:frontend/components/Dropdown/dropdown_button.dart';
import 'package:frontend/components/Dropdown/dropdown_multiselect.dart';
import 'package:frontend/components/FormFields/formfield.dart';
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

  bool isValidated() => state.validate();
}

class _WorkExperienceFormWidgetState extends State<WorkExperienceFormWidget> {
  final formKey = GlobalKey<FormState>();

  bool checked = false;

  bool _hasError = false;

  bool validate() {
    // Validate Form Fields
    bool isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      formKey.currentState?.save();
    }
    setState(() {
      _hasError = !isValid;
    });
    return isValid;
  }

  String? _validateStartDate() {
  String? res;

  if (widget.startDateController.dateTime == null) {
    res = 'Please enter start date';
  }

  if (widget.startDateController.dateTime == null && widget.endDateController.dateTime != null) {
    res = 'Please enter start date';
  }

  // If only start date exists, check if it's valid
  if (widget.startDateController.dateTime != null && widget.endDateController.dateTime == null) {
    DateTime? startDate = widget.startDateController.dateTime;
    
    if (startDate != null && startDate.isAfter(DateTime.now())) {
      res = 'Please enter a valid date';
    }
  }

  // If both dates exist, check their validity
  if (widget.startDateController.dateTime != null && widget.endDateController.dateTime != null) {
    DateTime? startDate = widget.startDateController.dateTime;
    DateTime? endDate = widget.endDateController.dateTime;
    
    if (startDate != null && endDate != null && startDate.isAfter(endDate)) {
      res = 'Please enter a valid date';
    }
  }

  return res;
}

String? _validateEndDate() {
  String? res;

  if (widget.endDateController.dateTime != null) {
    DateTime? endDate = widget.endDateController.dateTime;
    
    if (endDate != null && endDate.isAfter(DateTime.now())) {
      res = 'Please enter a valid date';
    }
  }

  // If both dates exist, check their validity
  if (widget.startDateController.dateTime != null && widget.endDateController.dateTime != null) {
    DateTime? startDate = widget.startDateController.dateTime;
    DateTime? endDate = widget.endDateController.dateTime;
    
    if (startDate != null && endDate != null && startDate.isAfter(endDate)) {
      res = 'Please enter a valid date';
    }
  }

  return res;
}


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
              color:  _hasError ? Colors.red : Color(0xFF2F80ED),
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
                          color: _hasError ? Colors.red : Color(0xFF2F80ED)
                        ),
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
                            child: Text(
                              "Clear",
                              style: TextStyle(color: _hasError ? Colors.red : Color(0xFF2F80ED)),
                            )),
                        TextButton(
                            onPressed: () => widget.onRemove(),
                            child: Text(
                              "Remove",
                              style: TextStyle(color: _hasError ? Colors.red : Color(0xFF2F80ED),),
                            )),
                      ],
                    ),
                  ],
                ),
                MyTextField(
                  validator: (value) => value!.length > 3 ? null : "Enter Company Name",
                  controller: widget._nameController,
                  onChanged: (value) => widget.workExperience.company = value,
                  onSaved: (value) => widget.workExperience.company = value,
                  hintText: "Company name",
                ),
                MyTextField(
                  validator: (value) => value!.length > 3 ? null : "Enter Job Role",
                  controller: widget._jobRoleController,
                  onChanged: (value) => widget.workExperience.role = value,
                  onSaved: (value) => widget.workExperience.role = value,
                  hintText: "Job role",
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: DateCal(
                        validator: (_) => _validateStartDate(),
                        controller: widget.startDateController,
                        onChanged: (value) => widget.workExperience.startDate = value,
                        onSaved: (value) => widget.workExperience.startDate = value,
                        initialText: "Start Date"
                      ),
                    ),
                    const SizedBox(
                        width: 10.0), // Add some space between the fields
                    !checked ? Expanded(
                      child: DateCal(
                        validator: (_) => _validateEndDate(),
                        controller: widget.endDateController,
                        onChanged: (value) => widget.workExperience.endDate = value,
                        onSaved: (value) => widget.workExperience.endDate = value,
                        initialText: "End Date"
                      ),
                    ) : Expanded(child: Container())
                  ],
                ),

                const SizedBox(
                  height: 10.0,
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Checkbox(
                        value: checked,
                        onChanged: (_) {
                          setState(() {
                            widget.endDateController.clear();
                            widget.workExperience.endDate = null;
                            checked = !checked;
                          });
                        }
                      ),
                      Text(
                        'I Currently Work Here',
                        style: TextStyle(
                          color: _hasError ? Colors.red : Color(0xFF2F80ED),
                        )
                      )
                    ],
                  ),

                ),

                const SizedBox(
                  height: 10.0,
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
