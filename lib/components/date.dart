// import 'package:flutter/material.dart';

// class DateCal extends StatefulWidget {
//   final String initialText;

//   DateCal({required this.initialText});

//   @override
//   _DateCalState createState() => _DateCalState();
// }

// class _DateCalState extends State<DateCal> {
//   late String text;

//   @override
//   void initState() {
//     super.initState();
//     text = widget.initialText;
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != DateTime.now()) {
//       setState(() {
//         text = "${picked.toLocal()}".split(' ')[0];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         color: Colors.grey[200],
//         border: Border.all(
//           width: 2.5,
//           color: Color(0xFF2F80ED),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               text,
//               style: TextStyle(
//                 color: Color(0xFF2F80ED),
//               ),
//             ),
//             GestureDetector(
//               onTap: () => _selectDate(context),
//               child: Icon(
//                 Icons.calendar_month,
//                 color: Color(0xFF2F80ED),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// 



















// import 'package:flutter/material.dart';

// class DateCal extends StatefulWidget {
//   final DateCalController controller;
//   final String initialText;

//   DateCal({required this.controller, required this.initialText});

//   @override
//   _DateCalState createState() => _DateCalState();
// }

// class _DateCalState extends State<DateCal> {
//   @override
//   void initState() {
//     super.initState();
//     widget.controller.text = widget.initialText;
//     widget.controller.addListener(_updateText);
//   }

//   @override
//   void dispose() {
//     widget.controller.removeListener(_updateText);
//     super.dispose();
//   }

//   void _updateText() {
//     setState(() {});
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       widget.controller.text = "${picked.toLocal()}".split(' ')[0];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         color: Colors.grey[200],
//         border: Border.all(
//           width: 2.5,
//           color: Color(0xFF2F80ED),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               widget.controller.text,
//               style: TextStyle(
//                 color: Color(0xFF2F80ED),
//               ),
//             ),
//             GestureDetector(
//               onTap: () => _selectDate(context),
//               child: Icon(
//                 Icons.calendar_month,
//                 color: Color(0xFF2F80ED),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';


class DateCalController extends ChangeNotifier {
  String? _text = '';

  String? get text => _text;

  set text(String? newText) {
    if (_text != newText) {
      _text = newText;
      notifyListeners();
    }
  }

  void clear() {
    text = null;
  }
}












class DateCal extends StatefulWidget {
  final DateCalController controller;
  final String initialText;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSaved;

  DateCal({
    required this.controller,
    required this.initialText,
    this.onChanged,
    this.onSaved,
  });

  @override
  _DateCalState createState() => _DateCalState();
}

class _DateCalState extends State<DateCal> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.initialText;
    widget.controller.addListener(_updateText);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateText);
    super.dispose();
  }

  void _updateText() {
    setState(() {
      // Call the onChanged callback whenever the text is updated
      if (widget.onChanged != null) {
        widget.onChanged!(widget.controller.text);
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      widget.controller.text = "${picked.toLocal()}".split(' ')[0];
      // Call the onSaved callback when the date is picked
      if (widget.onSaved != null) {
        widget.onSaved!(widget.controller.text);
      }
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
          width: 1.11053,
          color: Color(0xFF2F80ED),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.controller.text ?? widget.initialText,
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
