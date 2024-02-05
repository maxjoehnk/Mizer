import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/widgets/popup/ast.dart';
import 'package:test/test.dart';

void main() {
  test('push value should add a digit', () {
    ValueAst ast = ValueAst([]);

    ast.push(Value(1));

    expect(ast.build(), equals(CueValue(direct: 0.01)));
  });

  test('pushing value after dot should create fraction', () {
    ValueAst ast = ValueAst([]);

    ast.push(Value.dot());
    ast.push(Value(1));

    expect(ast.build(), equals(CueValue(direct: 0.001)));
  });

  test('pushing zeros after dot should', () {
    ValueAst ast = ValueAst([]);

    ast.push(Value.dot());
    ast.push(Value(0));
    ast.push(Value(1));

    expect(ast.build(), equals(CueValue(direct: 0.0001)));
  });
}
