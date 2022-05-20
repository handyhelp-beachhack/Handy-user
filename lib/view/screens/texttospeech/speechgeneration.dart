import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/texttospeech/speak.dart';

class SpeechGene extends StatefulWidget {
  SpeechGene({Key? key}) : super(key: key);

  @override
  State<SpeechGene> createState() => _SpeechGeneState();
}

class _SpeechGeneState extends State<SpeechGene> {
  var width;
  var height;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
            height: height / 1.5,
            child: SizedBox(
              child: TextField(
                controller: controller,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                expands: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                // minLines: 1,//Normal textInputField will be displayed
                // maxLines: 5,// when user presses enter it will adapt to it
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: width / 3,
              height: 45,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.green;
                    }
                    return primaryPurple;
                  },
                )),
                child: Text("Speak",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                onPressed: () => {
                  
                  speak(controller.text)
                },
              ),
            ),
            Container(
              width: width / 3,
              height: 45,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.green;
                    }
                    return primaryPurple;
                  },
                )),
                child: Text("Clear",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                onPressed: () => {
                  controller.clear()
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
