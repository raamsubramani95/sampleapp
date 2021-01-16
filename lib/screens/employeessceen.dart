import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teamemployees/models/employees_object.dart';
import 'package:teamemployees/models/team_object.dart';
import 'package:teamemployees/utils/constants.dart';
import 'package:teamemployees/utils/database.dart';

import 'add_employees.dart';

class Myemployeesscreen extends StatefulWidget {
  @override
  _Myemployeesscreen createState() => new _Myemployeesscreen();
}

class _Myemployeesscreen extends State<Myemployeesscreen> {
  getteamlist() async {
    var teamlist = await   DB.db.getteam();
    setState(() {
      TEAMLIST.clear();
      for(Map user in teamlist){
        TEAMLIST.add(Team.fromJson(user));
      }
    });
    print(TEAMLIST);
  }
  getemployeeslist() async {
    var emlpoyeeslist = await   DB.db.getemploy();
    setState(() {
      EMPLYEESLIST.clear();
      for(Map user in emlpoyeeslist){
        EMPLYEESLIST.add(Employees.fromJson(user));
      }
    });
    print(EMPLYEESLIST);
  }
  @override
  void initState() {
    super.initState();
    getemployeeslist();
    getteamlist();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Employees', textAlign: TextAlign.center,
              style: APP_STYLE),
          backgroundColor: Color.fromRGBO(77, 155, 215, 1),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                if(TEAMLIST.isEmpty){
                  Fluttertoast.showToast(
                      msg:"TEAMLIST is Empty" ,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }else{
                  showDialog(context: context,
                      builder: (BuildContext context){
                        return CustomDialogBox();
                      }
                  );
                }

              },
            ),
          ],
        ),
        body: new Center(
            child:   ListView.builder(
                itemCount: EMPLYEESLIST.length,
                itemBuilder: (BuildContext context, int index) {
                  Employees employees =  EMPLYEESLIST.elementAt(index);
                  return Container(
                    width: 200,
                      height: 150,
                      child: Card(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Text(employees.name.toUpperCase(),style: APP_STYLEWITHBOLD,),
                                new Text("Age : "+employees.age,style: APP_STYLEWITHgrey,),
                                employees.teamlead==true?new Text(" ",style: APP_STYLEWITHBOLD,)
                                    : new Text("Team Lead : null",style: APP_STYLEWITHBOLD,),
                                new Text(employees.team,style: APP_STYLEWITHBOLD,),
                              ],
                            ),
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                    new Text("City : "+employees.city,style: APP_STYLEWITHgrey,),
                                IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          child:  CupertinoAlertDialog(
                                            title: Text(employees.name),
                                            content: Text( "Are you sure you want to Delete ?"),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                  isDefaultAction: true,
                                                  onPressed: (){
                                                    Navigator.of(context).pop(false);
                                                  },
                                                  child: Text("No")
                                              ),
                                              CupertinoDialogAction(
                                                  isDefaultAction: true,
                                                  onPressed: () async {
                                                    DB.db.deleteemploy(employees.id);
                                                    getemployeeslist();
                                                    Navigator.of(context).pop(true);
                                                  },
                                                  child: Text("Yes")
                                              ),
                                            ],
                                          ));

                                    }),
                              ],
                            ),

                          ],
                        )
                      )
                  );}
            ))
    );

  }


}