import 'package:flutter/material.dart';

import 'VisitorList.dart';

class demovisitorlist extends StatefulWidget {
  const demovisitorlist({Key? key}) : super(key: key);

  @override
  _demovisitorlistState createState() => _demovisitorlistState();
}

class _demovisitorlistState extends State<demovisitorlist> {

  List<VisitorList> visitors=[
    VisitorList(nm: 'Aboli Jadhav', purpose: 'Dont Know', fever: 'No', mobno: '8989898989'),
    VisitorList(nm: 'Theeksha', purpose: 'Weekly Meet', fever: 'No', mobno: '8788155890'),
    VisitorList(nm: 'Manali', purpose: 'XYZ', fever: 'No', mobno: '5656566565'),
    VisitorList(nm: 'Shreyash Patel', purpose: 'General Meet', fever: 'No', mobno: '3456789102'),
    VisitorList(nm: 'Emmmmmma', purpose: 'AAAAAA', fever: 'Yes', mobno: '3456689102'),
    VisitorList(nm: 'Sarah Mass', purpose: 'ZZZZZ', fever: 'Yes', mobno: '3456989102'),

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(' Upcoming Visitor Meets'),
          centerTitle: true,
          backgroundColor: Colors.blue[900],
        ),

        body: ListView.builder(
            itemCount: visitors.length,
            itemBuilder: (context, index) {
              return Card(

                child:
                Container(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.all(10.0),
                  color: Colors.blue[100],
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,

                      children:<Widget>[

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: AssetImage('asset/images/user.png'),
                                  radius: 40.0,
                                ),
                                SizedBox(width: 30.0,),


                              ],
                            ),
                            SizedBox(height: 50.0,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: <Widget>[
                                Text('Name : ' + visitors[index].nm),
                                SizedBox(height: 5.0,),
                                Text('Contact NO: ' + visitors[index].mobno),
                                SizedBox(height: 5.0,),
                                Text('Purpose: ' + visitors[index].purpose),
                                SizedBox(height: 5.0,),
                                Text('Fever: ' + visitors[index].fever),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,

                          children: <Widget>[
                            SizedBox(width: 100.0,
                              child:ElevatedButton(
                                  onPressed: (){},
                                  child: Text('Accept')
                              ),
                            ),

                            SizedBox(width: 100.0,
                              child:ElevatedButton(
                                  onPressed: (){},
                                  child: Text('Reschedule')
                              ),
                            ),


                            SizedBox(width: 100.0,
                              child:ElevatedButton(
                                  onPressed: (){},
                                  child: Text('Deny')
                              ),
                            )

                          ],
                        ),

                      ],

                    ),
                  ),


                ),
              );
            }


        )
    );
  }
}


