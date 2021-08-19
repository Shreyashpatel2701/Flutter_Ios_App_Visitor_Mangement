import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:telephony/telephony.dart';
import 'package:visitorproject/VisitorDataModel.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({Key? key}) : super(key: key);

  @override
  _HomeActivityState createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity>
{

  // var firebaseAuth;
  var  currentUser="IuVIPmybxYM7PSeq03c9PxMBzAx1";
  String currentDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
  final dateDBReference=FirebaseDatabase.instance.reference().child("DateDB");
  List<VisitorDataModel> visitorList=[];
  final Telephony telephony = Telephony.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Firebase Messaging
    Firebase.initializeApp();

    //String currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());



    final dateDBChildReference=dateDBReference.child(currentDate);

    //final FirebaseMessaging fdbmsgToken= FirebaseMessaging.instance;
    //fdbmsgToken.getToken().then((value) => print(value));


    dateDBChildReference.onChildAdded.listen((event) {
      //visitorList.clear();
      VisitorDataModel visitordatamodel=new VisitorDataModel.fromDataSnap(event.snapshot);
      bool visited=visitordatamodel.isVisited_Status();
      if(!visited) {

        if(currentUser==visitordatamodel.getWhomToMeet())
        {
            visitorList.add(visitordatamodel);
            print("Data inserted...");
        }

      }
      setState(() {

      });

    });

  }

  Widget setui(String fnm,String lnm,String mob,String whom_to_meet,String reason,String fstatus,String visitedstatusupdate, String uid, int index,String reschedule)
  {


    final newdateDBChildReference=dateDBReference.child(currentDate);


    return new GestureDetector(
      onLongPress: (){},
      onTap: (){},
      child: Card(
        color: Colors.blue[100],
        child: Container(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    fnm+" "+lnm,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,

                    ),
                  ),

                  Text(
                    whom_to_meet,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,

                    ),
                  ),

                  Text(
                    mob,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,

                    ),
                  ),

                  Text(
                    reason,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,

                    ),
                  ),

                  Text(
                    fstatus,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,

                    ),
                  ),

                  Text(
                    visitedstatusupdate,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,

                    ),
                  ),



                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(onPressed: ()async{
                    //_showMyDialog();
                    // newdateDBChildReference.child(uid).update({
                    //   'Visited_Status':true,
                    //   'Visited_Status_Update':'Accepted'
                    // });
                    // visitorList.remove(index);

                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Accept this request'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text('Accept this visitors request to meet you?'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                newdateDBChildReference.child(uid).update({
                                  'Visited_Status':true,
                                  'Visited_Status_Update':'Accepted',
                                  'RescheduledTime' : '-'
                                });
                                Navigator.of(context).pop();
                                visitorList.removeAt(index);
                                setState(() {

                                });
                                telephony.sendSmsByDefaultApp(to: mob, message: "Your request is been accepted");
                              },
                            ),
                          ],
                        );
                      },
                    );


                  },
                      child: Text("Accept"),

                  ),
                  ElevatedButton(onPressed: ()async{
                    //_showTimePicker();

                    final TimeOfDay? picked=await showTimePicker(context: context,initialTime: TimeOfDay(hour: 5,minute: 10));
                    if(picked != null)
                    {
                      //print(picked.format(context));
                      //print(picked.hour);
                      newdateDBChildReference.child(uid).update({
                        'Visited_Status':true,
                        'Visited_Status_Update':'Rescheduled',
                        'RescheduledTime': picked.hour.toString()+ ":" +picked.minute.toString()
                      });
                    }
                    visitorList.removeAt(index);
                    setState(() {

                    });
                    telephony.sendSmsByDefaultApp(to: mob, message: "Your request is been rescheduled at "+reschedule);
                  },
                      child: Text("Reschedule")),
                  ElevatedButton(onPressed: ()async{

                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Deny this request'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text('Deny this visitors request to meet you?'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                newdateDBChildReference.child(uid).update({
                                  'Visited_Status':true,
                                  'Visited_Status_Update':'Deny',
                                  'RescheduledTime': '-'
                                });
                                Navigator.of(context).pop();
                                visitorList.removeAt(index);
                                setState(() {

                                });
                                telephony.sendSmsByDefaultApp(to: mob, message: "Your request is been denied");
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                      child: Text("Deny")),
                ],
              ),
            ],
          ),

        ),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Home Activity'),
        centerTitle: true,
      ),

      body: new Container(

        child: visitorList.length==0?Text("No Data Available"):new ListView.builder(
            itemCount: visitorList.length,
            itemBuilder:(_,index)
            {
              return setui(visitorList[index].First_Name,visitorList[index].Last_Name,visitorList[index].Mobile_NO,visitorList[index].WhomToMeet,visitorList[index].Reason,visitorList[index].FeverStatus,visitorList[index].Visited_Status_Update, visitorList[index].Vuid, index, visitorList[index].getRescheduledTime());
            }
        ),
      ),
    );
  }
}
