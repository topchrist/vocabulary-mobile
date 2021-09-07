import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WordDetails extends StatefulWidget {
  dynamic word;

  WordDetails(this.word);
  @override
  _WordDetailsState createState() => _WordDetailsState(this.word);
}

class _WordDetailsState extends State<WordDetails> {
  dynamic word;
  _WordDetailsState(this.word);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Definition"),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(this.word['name'])
                ),
              ],
            ),
            Text("Type : "+this.word['nature']),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            if(word['Definitions'] != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: printDef(word['Definitions']),
              )


          ]
      ),
    );

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadWord();
  }

  List<Widget> printDef(List<dynamic> listDef) {

    final children = <Widget>[];

    if(listDef != null && listDef.length > 0)
      children.add(Text("Description : "));
      //Text("Description : ")

    if(listDef != null && listDef.length > 0)
     for(var i=1; i<=listDef.length; i++ ) {
       List<dynamic> listExpl;
       if(listDef[i-1]['Examples'] != null) {
         listExpl = listDef[i-1]['Examples'];
       }
       children.add(
         Padding(
           padding: const EdgeInsets.all(10.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text("$i.  "+listDef[i-1]['description']),
               Padding(
                 padding: const EdgeInsets.only(left:15.0, top: 5),
                   child: Text('Examples :')

               ),

               if(listExpl != null && listExpl.length > 0)
                 for(var j=0; j<listExpl.length; j++ )
                    Padding(
                        padding: const EdgeInsets.only(left:25.0, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("->  "+listExpl[j]['statement']),
                          ]
                        )
                      ),
             ]
           )
         )
       );
     }
    return children;
  }

  void loadWord() {
    int id = this.word['id'];
    final url = Uri.parse("http://192.168.56.1:3000/api/word/$id");
    http.get(url)
        .then((resp) {
      setState(() {
        this.word = json.decode(resp.body);
      });
      //print(word['Definitions']);
    }).catchError((err){
      print(err);
    });
  }
}
