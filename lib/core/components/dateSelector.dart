import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/views/reservation/timeRange.dart';
import 'package:get/get.dart';

class DateSelector extends StatefulWidget {
  final Park park;
  DateSelector({Key key, this.days, this.park}) : super(key: key);
  List<DateTime> days;
  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  List<String> years = List<String>();
  List<String> months = List<String>();
  List<String> days = List<String>();

  List<DateTime> referanceList = List<DateTime>();

  String selectedYear;
  String selectedMonth;
  String selectedDay;
  @override
  void initState() { 
    super.initState();
    referanceList = widget.days;
    selectedYear = widget.days.first.year.toString();
    selectedMonth = parseMonth(widget.days.first.month);
    selectedDay = widget.days.first.day.toString();
    widget.days.forEach((element) { 
      years.add(element.year.toString());
      years = years.toSet().toList();
    });
    widget.days.forEach((element) {
      if (element.year.toString() == selectedYear) {
        months.add(parseMonth(element.month));
      }
    });
    months = months.toSet().toList();
    widget.days.forEach((element) {
      if (element.year.toString() == selectedYear && selectedMonth == parseMonth(element.month)) {
        days.add(element.day.toString());
      }
    });
    days = days.toSet().toList();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "İptal",
                      style: TextStyle(
                          color: gray900,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(()=>TimeRangePage(date: parseDateTime() ,park: widget.park));
                    
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Onayla",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: blue500,
                          fontSize: 17),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Spacer(
          flex: 1,
        ),
        _buildLabels(),
        Expanded(
          flex: 9,
          child: Container(
            width: Get.width,
            child: Row(
              children: [
                _buildColumn1(years),
                _buildColumn2(months),
                _buildColumn3(days)
              ],
            ),
          ),
        ),

      ],
    );
  }

  Expanded _buildLabels() {
    return Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Text(
                "Yıl",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              child: Text(
                "Ay",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              child: Text(
                "Gün",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );
  }

  Expanded _buildColumn1(years) {
    return Expanded(
      flex: 4,
      child: CupertinoPicker(
        itemExtent: 64,
        diameterRatio: 0.7,
        children: modelBuilder(years),
        onSelectedItemChanged: (index) {
          setState(() {
            selectedYear = years[index];
            monthArrenger(selectedYear);
            selectedMonth = months.first;
            dayArrenger(selectedMonth);
            selectedDay = days.first;
          });
          
        },
      ),
    );
  }

    Expanded _buildColumn2(months) {
    return Expanded(
      flex: 4,
      child: CupertinoPicker(
        itemExtent: 64,
        diameterRatio: 0.7,
        children: modelBuilder(months),
        onSelectedItemChanged: (index) {
          setState(() {
            selectedMonth = months[index];
            dayArrenger(selectedMonth);
            selectedDay = days.first;
          });
        },
      ),
    );
  }

    Expanded _buildColumn3(days) {
    return Expanded(
      flex: 4,
      child: CupertinoPicker(
        itemExtent: 64,
        diameterRatio: 0.7,
        children: modelBuilder(days),
        onSelectedItemChanged: (index) {
          setState(() {
            selectedDay = days[index];
          });
        },
      ),
    );
  }

  modelBuilder(values) {
    List<Widget> _widgetList = List<Widget>.generate(values.length, (index) {
      return Center(
        child: Text(values[index].toString()),
      );
    });
    return _widgetList;
  }

  monthArrenger(year){
    months.clear();
        widget.days.forEach((element) {
      if (element.year == int.parse(year)) {
        months.add(parseMonth(element.month));
      }else{
        months.remove(element);
      }
      months = months.toSet().toList();
      
      setState(() {
        
      });
    });
  }

    dayArrenger(month){
    days.clear();
        widget.days.forEach((element) {
      if (parseMonth(element.month) == month && selectedYear == element.year.toString()) {
        days.add(element.day.toString());
      }else{
        days.remove(element);
      }
      days = days.toSet().toList();
      setState(() {
        
      });
    });
  }


  parseMonth(integer){
    switch (integer) {
      case 1:
        return "Ocak";
        break;
      case 2:
        return "Şubat";
        break;
      case 3:
        return "Mart";
        break;
      case 4:
        return "Nisan";
        break;
      case 5:
        return "Mayıs";
        break;
      case 6:
        return "Haziran";
        break;
      case 7:
        return "Temmuz";
        break;
      case 8:
        return "Ağustos";
        break;
      case 9:
        return "Eylül";
        break;
      case 10:
        return "Ekim";
        break;
      case 11:
        return "Kasım";
        break;
      case 12:
        return "Aralık";
        break;
      default:
    }
  }

  parseDateTime(){
    var _day;
    var _month;
    var _year;

    if (int.parse(selectedDay)<10) {
      _day = "0"+selectedDay;
    }else{
      _day = selectedDay;
    }

    switch (selectedMonth) {
      case "Ocak":
        _month = "01";
        break;
      case "Şubat":
        _month = "02";
        break;
      case "Mart":
        _month = "03";
        break;
      case "Nisan":
        _month = "04";
        break;
      case "Mayıs":
        _month = "05";
        break;
      case "Haziran":
        _month = "06";
        break;
      case "Temmuz":
        _month = "07";
        break;
      case "Ağustos":
        _month = "08";
        break;
      case "Eylül":
        _month = "09";
        break;
      case "Ekim":
        _month = "10";
        break;
      case "Kasım":
        _month = "11";
        break;
      case "Aralık":
        _month = "12";
        break;
      default:
    }

    _year = selectedYear;

    var _date = DateTime.parse("$_year-$_month-$_day");

    return _date;
  }
}