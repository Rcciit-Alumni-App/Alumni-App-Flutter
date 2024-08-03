import 'package:flutter/material.dart';

class DropdownOption extends StatefulWidget {
  final String? caption;

  const DropdownOption({
    this.caption,
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

  String? selectedMenu;

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
          width: 2.5,
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
        value: selectedMenu,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Color(0xFF2F80ED)),
        underline: Container(
          height: 2,
          color: Colors.transparent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            selectedMenu = newValue;
          });
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
