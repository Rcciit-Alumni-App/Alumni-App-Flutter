// import 'package:flutter/material.dart';

// class DropdownOption extends StatefulWidget {
//   final String? caption;

//   const DropdownOption({
//     this.caption,
//   });

//   @override
//   State<DropdownOption> createState() => _DropdownOptionState();
// }

// class _DropdownOptionState extends State<DropdownOption> {
//   List<String> menuItems = [
//     'Technology',
//     'Healthcare',
//     'Finance',
//     'Education',
//     'E-commerce',
//   ];

//   String? selectedMenu;

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width - 16.0;

//     return Container(
//       width: width,
//       padding: EdgeInsets.symmetric(horizontal: 10.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         border: Border.all(
//           color: Color(0xFF2F80ED),
//           width: 2.5,
//         ),
//         color: Colors.grey[200],
//       ),
//       child: DropdownButton<String>(
//         isExpanded: true,
//         hint: Text(
//           widget.caption ?? "",
//           style: TextStyle(
//             color: Color(0xFF2F80ED),
//             fontSize: 17.0,
//           ),
//         ),
//         value: selectedMenu,
//         icon: Icon(Icons.arrow_drop_down),
//         iconSize: 24,
//         elevation: 16,
//         style: TextStyle(color: Color(0xFF2F80ED)),
//         underline: Container(
//           height: 2,
//           color: Colors.transparent,
//         ),
//         onChanged: (String? newValue) {
//           setState(() {
//             selectedMenu = newValue;
//           });
//         },
//         items: menuItems.map<DropdownMenuItem<String>>((String menuItem) {
//           return DropdownMenuItem<String>(
//             value: menuItem,
//             child: Text(menuItem),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';

// class DropdownOption extends StatefulWidget {
//   final String? caption;
//   final ValueChanged<String?>? onChanged;
//   final FormFieldSetter<String>? onSaved;

//   const DropdownOption({
//     this.caption,
//     this.onChanged,
//     this.onSaved,
//   });

//   @override
//   State<DropdownOption> createState() => _DropdownOptionState();
// }

// class _DropdownOptionState extends State<DropdownOption> {
//   List<String> menuItems = [
//     'Technology',
//     'Healthcare',
//     'Finance',
//     'Education',
//     'E-commerce',
//   ];

//   String? selectedMenu;

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width - 16.0;

//     return FormField<String>(
//       builder: (FormFieldState<String> state) {
//         return Container(
//           width: width,
//           padding: EdgeInsets.symmetric(horizontal: 10.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             border: Border.all(
//               color: Color(0xFF2F80ED),
//               width: 2.5,
//             ),
//             color: Colors.grey[200],
//           ),
//           child: DropdownButton<String>(
//             isExpanded: true,
//             hint: Text(
//               widget.caption ?? "",
//               style: TextStyle(
//                 color: Color(0xFF2F80ED),
//                 fontSize: 17.0,
//               ),
//             ),
//             value: selectedMenu,
//             icon: Icon(Icons.arrow_drop_down),
//             iconSize: 24,
//             elevation: 16,
//             style: TextStyle(color: Color(0xFF2F80ED)),
//             underline: Container(
//               height: 2,
//               color: Colors.transparent,
//             ),
//             onChanged: (String? newValue) {
//               setState(() {
//                 selectedMenu = newValue;
//                 state.didChange(newValue);
//               });
//               if (widget.onChanged != null) {
//                 widget.onChanged!(newValue);
//               }
//             },
//             items: menuItems.map<DropdownMenuItem<String>>((String menuItem) {
//               return DropdownMenuItem<String>(
//                 value: menuItem,
//                 child: Text(menuItem),
//               );
//             }).toList(),
//           ),
//         );
//       },
//       onSaved: widget.onSaved,
//       initialValue: selectedMenu,
//     );
//   }
// }


































// import 'package:flutter/material.dart';

// class DropdownOption extends StatefulWidget {
//   final DropdownOptionController controller;
//   final String? caption;

//   const DropdownOption({
//     required this.controller,
//     this.caption,
//   });

//   @override
//   State<DropdownOption> createState() => _DropdownOptionState();
// }

// class _DropdownOptionState extends State<DropdownOption> {
//   List<String> menuItems = [
//     'Technology',
//     'Healthcare',
//     'Finance',
//     'Education',
//     'E-commerce',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     widget.controller.addListener(_updateSelectedItem);
//   }

//   @override
//   void dispose() {
//     widget.controller.removeListener(_updateSelectedItem);
//     super.dispose();
//   }

//   void _updateSelectedItem() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width - 16.0;

//     return Container(
//       width: width,
//       padding: EdgeInsets.symmetric(horizontal: 10.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         border: Border.all(
//           color: Color(0xFF2F80ED),
//           width: 2.5,
//         ),
//         color: Colors.grey[200],
//       ),
//       child: DropdownButton<String>(
//         isExpanded: true,
//         hint: Text(
//           widget.caption ?? "",
//           style: TextStyle(
//             color: Color(0xFF2F80ED),
//             fontSize: 17.0,
//           ),
//         ),
//         value: widget.controller.selectedItem,
//         icon: Icon(Icons.arrow_drop_down),
//         iconSize: 24,
//         elevation: 16,
//         style: TextStyle(color: Color(0xFF2F80ED)),
//         underline: Container(
//           height: 2,
//           color: Colors.transparent,
//         ),
//         onChanged: (String? newValue) {
//           widget.controller.selectedItem = newValue;
//         },
//         items: menuItems.map<DropdownMenuItem<String>>((String menuItem) {
//           return DropdownMenuItem<String>(
//             value: menuItem,
//             child: Text(menuItem),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }














