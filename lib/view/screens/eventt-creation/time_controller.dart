// ignore_for_file: deprecated_member_use

import 'package:alan_voice/alan_callback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/view/constants/constants.dart';

class TimeContainer extends StatelessWidget {
  const TimeContainer({
    Key? key,
    required this.minTimeController,
    required this.hourTimeController,
  }) : super(key: key);

  final TextEditingController minTimeController;
  final TextEditingController hourTimeController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            height: 55,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
              // color: Colors.red,
              border: Border.all(
                width: 0.5,
                color: primaryPurple,
              ),
            ),
            child: FocusScope(
              child: Focus(
                onFocusChange: (focus) {
                  if (!focus) {
                    _addTime();
                  }
                },
                child: TextFormField(
                  controller: hourTimeController,
                  onEditingComplete: () {
                    _addTime();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onChanged: (value) {
                    hourTimeValidator(value);
                  },
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryPurple,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 59.5,
            child: Container(
              alignment: Alignment.center,
              height: 55,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                // color: Colors.red,
                border: Border.all(width: 0.5, color: primaryPurple),
              ),
              child: FocusScope(
                child: Focus(
                  onFocusChange: (focus) {
                    if (!focus) {
                      _addTime();
                    }
                  },
                  child: TextFormField(
                    onEditingComplete: () {
                      _addTime();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },

                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: false, signed: false),

                    controller: minTimeController,
                    //initialValue: timeMin,

                    onChanged: (value) {
                      minTimeValidator(value);
                    },
                    textAlign: TextAlign.center,

                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 16, color: primaryPurple),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addTime() {
    if (minTimeController.text.isEmpty) {
      minTimeController.text = "00";
    }
    if (minTimeController.text.length == 1) {
      minTimeController.text = "0${minTimeController.text}";
    }
    if (hourTimeController.text.isEmpty) {
      hourTimeController.text = "00";
    }

    if (hourTimeController.text.length == 1) {
      hourTimeController.text = "0${hourTimeController.text}";
    }
  }

  void minTimeValidator(value) {
    if (!value.isEmpty) {
      if (int.parse(value) > 59 && value.length <= 2) {
        minTimeController.text = "59";
        minTimeController.selection = TextSelection(
            baseOffset: 0, extentOffset: minTimeController.value.text.length);
      } else if (value.length > 2) {
        minTimeController.text = (int.parse(value) / 10).floor().toString();
        minTimeController.selection = TextSelection(
            baseOffset: 0, extentOffset: minTimeController.value.text.length);
      } else if (int.parse(value) < 0) {
        minTimeController.text = "00";
        minTimeController.selection = TextSelection(
            baseOffset: 0, extentOffset: minTimeController.value.text.length);
      }
    }
  }

  void hourTimeValidator(value) {
    if (!value.isEmpty) {
      if (int.parse(value) > 23 && value.length <= 2) {
        hourTimeController.text = "23";
        hourTimeController.selection = TextSelection(
            baseOffset: 0, extentOffset: hourTimeController.value.text.length);
      } else if (value.length > 2) {
        hourTimeController.text = (int.parse(value) / 10).floor().toString();
        hourTimeController.selection = TextSelection(
            baseOffset: 0, extentOffset: hourTimeController.value.text.length);
      } else if (int.parse(value) < 0) {
        hourTimeController.text = "00";
        hourTimeController.selection = TextSelection(
            baseOffset: 0, extentOffset: hourTimeController.value.text.length);
      }
    }
  }
}
