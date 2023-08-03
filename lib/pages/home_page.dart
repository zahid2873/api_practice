import 'dart:convert';

import 'package:api_practice/pages/photos_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/posts_model.dart';
import 'package:http/http.dart' as http;

class PostsHomePage extends StatefulWidget {
  const PostsHomePage({Key? key}) : super(key: key);

  @override
  State<PostsHomePage> createState() => _PostsHomePageState();
}

class _PostsHomePageState extends State<PostsHomePage> {
  List<PostsModel> postsList = [];

  Future <List<PostsModel>> getPostsApi() async{
    String url = "https://jsonplaceholder.typicode.com/posts";
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for (dynamic i in data){
        postsList.add(PostsModel.fromJson(i));
      }
      return postsList;
    }else{
      return postsList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
        actions: [
          TextButton(onPressed: (){
            Get.to(()=>PhotosPage(), transition: Transition.downToUp, duration: Duration(seconds: 2));
          }, child: Text("Next Api", style: TextStyle(color: Colors.orange),))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostsApi(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                } else{
                  return ListView.builder(
                      itemCount: postsList.length,
                      itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height *.3,
                        child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.green.withOpacity(.7),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(postsList[index].title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text("User Id: ${postsList[index].userId!}", style: TextStyle(color: Colors.black.withOpacity(.5),fontSize: 12, fontWeight: FontWeight.bold),),
                                      Spacer(),
                                      Text(" Id: ${postsList[index].id!}", style: TextStyle(color: Colors.black.withOpacity(.5),fontSize: 12, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Text(postsList[index].body!, style: TextStyle(fontSize: 12,),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                }

              }
            ),
          ),
        ],
      ),
    );
  }
}
