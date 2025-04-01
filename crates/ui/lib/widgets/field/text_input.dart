import 'package:flutter/material.dart'
    show Colors, FloatingLabelBehavior, InputBorder, InputDecoration, TextField, Theme;
import 'package:flutter/services.dart' show FilteringTextInputFormatter, TextInputAction;
import 'package:flutter/widgets.dart';
import 'package:mizer/widgets/text_field_focus.dart';

class TextInput extends StatelessWidget {
  final bool autofocus;
  final FocusNode? focusNode;
  final String? value;
  final TextEditingController? controller;
  final String? placeholder;
  final TextAlign? textAlign;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final bool multiline;
  final bool readOnly;
  final TextInputAction textInputAction;

  const TextInput(
      {super.key,
      this.autofocus = false,
      this.focusNode,
      this.value,
      this.controller,
      this.placeholder,
      this.onChanged,
      this.onSubmitted,
      this.textAlign,
      this.multiline = false,
      this.readOnly = false,
      this.textInputAction = TextInputAction.next});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;

    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: multiline ? 8 : 0),
      child: TextFieldFocus(
        child: TextField(
          focusNode: focusNode,
          readOnly: readOnly,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: placeholder,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              isDense: true),
          cursorColor: Colors.white,
          controller: controller,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: textStyle,
          textAlign: textAlign ?? (multiline ? TextAlign.start : TextAlign.end),
          keyboardType: multiline ? TextInputType.multiline : TextInputType.text,
          autofocus: autofocus,
          inputFormatters: multiline ? null : [FilteringTextInputFormatter.singleLineFormatter],
          maxLines: multiline ? null : 1,
          textInputAction: textInputAction,
        ),
      ),
    );
  }
}
