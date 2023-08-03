import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUserApi()async{
    String url = 'https://jsonplaceholder.typicode.com/users';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    if(response.statusCode==200){
      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }else{
      return userList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Api"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator(),);
                  }else{
                    return ListView.builder(
                      itemCount: userList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index){
                      return Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text( "Name${userList[index].name.toString()}"),
                            Text( "Phone${userList[index].phone.toString()}"),
                            Text( "Phone${userList[index].email.toString()}"),
                            Text( "Website${userList[index].website.toString()}"),
                            Text( "Company \n Name${userList[index].company!.name.toString()}"),
                            Text( "Catch Phrase${userList[index].company!.catchPhrase.toString()}"),
                            Text( "Address \n Street${userList[index].address!.street.toString()}"),
                            Text( "Suite${userList[index].address!.suite.toString()}"),
                            Text( "City${userList[index].address!.city.toString()}"),
                            Text( "ZipCode${userList[index].address!.zipcode.toString()}"),
                            Text( "Geo \n lat${userList[index].address!.geo!.lat.toString()}"),
                            Text( "lng${userList[index].address!.geo!.lng.toString()}"),
                          ],
                        ),
                      );
                    });
                  }

            }
            ),
          )
        ],
      ),
    );
  }
}
