import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                    validator: (f, v) {
                      return v.length < 6 ? 'pls input pin code' : null;
                    },
                    decorator: const FormeInputDecoratorBuilder(
                        decoration: InputDecoration(labelText: 'Pin Code')),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.blue.shade50,
                    enableActiveFill: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    asyncValidator: (f, v, isValid) {
                      return Future.delayed(const Duration(milliseconds: 1500),
                          () {
                        if (v != null) {
                          if (isValid()) {
                            errorController.add(ErrorAnimationType.shake);
                          }
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

/// https://pub.dev/packages/pin_code_fields
class FormePinCodeTextField extends FormeField<String> {
  final int length;
  FormePinCodeTextField({
    String? initialValue,
    required String name,
    Key? key,
    int? order,
    bool quietlyValidate = false,
    Duration? asyncValidatorDebounce,
    AutovalidateMode? autovalidateMode,
    FormeValueChanged<String>? onValueChanged,
    FormeFocusChanged<String>? onFocusChanged,
    FormeFieldValidationChanged<String>? onValidationChanged,
    FormeFieldInitialed<String>? onInitialed,
    FormeFieldSetter<String>? onSaved,
    FormeValidator<String>? validator,
    FormeAsyncValidator<String>? asyncValidator,
    FormeFieldDecorator<String>? decorator,
    bool registrable = true,
    bool readOnly = false,
    required this.length,
    VoidCallback? onTap,
    TextStyle? textStyle,
    Curve animationCurve = Curves.easeInOut,
    bool autofocus = false,
    Brightness? keyboardAppearance,
    List<TextInputFormatter> inputFormatters = const [],
    TextInputType keyboardType = TextInputType.visiblePassword,
    bool obscureText = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction textInputAction = TextInputAction.done,
    double cursorWidth = 2,
    Color? cursorColor,
    double? cursorHeight,
    String obscuringCharacter = '●',
    Widget? obscuringWidget,
    bool blinkWhenObscuring = false,
    Duration blinkDuration = const Duration(milliseconds: 500),
    Color? backgroundColor,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween,
    Duration animationDuration = const Duration(milliseconds: 150),
    AnimationType animationType = AnimationType.slide,
    bool useHapticFeedback = false,
    bool enableActiveFill = false,
    bool autoDismissKeyboard = true,
    PinTheme pinTheme = const PinTheme.defaults(),
    double errorTextSpace = 16,
    bool enablePinAutofill = true,
    int errorAnimationDuration = 500,
    String? hintCharacter,
    TextStyle? hintStyle,
    AutofillContextAction onAutoFillDisposeAction =
        AutofillContextAction.commit,
    bool useExternalAutoFillGroup = false,
    EdgeInsets scrollPadding = const EdgeInsets.all(20),
    HapticFeedbackTypes hapticFeedbackTypes = HapticFeedbackTypes.light,
    TextStyle? pastedTextStyle,
    StreamController<ErrorAnimationType>? errorAnimationController,
    bool Function(String? text)? beforeTextPaste,
    DialogConfig? dialogConfig,
    List<BoxShadow>? boxShadows,
    bool showCursor = true,
    Gradient? textGradient,
    bool enabled = true,
    ValueChanged<String>? onCompleted,
  })  : assert(initialValue == null || initialValue.length == length),
        super(
          enabled: enabled,
          registrable: registrable,
          decorator: decorator,
          order: order,
          quietlyValidate: quietlyValidate,
          asyncValidatorDebounce: asyncValidatorDebounce,
          autovalidateMode: autovalidateMode,
          onValueChanged: onValueChanged,
          onFocusChanged: onFocusChanged,
          onValidationChanged: onValidationChanged,
          onInitialed: onInitialed,
          onSaved: onSaved,
          validator: validator,
          asyncValidator: asyncValidator,
          key: key,
          readOnly: readOnly,
          name: name,
          initialValue: initialValue ?? '',
          builder: (genericState) {
            final bool readOnly = genericState.readOnly;
            final bool enabled = genericState.enabled;
            final _FormePinCodeTextFieldState state =
                genericState as _FormePinCodeTextFieldState;
            return PinCodeTextField(
              onChanged: state.didChange,
              onCompleted: onCompleted,
              appContext: state.context,
              length: length,
              onTap: onTap,
              controller: state.textEditingController,
              focusNode: state.focusNode,
              textStyle: textStyle,
              animationCurve: animationCurve,
              animationDuration: animationDuration,
              enabled: enabled,
              keyboardAppearance: keyboardAppearance,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              obscureText: obscureText,
              textCapitalization: textCapitalization,
              textInputAction: textInputAction,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorColor: cursorColor,
              obscuringCharacter: obscuringCharacter,
              obscuringWidget: obscuringWidget,
              blinkWhenObscuring: blinkWhenObscuring,
              blinkDuration: blinkDuration,
              backgroundColor: backgroundColor,
              mainAxisAlignment: mainAxisAlignment,
              animationType: animationType,
              autoFocus: autofocus,
              readOnly: readOnly,
              useHapticFeedback: useHapticFeedback,
              hapticFeedbackTypes: hapticFeedbackTypes,
              pastedTextStyle: pastedTextStyle,
              enableActiveFill: enableActiveFill,
              autoDismissKeyboard: autoDismissKeyboard,
              autoDisposeControllers: false,
              errorAnimationController: errorAnimationController,
              beforeTextPaste: beforeTextPaste,
              dialogConfig: dialogConfig,
              pinTheme: pinTheme,
              errorTextSpace: errorTextSpace,
              enablePinAutofill: !readOnly && enablePinAutofill,
              errorAnimationDuration: errorAnimationDuration,
              boxShadows: boxShadows,
              showCursor: showCursor,
              hintCharacter: hintCharacter,
              hintStyle: hintStyle,
              textGradient: textGradient,
              onAutoFillDisposeAction: onAutoFillDisposeAction,
              useExternalAutoFillGroup: useExternalAutoFillGroup,
              scrollPadding: scrollPadding,
            );
          },
        );

  @override
  FormeFieldState<String> createState() => _FormePinCodeTextFieldState();
}

class _FormePinCodeTextFieldState extends FormeFieldState<String> {
  late final TextEditingController textEditingController;

  @override
  FormePinCodeTextField get widget => super.widget as FormePinCodeTextField;

  @override
  void beforeInitiation() {
    super.beforeInitiation();
    textEditingController = TextEditingController(text: value);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  String get value {
    final String value = super.value;
    if (value.length > widget.length) {
      return value.substring(0, widget.length);
    }
    return super.value;
  }

  @override
  void onValueChanged(String value) {
    super.onValueChanged(value);
    if (textEditingController.text != value) {
      textEditingController.text = value;
    }
  }
}
