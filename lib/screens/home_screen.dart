import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Data>> getData()async{
   var res = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
   var jsonData = jsonDecode(res.body);
   List<Data>dataList =[];
   for(var i in jsonData){
     Data data = Data(i["url"], i["title"]);
     dataList.add(data);
   }return dataList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images from API'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Data>>(
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          } else if(snapshot.hasError){
            return const Text('an error occured');

          }else{
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1), 
              itemBuilder: (context, i){
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: GridTile(
                      child: Image.network(snapshot.data![i].url),
                      footer: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black45
                        ),
                        width: double.infinity,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 50.0
                          ),
                          child: Text(
                            snapshot.data![i].title,
                            textScaleFactor: 1.3,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            ),
                        )
                        ),
                      ),
                  ),
                );
              },
              itemCount: snapshot.data!.length,
              );
          }
        },
        future: getData(),
        ),
    );
  }
}

class Data{
final String url,title;
  Data(this.url,this.title);
}