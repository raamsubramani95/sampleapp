import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamemployees/models/team_object.dart';
import 'package:teamemployees/utils/constants.dart';
import 'package:teamemployees/utils/database.dart';



class Myteamscreen extends StatefulWidget {
  @override
  _Myteamscreen createState() => new _Myteamscreen();
}

class _Myteamscreen extends State<Myteamscreen> {
  TextEditingController Teamname = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool _validate = false;
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
  @override
  void initState() {
    super.initState();
    getteamlist();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Team', textAlign: TextAlign.center,
              style: APP_STYLE),
          backgroundColor: Color.fromRGBO(77, 155, 215, 1),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(context: context,
                    builder: (BuildContext context){
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
//      backgroundColor: Color.fromRGBO(48, 48, 47, 1),
                        child: Container(
                          width: 200,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    new Text("Add Team",style: APP_STYLEWITHBOLD,),
                                    Container(
                                        width: 200,
                                        height: 100,
                                        child: Form(
                                            key: _formKey,
                                            child:Column(
                                            children: [
                                              TextFormField(
                                                maxLength: 15,
                                                obscureText: false,
                                                controller: Teamname,
                                                validator: (value) {
                                                  String patttern = r'(^[a-zA-Z ]*$)';
                                                  RegExp regExp = new RegExp(patttern);
                                                  if (value.length == 0) {
                                                    return "Team Name is Required";
                                                  } else if (value.length < 2) {
                                                    return "Team Name is min 2 characters";
                                                  }
                                                  else if (!regExp.hasMatch(value)) {
                                                    return "Team Name must be a-z and A-Z";
                                                  }
                                                  return null;
                                                },
                                                cursorColor: Colors.black,
                                                decoration: InputDecoration(
                                                  hoverColor: Colors.white,
                                                  focusColor: Colors.white,
                                                  hintText: "Enter Name Here",hintStyle: TextStyle(color:Colors.black38),
                                                ),
                                              )
                                            ]
                                        ))
                                    ),
                                    new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          child: Text("CANCEL",style: APP_STYLEWITHBOLD),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        InkWell(
                                          child: Text("ADD",style: APP_STYLEWITHBOLD,),
                                          onTap: () {
                                       if (_formKey.currentState.validate()) {
                                         DB.db.addteam(Team.fromJson({"team_id":12,"team_name":Teamname.text}));
                                         getteamlist();
                                         Teamname.clear();
                                         Navigator.pop(context);
                                       }
                                       },
                                        )
                                      ],
                                    )
                                  ]
                              )
                      ));
                    }
                );
              },
            ),
          ],
        ),
        body: new Center(
            child:   ListView.builder(
                itemCount: TEAMLIST.length,
                itemBuilder: (BuildContext context, int index) {
                  Team team =  TEAMLIST.elementAt(index);
                  return Container(
                      child: Card(
                        child: ListTile(
                          title: new Text(team.team_name),
                          trailing:
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    child:  CupertinoAlertDialog(
                                      title: Text(team.team_name),
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
                                              DB.db.deleteteamr(team.team_id);
                                              getteamlist();
                                              Navigator.of(context).pop(true);
                                            },
                                            child: Text("Yes")
                                        ),
                                      ],
                                    ));

                              }),
                          onTap: (){

                          },
                        ),
                      )
                  );}
            ))
    );

  }

}