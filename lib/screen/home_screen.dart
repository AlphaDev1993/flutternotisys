import 'package:flutter/material.dart';
import 'package:flutternotisys/services/notification_service.dart';
import 'package:flutternotisys/widgets/date_time_selecter.dart';



 class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

   @override
   State<HomeScreen> createState() => _HomeScreenState();
 }

 class _HomeScreenState extends State<HomeScreen> {

    final NotificationService _notificationService = NotificationService();
   DateTime selectedDate = DateTime.now();
   TimeOfDay selectedTime = TimeOfDay.now();

    Future<void> scudleNotification()async{
      final DateTime _scudleDateTime =  DateTime(selectedDate.year,selectedDate.month,selectedDate.day,selectedTime.hour,selectedTime.minute);
      
      if(_scudleDateTime.isBefore(DateTime.now())){
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please select future date and time!"),
            backgroundColor: Colors.redAccent,)
          );
        }
        return;
      }
      await _notificationService.sculduleNotification(_scudleDateTime);
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text("Notification Schdule for ${_scudleDateTime.toString()}"),
           backgroundColor: Colors.redAccent,)
        );
      }
    }


    void _updateDateTime(DateTime date,TimeOfDay time){
      setState(() {
        selectedDate= date;
        selectedTime = time;
      });
    }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Notification Example"),
       ),
       body: Padding(padding: EdgeInsets.all(16),
       child:  Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
            ElevatedButton(onPressed:
              _notificationService.showInstanceNoti
            ,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white
                ),
                child: Text("Send Instance Notification! ")),
           SizedBox(height: 24,),

           Text("Schdule Notification",style: TextStyle(
              fontSize: 18,
             fontWeight: FontWeight.bold,

           ),),
           SizedBox(
             height: 16,
           ),
           DateTimeSelecter(selectedDate: selectedDate, selectedTime: selectedTime, onDateTimeChanged: _updateDateTime),
           SizedBox(height: 10,),

           ElevatedButton(onPressed: scudleNotification,
               style: ElevatedButton.styleFrom(
                   padding: EdgeInsets.symmetric(vertical: 12),
                   backgroundColor: Colors.green,
                   foregroundColor: Colors.white
               ),
               child: Text("Schdule Notification! ")),

         ],
       )
         ,),
     );
   }
 }
