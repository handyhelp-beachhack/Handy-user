import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/texttospeech/speak.dart';
import 'package:handy_beachhack/view/screens/texttospeech/speechgeneration.dart';

class TextToSpeech extends StatefulWidget {
  TextToSpeech({Key? key}) : super(key: key);

  @override
  State<TextToSpeech> createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  List<String> shortSpeech = [
    "Hii",
    "Hello",
    "I'm fine",
    "Thankyou",
    "How are you"
  ];

  var descSpeech = {
    "Hii": "Hhaii",
    "Hello": "Hello",
    "I'm fine": "I am Fine",
    "Thankyou": "Thank You very much",
    "How are you": "How are you"
  };

  late var width;

  late var height;

  final descController = TextEditingController();

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title:Center(child: Text("Live Speech Gen.",style:TextStyle(color:primaryPurple,fontSize:20,fontWeight: FontWeight.bold))),
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 229, 242, 255),
            actions: [
              Container(
                padding: EdgeInsets.only(right: 15, top: 2),
                child: FloatingActionButton(
                    foregroundColor: Colors.red,
                    backgroundColor: Color.fromARGB(255, 229, 242, 255),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                content: Stack(
                              children: [
                                // Positioned(
                                //   // right: -40.0,
                                //   top: -10.0,
                                //   child: InkResponse(
                                //     onTap: () {
                                //       Navigator.of(context).pop();
                                //     },
                                //     child: CircleAvatar(
                                //       child: Icon(Icons.close),
                                //       backgroundColor: Colors.red,
                                //     ),
                                //   ),
                                // ),
                                Form(
                                  child: Container(
                                    width: width - 10,
                                    height: height / 3,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: Text("Create a ShortCut",
                                                style: TextStyle(
                                                    color: grey,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextField(
                                              decoration:
                                                  new InputDecoration.collapsed(
                                                hintText: "Shortcut Key",
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              controller: nameController,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextField(
                                                decoration:
                                                    new InputDecoration.collapsed(
                                                  hintText: "Description",
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                controller: descController),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  right: 8.0,
                                                  top: 15.0),
                                              child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith(
                                                    (states) {
                                                      if (states.contains(
                                                          MaterialState
                                                              .pressed)) {
                                                        return Colors.green;
                                                      }
                                                      return primaryPurple;
                                                    },
                                                  )),
                                                  child: Text("ADD",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  onPressed: () {
                                                    setState(() {
                                                      shortSpeech.add(
                                                          nameController.text);
                                                      descSpeech[nameController
                                                              .text] =
                                                          descController.text;
                                                      nameController.clear();
                                                      descController.clear();
                                                      Navigator.pop(context);
                                                    });
                                                  })),
                                        ]),
                                  ),
                                )
                              ],
                            ));
                          });
                    },
                    child: Icon(Icons.add,
                        size: 50, color: Color.fromARGB(255, 233, 110, 10))),
              )
            ]),
        backgroundColor: Color.fromARGB(255, 229, 242, 255),
        body: Container(
          padding: EdgeInsets.all(7),
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(shortSpeech.length, (index) {
              return Center(
                child: Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      if (shortSpeech[index] != null) {
                        String str = descSpeech[shortSpeech[index]].toString();
                        print(str);
                        speak(str);
                      }
    
                      debugPrint('Card tapped.');
                    },
                    child: SizedBox(
                      width: width / 2.56,
                      height: 125,
                      child: Center(
                          child: Text(
                        shortSpeech[index],
                        style:
                            TextStyle(fontSize: 20,color: Color.fromARGB(255, 101, 154, 197), fontWeight: FontWeight.w700),
                      )),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          width:width/2,
          height: 45,
          child: ElevatedButton(
          style:ButtonStyle(backgroundColor:  MaterialStateProperty
                                                              .resolveWith(
                                                    (states) {
                                                      if (states.contains(
                                                          MaterialState
                                                              .pressed)) {
                                                        return Colors.green;
                                                      }
                                                      return primaryPurple;
                                                    },
                                                              )),
            child: Text("Speech Generation",style:TextStyle(color:Colors.white,fontSize:18,fontWeight: FontWeight.bold)),
            onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SpeechGene()))
            },
          ),
        ),
      ),
    );
  }
}
