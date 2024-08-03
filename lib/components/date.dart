import 'package:flutter/material.dart';

class DateCal extends StatefulWidget {
  final String initialText;

  DateCal({required this.initialText});

  @override
  _DateCalState createState() => _DateCalState();
}

class _DateCalState extends State<DateCal> {
  late String text;

  @override
  void initState() {
    super.initState();
    text = widget.initialText;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
        border: Border.all(
          width: 2.5,
          color: Color(0xFF2F80ED),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Color(0xFF2F80ED),
              ),
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Icon(
                Icons.calendar_month,
                color: Color(0xFF2F80ED),
              ),
            ),
          ],
        ),
      ),
    );
  }
}