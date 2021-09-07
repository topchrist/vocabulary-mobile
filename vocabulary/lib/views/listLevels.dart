import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voccabulary/views/listWords.dart';

class ListLevels extends StatefulWidget {
  const ListLevels() : super();

  @override
  _ListLevelsState createState() => _ListLevelsState();
}

class _ListLevelsState extends State<ListLevels> {
  List<dynamic> listLevels;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List levels'),
      ),
      body: Center(
        child: this.listLevels==null?CircularProgressIndicator():
            ListView.builder(
              itemCount: this.listLevels==null?0:this.listLevels.length,
                itemBuilder: (context, index){
                  return Card(
                    //color: Colors.yellow,
                    child: ElevatedButton(

                      child: Text(this.listLevels[index]['name']),
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => new ListWords(this.listLevels[index]['id'])
                          )
                        );
                      },
                    ),
                  );
                }
            )
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLevels();
  }

  void loadLevels() {
    final url = Uri.parse("http://192.168.56.1:3000/api/levels");
    http.get(url)
    .then((resp) {
      setState(() {
        this.listLevels = json.decode(resp.body);
      });
    }).catchError((err){
      print(err);
    });
  }

}
