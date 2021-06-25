import 'package:flutter/widgets.dart';

import 'fader.dart';

class ColorInput extends StatelessWidget {
  const ColorInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("color");
  }
}

class RGBInput extends StatelessWidget {
  const RGBInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      FaderInput(),
      FaderInput(),
      FaderInput(),
    ]);
  }
}

class HSBInput extends StatelessWidget {
  const HSBInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      FaderInput(),
      FaderInput(),
      FaderInput(),
    ]);
  }
}

class ColorPicker extends StatelessWidget {
  const ColorPicker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
