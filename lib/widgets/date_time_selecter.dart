import 'package:flutter/material.dart';


class DateTimeSelecter extends StatelessWidget {

  final DateTime selectedDate;
  final TimeOfDay selectedTime;
   final Function(DateTime,TimeOfDay) onDateTimeChanged;
    DateTimeSelecter({super.key, required this.selectedDate, required this.selectedTime, required this.onDateTimeChanged});


    Future<void>_selectedDate(BuildContext context)async{
      final DateTime? pickDate= await showDatePicker(context: context,initialDate: selectedDate, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 500)));

      if(pickDate != null && pickDate !=selectedDate){
         onDateTimeChanged(pickDate,selectedTime);
      }
    }

    Future<void> _selectTime(BuildContext context)async{
      final TimeOfDay? pickTime = await showTimePicker(context: context, initialTime: selectedTime);
          if(pickTime != null && pickTime != selectedTime){
            onDateTimeChanged(selectedDate,pickTime);
          }
    }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(child: OutlinedButton.icon(onPressed:()=> _selectedDate(context),
            icon: Icon(Icons.calendar_today),
            label: Text("Date : ${selectedDate.toLocal().toString().split(' ')[0]}"))),
        
        SizedBox(width: 12,),

        Expanded(child: OutlinedButton.icon(onPressed:()=> _selectTime(context),
            icon: Icon(Icons.access_time ),
            label: Text("Date : ${selectedTime.format(context)}",)))
      ],
    );
  }
}
