import 'package:academic_calendar/components/home_page/scrollbar_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class CustomCalendarDateScrollableScrollbar extends StatefulWidget {
  const CustomCalendarDateScrollableScrollbar({
    Key? key,
    required this.onDateChanged,
    required this.selectedDate,
  }) : super(key: key);

  final void Function(DateTime date) onDateChanged;
  final DateTime selectedDate;

  @override
  State<CustomCalendarDateScrollableScrollbar> createState() =>
      _CustomCalendarDateScrollableScrollbarState();
}

class _CustomCalendarDateScrollableScrollbarState
    extends State<CustomCalendarDateScrollableScrollbar> {
  late List<DateTime> datesListToShow;

  @override
  void initState() {
    super.initState();

    updateDateList();
  }

  void updateDateList({DateTime? date}) {
    setState(() {
      datesListToShow = getDatesInMonth(date ?? widget.selectedDate);
    });
  }

  List<DateTime> getDatesInMonth(DateTime date) {
    List<DateTime> datesList = [];

    int month = date.month;
    int year = date.year;
    int noOfDays = 30;

    bool isLeapYear(int year) {
      if (year % 4 == 0) {
        if (year % 100 == 0) {
          if (year % 400 == 0) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    if (month == 1 ||
        month == 3 ||
        month == 5 ||
        month == 7 ||
        month == 8 ||
        month == 10 ||
        month == 12) {
      noOfDays = 31;
    } else if (month == 4 || month == 6 || month == 8 || month == 11) {
      noOfDays = 30;
    } else {
      if (isLeapYear(year)) {
        noOfDays = 29;
      } else {
        noOfDays = 28;
      }
    }

    for (var day = 1; day <= noOfDays; day++) {
      datesList.add(DateTime(year, month, day, 0, 0, 0, 0, 0));
    }

    return datesList;
  }

  bool compareDates(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String getMonthYearAbbr(DateTime date) {
    final Map<int, String> months = {
      1: "January",
      2: "February",
      3: "March",
      4: "April",
      5: "May",
      6: "June",
      7: "July",
      8: "August",
      9: "September",
      10: "October",
      11: "November",
      12: "December",
    };

    return "${date.year}, ${months[date.month]}";
  }

  void handleDateClicked(DateTime date) {
    widget.onDateChanged(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        monthYearPicker(),
        dateScrollbar(),
      ],
    );
  }

  Widget monthYearPicker() {
    void handleTap() async {
      showMonthPicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 1, 5),
        lastDate: DateTime(DateTime.now().year + 1, 9),
        initialDate: widget.selectedDate,
        locale: const Locale("en"),
      ).then((date) {
        if (date != null) {
          handleDateClicked(date);
          updateDateList(date: date);
        }
      });
    }

    return GestureDetector(
      onTap: handleTap,
      child: Container(
        color: Colors.blue,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          getMonthYearAbbr(widget.selectedDate),
          textAlign: TextAlign.end,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  SizedBox dateScrollbar() {
    return SizedBox(
      height: 88.0,
      child: Container(
        color: Colors.blue,
        padding: const EdgeInsets.only(bottom: 12.0, top: 4.0),
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: datesListToShow.length,
          itemBuilder: (BuildContext context, int index) {
            DateTime date = datesListToShow[index];

            return GestureDetector(
              onTap: () => handleDateClicked(date),
              child: ScrollbarDateWidget(
                date: date,
                selected: compareDates(date, widget.selectedDate),
              ),
            );
          },
        ),
      ),
    );
  }
}
