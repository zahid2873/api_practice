import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/photos_model.dart';
import 'package:http/http.dart' as http;

class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  List <PhotosModel> photoList = [];
  Future<List<PhotosModel>> getApiPhotos() async{
    String url = "https://jsonplaceholder.typicode.com/photos";
    final response  = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());
    //print(data);
    if(response.statusCode ==200){
      for(Map i in data){
        PhotosModel photos = PhotosModel(albumId: i["albumId"], id: i["id"], title: i["title"], url: i["url"], thumbnailUrl: i["thumbnailUrl"]);
        photoList.add(photos);
      }
      //print(photoList);
      return photoList;
    }else{
      return photoList;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getApiPhotos();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photos Api"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getApiPhotos(),
                builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }else{
                  return ListView.builder(
                      itemCount: photoList.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text(photoList[index].title.toString()),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(photoList[index].url.toString()),
                          ),
                          trailing: Text(snapshot.data![index].id.toString()),
                          subtitle: Column(
                            children: [
                              Image.network(snapshot.data![index].thumbnailUrl.toString()),
                            ],
                          ),

                        );

                      });

                }
            }),
          )
        ],
      ),
    );
  }
}
