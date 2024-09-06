import 'package:flutter/material.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/Buttons/button3.dart';
import 'package:frontend/components/Dropdown/dropdown_button.dart';
import 'package:frontend/components/Dropdown/dropdown_multiselect.dart';
import 'package:frontend/components/FormFields/formfield.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/components/date.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/screens/HomeScreen/home_screen.dart';
import 'package:frontend/services/alert_services.dart';
import 'package:frontend/services/loader_service.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

class PostJob extends StatefulWidget {
  @override
  State<PostJob> createState() => _PostJobState();

  DropdownMultiController skillsController = DropdownMultiController();
  DropdownOptionController domainController = DropdownOptionController();
  DateCalController startDateController = DateCalController();
  DateCalController endDateController = DateCalController();
}

class _PostJobState extends State<PostJob> {
  final _formKey = GlobalKey<FormState>();
  final NavigationService navigation = NavigationService();
  final AlertService alertService = AlertService();
  final LoaderService _loaderService = GetIt.instance.get<LoaderService>();

  bool _hasError = false;
  bool isJobChecked = false;
  bool isInternshipChecked = false;

  bool validate() {
    // Validate Form Fields
    bool isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      _formKey.currentState?.save();
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

    if (widget.startDateController.dateTime == null &&
        widget.endDateController.dateTime != null) {
      res = 'Please enter start date';
    }

    // If only start date exists, check if it's valid
    if (widget.startDateController.dateTime != null &&
        widget.endDateController.dateTime == null) {
      DateTime? startDate = widget.startDateController.dateTime;

      if (startDate != null && startDate.isAfter(DateTime.now())) {
        res = 'Please enter a valid date';
      }
    }

    // If both dates exist, check their validity
    if (widget.startDateController.dateTime != null &&
        widget.endDateController.dateTime != null) {
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
    if (widget.startDateController.dateTime != null &&
        widget.endDateController.dateTime != null) {
      DateTime? startDate = widget.startDateController.dateTime;
      DateTime? endDate = widget.endDateController.dateTime;

      if (startDate != null && endDate != null && startDate.isAfter(endDate)) {
        res = 'Please enter a valid date';
      }
    }

    return res;
  }

  Future<void> createPost() async {
    alertService.showSnackBar(
      message: "Post created successfully",
      color: Theme.of(context).colorScheme.secondary,
    );
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundAddDetailsPage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Post Jobs/Internship",
                  style: kRegisterHeading,
                ),
                Text(
                  "Please give the details",
                  style: kRegisterSubHeading,
                ),
                SizedBox(
                  height: 130.0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              width: 1.11,
                              color: _hasError
                                  ? Colors.red[700]!
                                  : Color(0xFF2F80ED),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              left: 15.0,
                              right: 15.0,
                              bottom: 16.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: isJobChecked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isJobChecked = value ?? false;
                                              isInternshipChecked =
                                                  !isJobChecked; // Uncheck the other checkbox
                                            });
                                          },
                                          activeColor: _hasError
                                              ? Colors.red[700]
                                              : Color(0xFF2F80ED),
                                          checkColor: Colors
                                              .white, // Color of the checkmark
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          'Job',
                                          style: TextStyle(
                                            color: _hasError
                                                ? Colors.red[700]
                                                : Color(0xFF2F80ED),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12.0,
                                        ),
                                        Checkbox(
                                          value: isInternshipChecked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isInternshipChecked =
                                                  value ?? false;
                                              isJobChecked =
                                                  !isInternshipChecked; // Uncheck the other checkbox
                                            });
                                          },
                                          activeColor: _hasError
                                              ? Colors.red[700]
                                              : Color(0xFF2F80ED),
                                          checkColor: Colors
                                              .white, // Color of the checkmark
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          'Internship',
                                          style: TextStyle(
                                            color: _hasError
                                                ? Colors.red[700]
                                                : Color(0xFF2F80ED),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Enter Job/Internship Details",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xFF2F80ED),
                                      ),
                                    ),
                                  ],
                                ),
                                MyTextField(
                                  validator: (value) => value!.length > 3
                                      ? null
                                      : "Enter Company Name",
                                  onChanged: (value) {
                                    validate();
                                  },
                                  hintText: "Company name",
                                ),
                                MyTextField(
                                  validator: (value) => value!.length > 3
                                      ? null
                                      : "Enter Job Role",
                                  onChanged: (value) {
                                    validate();
                                  },
                                  hintText: "Job role",
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: DateCal(
                                          validator: (_) =>
                                              _validateStartDate(),
                                          controller:
                                              widget.startDateController,
                                          initialText: "Start Date"),
                                    ),
                                    const SizedBox(
                                        width:
                                            10.0), // Add some space between the fields
                                    isInternshipChecked
                                        ? Expanded(
                                            child: DateCal(
                                                validator: (_) =>
                                                    _validateEndDate(),
                                                controller:
                                                    widget.endDateController,
                                                initialText: "End Date"),
                                          )
                                        : Expanded(child: Container())
                                  ],
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                DropdownOption(
                                  controller: widget.domainController,
                                  caption: "Domain",
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                DropdownMulti(
                                  controller: widget.skillsController,
                                  caption: "Skills Required",
                                ),
                                MyTextField(
                                  hintText: "Description",
                                  validator: (value) => value!.length > 20
                                      ? null
                                      : "Enter Job Description",
                                  onChanged: (value) {
                                    validate();
                                  },
                                  maxLines: 4,
                                  height: 100,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomButton3(
                      label: "Post",
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          createPost();
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Bottomnavbar(),
        ),
      ],
    );
  }
}
