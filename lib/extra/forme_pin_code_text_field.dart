import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forme_fields/forme_fields.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../exmaple.dart';
import '../forme_screen.dart';

class FormePinCodeTextFieldScreen extends FormeScreen {
  FormePinCodeTextFieldScreen({Key? key})
      : super(
            key: key,
            title: 'FormePinCodeTextField',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  name: 'pin',
                  buttons: [
                    TextButton(
                      onPressed: () {
                        key.field('pin').value = '1234567';
                      },
                      child: const Text('set value to 1234567'),
                    )
                  ],
                  field: FormePinCodeTextField(
                    name: 'pin',
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.blue.shade50,
                    enableActiveFill: true,
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                    dialogConfig: DialogConfig(dialogContent: "??"),
                  ),
                  subTitle: 'Example1',
                  title: 'FormePinCodeTextField',
                ),
              ];
            });
}
