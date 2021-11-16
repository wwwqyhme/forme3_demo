import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_fields/forme_fields.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../exmaple.dart';
import '../forme_screen.dart';

class FormePinCodeTextFieldScreen extends FormeScreen {
  static late StreamController<ErrorAnimationType> errorController;
  FormePinCodeTextFieldScreen({Key? key})
      : super(
            key: key,
            title: 'FormePinCodeTextField',
            onInitState: () {
              errorController = StreamController<ErrorAnimationType>();
            },
            onDispose: () {
              errorController.close();
            },
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
                    errorAnimationController: errorController,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    validator: (f, v) =>
                        v == null ? 'pls input pin code' : null,
                    decorator: const FormeInputDecoratorBuilder(
                        decoration: InputDecoration(labelText: 'Pin Code')),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.blue.shade50,
                    enableActiveFill: true,
                    autovalidateMode: AutovalidateMode.always,
                    asyncValidator: (f, v) {
                      return Future.delayed(const Duration(milliseconds: 1500),
                          () {
                        if (v != null) {
                          errorController.add(ErrorAnimationType.shake);
                          return 'invalid pin code';
                        }
                      });
                    },
                  ),
                  subTitle: 'Example1',
                  title: 'FormePinCodeTextField',
                ),
              ];
            });
}
