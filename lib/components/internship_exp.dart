import 'package:flutter/material.dart';
import 'package:frontend/components/Dropdown/dropdown_button.dart';
import 'package:frontend/components/Dropdown/dropdown_multiselect.dart';
import 'package:frontend/components/date.dart';
import 'package:frontend/components/FormFields/formfield.dart';
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

  bool isValidated() => state.validate();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _jobRoleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateCalController startDateController = DateCalController();
  DateCalController endDateController = DateCalController();
  DropdownOptionController domainController = DropdownOptionController();
  DropdownMultiController skillsController = DropdownMultiController();
}

class _InternshipExperienceFormWidgetState extends State<InternshipExperienceFormWidget> {
  final formKey = GlobalKey<FormState>();

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

  bool checked = false;


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
              color:  _hasError ? Colors.red[700]! : Color(0xFF2F80ED),
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
                          color: _hasError ? Colors.red[700]! : Color(0xFF2F80ED)),
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
                            child: Text(
                              "Clear",
                              style: TextStyle(color: _hasError ? Colors.red[700]! : Color(0xFF2F80ED)),
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
                  onChanged: (value) {
                    widget.internshipExperience.company = value;
                    validate();
                  },
                  onSaved: (value) => widget.internshipExperience.company = value,
                  hintText: "Company name",
                ),
                MyTextField(
                  validator: (value) => value!.length > 3 ? null : "Enter Job Role",
                  controller: widget._jobRoleController,
                  onChanged: (value) {
                    widget.internshipExperience.role = value;
                    validate();
                  },
                  onSaved: (value) => widget.internshipExperience.role = value,
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
                        onChanged: (value) => widget.internshipExperience.startDate = value,
                        onSaved: (value) => widget.internshipExperience.startDate = value,
                        initialText: "Start Date"
                      ),
                    ),
                    const SizedBox(width: 10.0), // Add some space between the fields
                    !checked ? Expanded(
                      child: DateCal(
                        validator: (_) => _validateEndDate(),
                        controller: widget.endDateController,
                        onChanged: (value) => widget.internshipExperience.endDate = value,
                        onSaved: (value) => widget.internshipExperience.endDate = value,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Stack(children: [
                          Positioned.fill(
                            child: Checkbox(
                              value: checked,
                              onChanged: (_) {},
                              activeColor: _hasError ? Colors.red[700] : Color(0xFF2F80ED),
                              checkColor: Colors.white, // Color of the checkmark
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                widget.endDateController.clear();
                                widget.internshipExperience.endDate = null;
                                checked = !checked;
                              });
                            },
                            child: Container(
                              width: 20.0,
                              height: 20.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _hasError ? Colors.red[700]! : Color(0xFF2F80ED),
                                  width: 3.5,
                                ),
                                borderRadius:
                                    BorderRadius.circular(4.0), // Border radius
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(width: 10,),
                        Text('I Currently Study Here',
                            style: TextStyle(
                                color: _hasError
                                    ? Colors.red[700]
                                    : Color(0xFF2F80ED)))
                      ],
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 15.0,
                // ),
                // DropdownOption(
                //   controller: widget.domainController,
                //   onChanged: (value) => widget.internshipExperience.domain = value,
                //   onSaved: (value) => widget.internshipExperience.domain = value,
                //   caption: "Domain",
                // ),
                const SizedBox(
                  height: 15.0,
                ),
                DropdownMulti(
                  controller: widget.skillsController,
                  onChanged: (value) => widget.internshipExperience.skills = value,
                  onSaved: (value) => widget.internshipExperience.skills = value,
                  caption: "Skills",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
