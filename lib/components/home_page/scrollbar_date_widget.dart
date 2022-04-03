import 'package:flutter/material.dart';

class ScrollbarDateWidget extends StatelessWidget {
  ScrollbarDateWidget({
    Key? key,
    required this.date,
    this.selected = false,
  }) : super(key: key);

  final DateTime date;
  final bool selected;

  final Map<int, String> weekDays = {
    1: "Mon",
    2: "Tue",
    3: "Wed",
    4: "Thu",
    5: "Fri",
    6: "Sat",
    7: "Sun",
  };

  Color getTextColor() {
    return selected ? Colors.blue : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(selected ? 12.0 : 8.0),
      width: 52.0,
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.grey.withOpacity(0),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.circle,
            size: 6,
            color: Colors.blue,
          ),
          Text(
            date.day.toString(),
            style: TextStyle(
              color: getTextColor(),
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            weekDays[date.weekday]!,
            style: TextStyle(
              color: getTextColor(),
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
