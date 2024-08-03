import 'package:flutter/material.dart';
import 'package:frontend/components/date.dart';
import 'package:frontend/components/formfield.dart';

class EduHist extends StatefulWidget {
  final String label;

  const EduHist({
    required this.label,
  });

  @override
  State<EduHist> createState() => _EduHistState();
}

class _EduHistState extends State<EduHist> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            color: Color(0xFF2F80ED),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 2.5,
              color: Color(0xFF2F80ED),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              children: [
                MyTextField(
                  hintText: "Company name",
                ),
                MyTextField(
                  hintText: "Job done",
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: DateCal(initialText: "Start Date"),
                    ),
                    SizedBox(width: 10.0), // Add some space between the fields
                    Expanded(
                      child: DateCal(initialText: "End Date"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
