import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:provider/provider.dart';

class EffectsView extends StatefulWidget {
  const EffectsView({Key? key}) : super(key: key);

  @override
  State<EffectsView> createState() => _EffectsViewState();
}

class _EffectsViewState extends State<EffectsView> {
  Effect? effect;

  @override
  Widget build(BuildContext context) {
    EffectsApi api = context.read();
    return FutureBuilder(
        future: api.getEffects(),
        builder: (context, AsyncSnapshot<List<Effect>> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          List<Effect> effects = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: Panel(
                  label: "Effects",
                  child: ListView.builder(
                    itemCount: effects.length,
                    itemBuilder: (context, index) {
                      var effect = effects[index];

                      return ListTile(
                        title: Text(effect.name),
                        onTap: () => setState(() => this.effect = effect),
                        selected: effect == this.effect,
                      );
                    },
                  ),
                  actions: [PanelAction(label: "Add Effect")],
                ),
              ),
              if (effect != null)
                Expanded(child: EffectEditor(effect: effect!))
            ],
          );
        });
  }
}

class EffectEditor extends StatelessWidget {
  final Effect effect;

  const EffectEditor({Key? key, required this.effect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrameEditor(effect: effect);
    // return Row(children: [
    //   SizedBox.square(
    //     child: Panel(
    //       label: "Movement Editor",
    //       child: Container(),
    //     ),
    //   ),
    //   Expanded(child: FrameEditor(effect: effect))
    // ]);
  }
}

class FrameEditor extends StatelessWidget {
  final Effect effect;

  const FrameEditor({required this.effect, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Panel(label: "Frames", child: ListView(
      children: effect.channels.map((channel) {
        return Row(children: [
          Text(channel.control.name),
          Expanded(child: CustomPaint(painter: FramePainter(channel), size: Size.fromHeight(64)))
        ]);
      }).toList(growable: false),
    ));
  }
}

class FramePainter extends CustomPainter {
  final EffectChannel channel;

  FramePainter(this.channel);

  @override
  void paint(Canvas canvas, Size size) {
    print("$size");
    Paint linePaint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    Paint fillPaint = Paint()
      ..color = Color(0x11ffffff)
      ..style = PaintingStyle.fill;
    var upperLinePath = Path();
    var lowerLinePath = Path();
    var fillPath = Path();
    double stepSize = size.width / channel.steps.length;
    var backPath = [];
    for (var i = 0; i < channel.steps.length; i++) {
      var step = channel.steps[i];
      var x = i * stepSize;
      double y;
      double y2;
      if (step.value.hasRange()) {
        y = step.value.range.from;
        y2 = step.value.range.to;
      }else {
        y = step.value.direct;
        y2 = y;
      }
      y = (1 - y).abs();
      y2 = (1 - y2).abs();
      y = y * size.height;
      y2 = y2 * size.height;
      if (i == 0) {
        upperLinePath.moveTo(x, y);
        lowerLinePath.moveTo(x, y2);
      }
      if (step.hasCubic()) {
        upperLinePath.cubicTo(step.cubic.c0a, step.cubic.c0b, step.cubic.c1a, step.cubic.c1b, x, y);
        lowerLinePath.cubicTo(step.cubic.c0a, step.cubic.c0b, step.cubic.c1a, step.cubic.c1b, x, y2);
      }else if (step.hasQuadratic()) {
        upperLinePath.quadraticBezierTo(step.quadratic.c0a, step.quadratic.c0b, x, y);
        lowerLinePath.quadraticBezierTo(step.quadratic.c0a, step.quadratic.c0b, x, y2);
      }else {
        upperLinePath.lineTo(x, y);
        lowerLinePath.lineTo(x, y2);
      }
      fillPath.lineTo(x, y);
      backPath.add([x, y2]);
    }
    for (var step in backPath.reversed) {
      fillPath.lineTo(step[0], step[1]);
    }
    canvas.drawPath(upperLinePath, linePaint);
    canvas.drawPath(lowerLinePath, linePaint);
    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant FramePainter oldDelegate) {
    return oldDelegate.channel != channel;
  }
}
