import 'package:flutter/material.dart';
import 'package:frontend/components/date.dart';
import 'package:frontend/components/FormFields/formfield.dart';
import 'package:frontend/models/UserModel.dart';

class HigherStudiesFormWidget extends StatefulWidget {
  HigherStudiesFormWidget(
      {Key? key,
      required this.higherStudiesModel,
      required this.onRemove,
      required this.index})
      : super(key: key);

  final index;
  HigherStudy higherStudiesModel;
  final Function onRemove;
  final state = _HigherStudiesFormWidgetState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  bool isValidated() => state.validate();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _courseNameController = TextEditingController();
  DateCalController startDateController = DateCalController();
  DateCalController endDateController = DateCalController();
}

class _HigherStudiesFormWidgetState extends State<HigherStudiesFormWidget> {
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
              color: _hasError ? Colors.red[700]! : Color(0xFF2F80ED),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 0.0, left: 15.0, right: 15.0, bottom: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Enter Study Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: _hasError ? Colors.red[700] : Color(0xFF2F80ED),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                //Clear All forms Data
                                widget.higherStudiesModel.institute = null;
                                widget.higherStudiesModel.course = null;
                                widget.higherStudiesModel.startDate = null;
                                widget.higherStudiesModel.endDate = null;
                                widget._nameController.clear();
                                widget._courseNameController.clear();
                                widget.startDateController.clear();
                                widget.endDateController.clear();
                              });
                            },
                            child: Text(
                              "Clear",
                              style: TextStyle(
                                color: _hasError
                                    ? Colors.red[700]!
                                    : Color(0xFF2F80ED),
                              ),
                            )),
                        TextButton(
                            onPressed: () => widget.onRemove(),
                            child: Text(
                              "Remove",
                              style: TextStyle(
                                color: _hasError
                                    ? Colors.red[700]!
                                    : Color(0xFF2F80ED),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
                MyTextField(
                  validator: (value) =>
                      value!.length > 3 ? null : "Enter Institute Name",
                  controller: widget._nameController,
                  onChanged: (value) =>
                      widget.higherStudiesModel.institute = value,
                  onSaved: (value) =>
                      widget.higherStudiesModel.institute = value,
                  hintText: "Institute name",
                ),
                MyTextField(
                  validator: (value) =>
                      value!.length > 3 ? null : "Enter Course Name",
                  controller: widget._courseNameController,
                  onChanged: (value) =>
                      widget.higherStudiesModel.course = value,
                  onSaved: (value) => widget.higherStudiesModel.course = value,
                  hintText: "Course Name",
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
                          onChanged: (value) =>
                              widget.higherStudiesModel.startDate =
                                  value,
                          onSaved: (value) => widget.higherStudiesModel
                              .startDate = value,
                          initialText: "Start Date"),
                    ),
                    const SizedBox(
                        width: 10.0), // Add some space between the fields
                    !checked
                        ? Expanded(
                            child: DateCal(
                                validator: (_) => _validateEndDate(),
                                controller: widget.endDateController,
                                onChanged: (value) => widget
                                        .higherStudiesModel.endDate =
                                    value,
                                onSaved: (value) => widget.higherStudiesModel
                                    .endDate = value,
                                initialText: "End Date"),
                          )
                        : Expanded(child: Container())
                  ],
                ),
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.centerLeft,
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
                              widget.higherStudiesModel.endDate = null;
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
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
