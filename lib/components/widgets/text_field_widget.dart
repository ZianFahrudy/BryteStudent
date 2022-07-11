import 'package:flutter/material.dart';
import 'package:bryte/components/utils/theme.dart';

class TextFieldWidget extends StatefulWidget {
  final String? labelText;
  final IconData? iconData;
  final TextInputType? inputType;
  final String? hint;
  final TextEditingController? textEditingController;
  const TextFieldWidget(
      {this.labelText,
      this.iconData,
      this.inputType,
      this.hint,
      this.textEditingController,
      Key? key})
      : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool obscurity = false;
  final FocusNode focusNode = FocusNode();
  TextStyle? labelStyle;
  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);

    if (widget.labelText == 'Password' ||
        widget.labelText == 'Retype Password' ||
        widget.labelText == 'New Password' ||
        widget.labelText == 'Re-type new password' ||
        widget.labelText == 'Confirm Password') {
      setState(() {
        obscurity = true;
      });
    }
  }

  bool isFocus = false;
  void onFocusChange() {
    setState(() {
      if (focusNode.hasFocus) {
        isFocus = true;
      } else {
        isFocus = false;
      }
    });
  }

  @override
  void dispose() {
    focusNode.removeListener(onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: brytepurpleligth,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: TextField(
            focusNode: focusNode,
            keyboardType: widget.inputType,
            controller: widget.textEditingController,
            obscureText: obscurity,
            // onChanged: (value) {
            //   if (widget.labelText == 'Password' ||
            //       widget.labelText == 'Retype Password' ||
            //       widget.labelText == 'New Password' ||
            //       widget.labelText == 'Re-type new password' ||
            //       widget.labelText == 'Confirm Password') {
            //     setState(() {
            //       obscurity = true;
            //     });
            //   }
            // },
            cursorColor: brytepurple,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hint,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    obscurity = !obscurity;
                  });
                },
                child: widget.iconData == Icons.visibility
                    ? (obscurity
                        ? Icon(Icons.visibility_off, color: brytepurple)
                        : Icon(
                            Icons.visibility,
                            color: brytepurple,
                          ))
                    : Icon(
                        widget.iconData,
                        color: brytepurple,
                      ),
              ),
              labelText: widget.labelText,
              labelStyle: brytStylelabel,
            )));
  }
}
