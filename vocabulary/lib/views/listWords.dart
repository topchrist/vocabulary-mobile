
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;

import 'wordDetails.dart';

// ignore: must_be_immutable
class ListWords extends StatefulWidget {
  dynamic level;

  ListWords(this.level) ;

  @override
  _ListWordsState createState() => _ListWordsState(level);
}

class _ListWordsState extends State<ListWords> {
  List<dynamic> words;
  List<dynamic> filtre;
  dynamic level;

  _ListWordsState(this.level);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List words'),
      ),
      //backgroundColor: Colors.blue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextField(
            onChanged: (String str){
              filterWords(str);
            },
            onSubmitted: (String str){

            },
            decoration: new InputDecoration(
              labelText: "search...",
            )
          ),
        ),
        //new Padding(padding: new EdgeInsets.all(1.00)),
        Expanded(
          child: Center(
            child: this.filtre==null?CircularProgressIndicator():
            Column(
              children: [
                ListView.builder(
                  //scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: this.filtre==null?0:this.filtre.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      //color: Colors.pink,
                      title : Text(this.filtre[index]['name']),
                        //child: Text(this.level),
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => new WordDetails(this.filtre[index])
                              )
                          );
                        },
                      );

                  }
              ),
              ],
            ),
          ),
        ),
          //Center(child: Text("data"))
        ]
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadWords(level);
  }

  void loadWords(dynamic level) {
    final url = Uri.parse("http://192.168.56.1:3000/api/words/$level");
    http.get(url)
        .then((resp) {
      setState(() {
        this.words = json.decode(resp.body);
        this.filtre = this.words;
        //print(this.level);
        //print(this.words);
      });
    }).catchError((err){
      print(err);
    });
  }
  void filterWords(String str) {
    setState(() {
      this.filtre = this.words;
    });
     if(str.isNotEmpty){
       setState(() {
         this.filtre = words.where((i) => i['name'].toString().trim().toLowerCase().contains(str.trim().toLowerCase())).toList();
       });
     }
     //return words;
  }
}
