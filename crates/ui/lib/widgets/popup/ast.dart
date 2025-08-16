import 'package:collection/collection.dart';
import 'package:mizer/api/contracts/sequencer.dart';

class ValueAst {
  List<ValueAstNode> nodes;

  ValueAst(this.nodes);

  String toDisplay() {
    return nodes.map((node) => node.toDisplay()).join(" ");
  }

  void push(ValueAstNode node) {
    if (nodes.isNotEmpty && nodes.last.canJoin(node)) {
      nodes.last.join(node);
    } else {
      nodes.add(node);
    }
  }

  void pop() {
    if (nodes.isEmpty) {
      return;
    }
    var last = nodes.last.pop();
    if (last == null) {
      nodes.removeLast();
    }else {
      nodes.last = last;
    }
  }

  void clear() {
    nodes = [];
  }

  CueValue? build() {
    if (nodes.firstWhereOrNull((node) => node is Thru) != null && nodes.length == 3) {
      var from = nodes[0] as Value;
      var to = nodes[2] as Value;
      return CueValue(range: CueValueRange(from: from.val, to: to.val));
    } else if (nodes.length == 1) {
      var value = nodes[0] as Value;
      return CueValue(direct: value.val);
    }

    return null;
  }
}

abstract class ValueAstNode {
  String toDisplay();

  bool canJoin(ValueAstNode node);

  void join(covariant ValueAstNode node);

  ValueAstNode? pop();
}

class Value implements ValueAstNode {
  int? value;
  String? fractions;
  bool dot;

  Value(this.value, {this.dot = false, this.fractions});

  factory Value.dot() {
    return Value(null, dot: true);
  }

  factory Value.fromDouble(double value) {
    var str = value.toString();
    var parts = str.split(".");
    return Value(int.parse(parts[0]), dot: true, fractions: parts[1]);
  }

  double get val {
    return double.parse(toDisplay());
  }

  @override
  String toDisplay() {
    return "${value ?? ""}${dot ? "." : ""}${fractions ?? ""}";
  }

  @override
  bool canJoin(ValueAstNode node) {
    return node is Value;
  }

  @override
  void join(covariant Value node) {
    if (node.dot) {
      dot = true;
    }
    if (node.value != null) {
      if (dot) {
        fractions = "${fractions ?? ""}${node.value}";
      } else {
        value = int.parse("${value ?? ""}${node.value}").toInt();
      }
    }
  }

  @override
  ValueAstNode? pop() {
    if ((fractions ?? "").isNotEmpty) {
      fractions = fractions!.substring(0, fractions!.length - 1);
      return this;
    }
    if (dot) {
      dot = false;
      return this;
    }
    if (value != null) {
      value = value! ~/ 10;
      return this;
    }
    return null;
  }
}

class Thru implements ValueAstNode {
  @override
  String toDisplay() {
    return "..";
  }

  @override
  bool canJoin(ValueAstNode node) {
    return false;
  }

  @override
  void join(ValueAstNode node) {}

  @override
  ValueAstNode? pop() {
    return null;
  }
}

