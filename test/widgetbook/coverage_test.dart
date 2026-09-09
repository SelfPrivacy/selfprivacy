import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';
import '../../tool/widgetbook/main.directories.g.dart';

Iterable<WidgetbookNode> descendants(final List<WidgetbookNode> nodes) sync* {
  for (final node in nodes) {
    yield node;
    yield* descendants(node.children ?? []);
  }
}

void main() {
  test('every public concrete component and visual helper is catalogued', () {
    final classes = <ClassDeclaration>[];
    for (final group in [
      'atoms',
      'molecules',
      'organisms',
      'forms',
      'layouts',
    ]) {
      for (final file
          in Directory('lib/ui/$group')
              .listSync(recursive: true)
              .whereType<File>()
              .where((final f) => f.path.endsWith('.dart'))) {
        classes.addAll(
          parseString(
            content: file.readAsStringSync(),
            path: file.path,
          ).unit.declarations.whereType<ClassDeclaration>(),
        );
      }
    }
    final widgetTypes = <String>{'StatelessWidget', 'StatefulWidget'};
    bool changed;
    do {
      changed = false;
      for (final declaration in classes) {
        if (widgetTypes.contains(
          declaration.extendsClause?.superclass.name.lexeme,
        )) {
          changed =
              widgetTypes.add(declaration.namePart.typeName.lexeme) || changed;
        }
      }
    } while (changed);
    final expected =
        classes
            .where(
              (final c) =>
                  c.abstractKeyword == null &&
                  !c.namePart.typeName.lexeme.startsWith('_') &&
                  widgetTypes.contains(c.namePart.typeName.lexeme),
            )
            .map((final c) => c.namePart.typeName.lexeme)
            .toSet()
          ..addAll(['BrandButton', 'BrandLoader', 'BrandIcons', 'Icon']);
    final components = descendants(
      directories,
    ).whereType<WidgetbookComponent>().toList();
    expect(components.map((final c) => c.name).toSet(), expected);
    expect(
      components.length,
      expected.length,
      reason: 'No duplicate component registrations',
    );
    for (final component in components) {
      expect(component.children, isNotEmpty, reason: component.name);
      final names = component.children!.map((final node) => node.name).toList();
      expect(names.toSet().length, names.length, reason: component.name);
    }
  });
  test('Widgetbook telemetry remains disabled', () {
    final config = File('build.yaml').readAsStringSync();
    expect(
      config,
      matches(RegExp(r'widgetbook_generator:telemetry:\s*\n\s+enabled: false')),
    );
  });
}
