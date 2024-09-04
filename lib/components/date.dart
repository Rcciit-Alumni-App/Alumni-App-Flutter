import 'package:flutter/material.dart';

class DateCalController extends ChangeNotifier {
  DateTime? _dateTime;

  DateTime? get dateTime => _dateTime;

  set dateTime(DateTime? newDateTime) {
    if (_dateTime != newDateTime) {
      _dateTime = newDateTime;
      notifyListeners();
    }
  }

  void clear() {
    dateTime = null;
  }
}

class DateCal extends StatefulWidget {
  final DateCalController controller;
  final String initialText;
  final ValueChanged<DateTime?>? onChanged;
  final ValueChanged<DateTime?>? onSaved;
  final FormFieldValidator<DateTime?>? validator;

  DateCal({
    required this.controller,
    required this.initialText,
    this.onChanged,
    this.onSaved,
    this.validator,
  });

  @override
  _DateCalState createState() => _DateCalState();
}

class _DateCalState extends State<DateCal> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateDateTime);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateDateTime);
    super.dispose();
  }

  void _updateDateTime() {
    setState(() {
      // Call the onChanged callback whenever the date is updated
      if (widget.onChanged != null) {
        widget.onChanged!(widget.controller.dateTime != null ? widget.controller.dateTime!.toUtc() : null);
      }
    });
  }

  Future<void> _selectDate(BuildContext context, FormFieldState<DateTime?> state) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.controller.dateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      widget.controller.dateTime = picked.toUtc();
    
      // Call the onSaved callback when the date is picked
      if (widget.onSaved != null) {
        widget.onSaved!(widget.controller.dateTime != null ? widget.controller.dateTime!.toUtc() : null);
      }
      state.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime?>(
      validator: widget.validator,
      builder: (FormFieldState<DateTime?> state) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[200],
                border: Border.all(
                  width: 1.11053,
                  color: state.hasError ? Colors.red[700]! : Color(0xFF2F80ED),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.controller.dateTime != null
                        ? widget.controller.dateTime!.toLocal().toString().split(' ')[0]
                        : widget.initialText,
                      style: TextStyle(
                        color: !state.hasError ? Color(0xFF2F80ED) : Colors.red[700],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context, state),
                      child: Icon(
                        Icons.calendar_month,
                        color: !state.hasError ? Color(0xFF2F80ED) : Colors.red[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state.hasError)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                  child: Text(
                    state.errorText!,
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 12.0,
                    ),
                  ),
                ),
              )
          ],
        );
      }
    );
  }
}
