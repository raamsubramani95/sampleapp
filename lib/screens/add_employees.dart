import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:teamemployees/models/employees_object.dart';
import 'package:teamemployees/models/team_object.dart';
import 'package:teamemployees/utils/constants.dart';
import 'package:teamemployees/utils/database.dart';

import 'employeessceen.dart';

class CustomDialogBox extends StatefulWidget {
  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  TextEditingController Emplyname = TextEditingController();
  TextEditingController Emplyage = TextEditingController();
  TextEditingController Employcity = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool _validate = false;
  bool isSwitched = false;
  List teamid=[];
  List teamidlist=[];
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
//      backgroundColor: Color.fromRGBO(48, 48, 47, 1),
      child: contentBox(context),
    );
  }
  getteamlist() async {
    var _teamid = await   DB.db.getteam();
    setState(() {
      teamid=_teamid;
    });
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
    getteamlist();
  }
  contentBox(context){
    return  Container(
        width: 200,
        height: 550,
        child: SingleChildScrollView(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Text("Add Employee",style: APP_STYLEWITHBOLD,),
              Container(
                  width: 200,
                  height: 500,
                  child: Form(
                      key: _formKey,
                      child:Column(
                          children: [
                            TextFormField(
                              maxLength: 15,
                              obscureText: false,
                              controller: Emplyname,
                              validator: (value) {
                                String patttern = r'(^[a-zA-Z ]*$)';
                                RegExp regExp = new RegExp(patttern);
                                if (value.length == 0) {
                                  return "Name is Required";
                                } else if (value.length < 2) {
                                  return "Name is min 2 characters";
                                }
                                else if (!regExp.hasMatch(value)) {
                                  return "Name must be a-z and A-Z";
                                }
                                return null;
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hoverColor: Colors.white,
                                focusColor: Colors.white,
                                hintText: "Enter the Name ",hintStyle: TextStyle(color:Colors.black38),
                              ),
                            ),
                            TextFormField(
                              maxLength: 2,
                              obscureText: false,
                              controller: Emplyage,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                String patttern = r'(^[0-9]*$)';
                                RegExp regExp = new RegExp(patttern);
                                if (value.length == 0) {
                                  return "Age is Required";
                                } else if(value.length != 2){
                                  return "Age must 2 digits";
                                }else if (!regExp.hasMatch(value)) {
                                  return "Age must be digits";
                                }
                                return null;
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hoverColor: Colors.white,
                                focusColor: Colors.white,
                                hintText: "Enter the Age ",hintStyle: TextStyle(color:Colors.black38),
                              ),
                            ),
                            TextFormField(
                              maxLength: 15,
                              obscureText: false,
                              controller: Employcity,
                              validator: (value) {
                                String patttern = r'(^[a-zA-Z ]*$)';
                                RegExp regExp = new RegExp(patttern);
                                if (value.length == 0) {
                                  return "City is Required";
                                } else if (value.length < 2) {
                                  return "City is min 2 characters";
                                }
                                else if (!regExp.hasMatch(value)) {
                                  return "City must be a-z and A-Z";
                                }
                                return null;
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hoverColor: Colors.white,
                                focusColor: Colors.white,
                                hintText: "Enter the City",hintStyle: TextStyle(color:Colors.black38),
                              ),
                            ),
                            new Row(
                              children: [
                                new Text("Is TeamLean"),
                                Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                      print(isSwitched);
                                    });
                                  },
                                  activeTrackColor: Colors.lightGreenAccent,
                                  activeColor: Colors.green,
                                ),

                              ],
                            ),
                            new Text("Team"),
                            MultiSelect(
                              change:(value) {
                                teamidlist.add(value);
                               print('The value is $teamidlist');
                                  } ,
                                autovalidate: true,
                                titleText: 'Country of Residence',
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select one or more option(s)';
                                  }
                                },
                                errorText: 'Please select one or more option(s)',
                                dataSource: teamid,
                                textField: 'team_name',
                                valueField: 'team_name',
                                filterable: true,
                                required: true,
                                value: null,
                            ),
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
                                              DB.db.addemploy(
                                                  Employees.fromJson(
                                                      {
                                                        "id":12,
                                                        "name":Emplyname.text,
                                                        "age":Emplyage.text,
                                                        "city":Employcity.text,
                                                        "team":teamidlist.toString(),
                                                        "teamlead":isSwitched.toString(),
                                                      }
                                                      ));
                                              getemployeeslist();
                                              EMPLYEESLIST.clear();
                        Navigator.pop(context);
                                              Navigator.pop(context);
                                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                  builder: (context) => new Myemployeesscreen()));
                      }
                    },
                  )
                ],
              )
            ]
        ))
    );
  }
}