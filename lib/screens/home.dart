import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamemployees/utils/constants.dart';

import 'Teamsceen.dart';
import 'employeessceen.dart';

class Myhomescreen extends StatefulWidget {
  @override
  _Myhomescreen createState() => new _Myhomescreen();
}

class _Myhomescreen extends State<Myhomescreen> {


  List roledate=["Team","Employee"];
  @override
  void initState() {
    super.initState();
  }
  Future<bool> _onWillPop() async {
    return (await     showDialog(
        context: context,
        child:  CupertinoAlertDialog(
          title: Text("Message"),
          content: Text( "Are you sure you want to exit ?"),
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
                  Navigator.of(context).pop(true);
                },
                child: Text("Yes")
            ),
          ],
        ))

    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text('Home screen ', textAlign: TextAlign.center,
                  style: APP_STYLE),
              backgroundColor: Color.fromRGBO(77, 155, 215, 1),
            ),
            body: new Center(
                child:   ListView.builder(
                  itemCount: roledate.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Card(
                          child: ListTile(
                            title: new Text(roledate[index]),
                            trailing: IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                ),
                                onPressed: () {

                                }),
                            onTap: (){
                              if(roledate[index]=="Team"){
                                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                    builder: (context) => new Myteamscreen()));
                              }
                              else{
                                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                    builder: (context) => new Myemployeesscreen()));
                              }
                            },
                          ),
                        )
                      );}
                ))
        ));
  }
}