// import 'package:flutter/material.dart';

// class DropdownOptionController extends ChangeNotifier {
//   String? _selectedItem;

//   String? get selectedItem => _selectedItem;

//   set selectedItem(String? value) {
//     _selectedItem = value;
//     notifyListeners();
//   }
// }

// class DropdownOption extends StatefulWidget {
//   final DropdownOptionController controller;
//   final String? caption;
//   final ValueChanged<String?>? onChanged;
//   final ValueChanged<String?>? onSaved;

//   const DropdownOption({
//     required this.controller,
//     this.caption,
//     this.onChanged,
//     this.onSaved,
//   });

//   @override
//   State<DropdownOption> createState() => _DropdownOptionState();
// }

// class _DropdownOptionState extends State<DropdownOption> {
//   List<String> menuItems = [
//     'Technology',
//     'Healthcare',
//     'Finance',
//     'Education',
//     'E-commerce',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     widget.controller.addListener(_updateSelectedItem);
//   }

//   @override
//   void dispose() {
//     widget.controller.removeListener(_updateSelectedItem);
//     super.dispose();
//   }

//   void _updateSelectedItem() {
//     setState(() {
//       // Call the onChanged callback whenever the selected item is updated
//       if (widget.onChanged != null) {
//         widget.onChanged!(widget.controller.selectedItem);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width - 16.0;

//     return Container(
//       width: width,
//       padding: EdgeInsets.symmetric(horizontal: 10.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         border: Border.all(
//           color: Color(0xFF2F80ED),
//           width: 2.5,
//         ),
//         color: Colors.grey[200],
//       ),
//       child: DropdownButton<String>(
//         isExpanded: true,
//         hint: Text(
//           widget.caption ?? "",
//           style: TextStyle(
//             color: Color(0xFF2F80ED),
//             fontSize: 17.0,
//           ),
//         ),
//         value: widget.controller.selectedItem,
//         icon: Icon(Icons.arrow_drop_down),
//         iconSize: 24,
//         elevation: 16,
//         style: TextStyle(color: Color(0xFF2F80ED)),
//         underline: Container(
//           height: 2,
//           color: Colors.transparent,
//         ),
//         onChanged: (String? newValue) {
//           widget.controller.selectedItem = newValue;
//           // Call the onSaved callback when the dropdown value is changed
//           if (widget.onSaved != null) {
//             widget.onSaved!(widget.controller.selectedItem);
//           }
//         },
//         items: menuItems.map<DropdownMenuItem<String>>((String menuItem) {
//           return DropdownMenuItem<String>(
//             value: menuItem,
//             child: Text(menuItem),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }







import 'package:flutter/material.dart';




class DropdownOptionController extends ChangeNotifier {
  String? _selectedItem;

  String? get selectedItem => _selectedItem;

  set selectedItem(String? newItem) {
    if (_selectedItem != newItem) {
      _selectedItem = newItem;
      notifyListeners();
    }
  }

  void clear() {
    selectedItem = null;
  }
}







class DropdownOption extends StatefulWidget {
  final DropdownOptionController controller;
  final String? caption;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSaved;

  const DropdownOption({
    required this.controller,
    this.caption,
    this.onChanged,
    this.onSaved,
  });

  @override
  State<DropdownOption> createState() => _DropdownOptionState();
}

class _DropdownOptionState extends State<DropdownOption> {
  List<String> menuItems = [
    'Technology',
    'Healthcare',
    'Finance',
    'Education',
    'E-commerce',
  ];

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateSelectedItem);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateSelectedItem);
    super.dispose();
  }

  void _updateSelectedItem() {
    setState(() {
      // Call the onChanged callback whenever the selected item is updated
      if (widget.onChanged != null) {
        widget.onChanged!(widget.controller.selectedItem);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 16.0;

    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Color(0xFF2F80ED),
          width: 1.11053,
        ),
        color: Colors.grey[200],
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(
          widget.caption ?? "",
          style: TextStyle(
            color: Color(0xFF2F80ED),
            fontSize: 17.0,
          ),
        ),
        value: widget.controller.selectedItem,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Color(0xFF2F80ED)),
        underline: Container(
          height: 2,
          color: Colors.transparent,
        ),
        onChanged: (String? newValue) {
          widget.controller.selectedItem = newValue;
          // Call the onSaved callback when the dropdown value is changed
          if (widget.onSaved != null) {
            widget.onSaved!(widget.controller.selectedItem);
          }
        },
        items: menuItems.map<DropdownMenuItem<String>>((String menuItem) {
          return DropdownMenuItem<String>(
            value: menuItem,
            child: Text(menuItem),
          );
        }).toList(),
      ),
    );
  }
}



