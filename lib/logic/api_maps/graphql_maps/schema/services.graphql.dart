import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'schema.graphql.dart';
import 'server_api.graphql.dart';
import 'server_settings.graphql.dart';

class Fragment$BoolConfigItem {
  Fragment$BoolConfigItem({
    required this.fieldId,
    required this.description,
    required this.type,
    required this.boolValue,
    required this.defaultBoolValue,
    required this.widget,
    this.$__typename = 'BoolConfigItem',
  });

  factory Fragment$BoolConfigItem.fromJson(Map<String, dynamic> json) {
    final l$fieldId = json['fieldId'];
    final l$description = json['description'];
    final l$type = json['type'];
    final l$boolValue = json['boolValue'];
    final l$defaultBoolValue = json['defaultBoolValue'];
    final l$widget = json['widget'];
    final l$$__typename = json['__typename'];
    return Fragment$BoolConfigItem(
      fieldId: (l$fieldId as String),
      description: (l$description as String),
      type: (l$type as String),
      boolValue: (l$boolValue as bool),
      defaultBoolValue: (l$defaultBoolValue as bool),
      widget: (l$widget as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String fieldId;

  final String description;

  final String type;

  final bool boolValue;

  final bool defaultBoolValue;

  final String widget;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$fieldId = fieldId;
    _resultData['fieldId'] = l$fieldId;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$type = type;
    _resultData['type'] = l$type;
    final l$boolValue = boolValue;
    _resultData['boolValue'] = l$boolValue;
    final l$defaultBoolValue = defaultBoolValue;
    _resultData['defaultBoolValue'] = l$defaultBoolValue;
    final l$widget = widget;
    _resultData['widget'] = l$widget;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$fieldId = fieldId;
    final l$description = description;
    final l$type = type;
    final l$boolValue = boolValue;
    final l$defaultBoolValue = defaultBoolValue;
    final l$widget = widget;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$fieldId,
      l$description,
      l$type,
      l$boolValue,
      l$defaultBoolValue,
      l$widget,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$BoolConfigItem || runtimeType != other.runtimeType) {
      return false;
    }
    final l$fieldId = fieldId;
    final lOther$fieldId = other.fieldId;
    if (l$fieldId != lOther$fieldId) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
      return false;
    }
    final l$boolValue = boolValue;
    final lOther$boolValue = other.boolValue;
    if (l$boolValue != lOther$boolValue) {
      return false;
    }
    final l$defaultBoolValue = defaultBoolValue;
    final lOther$defaultBoolValue = other.defaultBoolValue;
    if (l$defaultBoolValue != lOther$defaultBoolValue) {
      return false;
    }
    final l$widget = widget;
    final lOther$widget = other.widget;
    if (l$widget != lOther$widget) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$BoolConfigItem on Fragment$BoolConfigItem {
  CopyWith$Fragment$BoolConfigItem<Fragment$BoolConfigItem> get copyWith =>
      CopyWith$Fragment$BoolConfigItem(this, (i) => i);
}

abstract class CopyWith$Fragment$BoolConfigItem<TRes> {
  factory CopyWith$Fragment$BoolConfigItem(
    Fragment$BoolConfigItem instance,
    TRes Function(Fragment$BoolConfigItem) then,
  ) = _CopyWithImpl$Fragment$BoolConfigItem;

  factory CopyWith$Fragment$BoolConfigItem.stub(TRes res) =
      _CopyWithStubImpl$Fragment$BoolConfigItem;

  TRes call({
    String? fieldId,
    String? description,
    String? type,
    bool? boolValue,
    bool? defaultBoolValue,
    String? widget,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$BoolConfigItem<TRes>
    implements CopyWith$Fragment$BoolConfigItem<TRes> {
  _CopyWithImpl$Fragment$BoolConfigItem(this._instance, this._then);

  final Fragment$BoolConfigItem _instance;

  final TRes Function(Fragment$BoolConfigItem) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? fieldId = _undefined,
    Object? description = _undefined,
    Object? type = _undefined,
    Object? boolValue = _undefined,
    Object? defaultBoolValue = _undefined,
    Object? widget = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$BoolConfigItem(
      fieldId:
          fieldId == _undefined || fieldId == null
              ? _instance.fieldId
              : (fieldId as String),
      description:
          description == _undefined || description == null
              ? _instance.description
              : (description as String),
      type:
          type == _undefined || type == null
              ? _instance.type
              : (type as String),
      boolValue:
          boolValue == _undefined || boolValue == null
              ? _instance.boolValue
              : (boolValue as bool),
      defaultBoolValue:
          defaultBoolValue == _undefined || defaultBoolValue == null
              ? _instance.defaultBoolValue
              : (defaultBoolValue as bool),
      widget:
          widget == _undefined || widget == null
              ? _instance.widget
              : (widget as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$BoolConfigItem<TRes>
    implements CopyWith$Fragment$BoolConfigItem<TRes> {
  _CopyWithStubImpl$Fragment$BoolConfigItem(this._res);

  TRes _res;

  call({
    String? fieldId,
    String? description,
    String? type,
    bool? boolValue,
    bool? defaultBoolValue,
    String? widget,
    String? $__typename,
  }) => _res;
}

const fragmentDefinitionBoolConfigItem = FragmentDefinitionNode(
  name: NameNode(value: 'BoolConfigItem'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(
      name: NameNode(value: 'BoolConfigItem'),
      isNonNull: false,
    ),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'fieldId'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'description'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'type'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'value'),
        alias: NameNode(value: 'boolValue'),
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'defaultValue'),
        alias: NameNode(value: 'defaultBoolValue'),
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'widget'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentBoolConfigItem = DocumentNode(
  definitions: [fragmentDefinitionBoolConfigItem],
);

extension ClientExtension$Fragment$BoolConfigItem on graphql.GraphQLClient {
  void writeFragment$BoolConfigItem({
    required Fragment$BoolConfigItem data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'BoolConfigItem',
        document: documentNodeFragmentBoolConfigItem,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Fragment$BoolConfigItem? readFragment$BoolConfigItem({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'BoolConfigItem',
          document: documentNodeFragmentBoolConfigItem,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$BoolConfigItem.fromJson(result);
  }
}

class Fragment$EnumConfigItem {
  Fragment$EnumConfigItem({
    required this.fieldId,
    required this.description,
    required this.type,
    required this.stringValue,
    required this.defaultStringValue,
    required this.options,
    required this.widget,
    this.$__typename = 'EnumConfigItem',
  });

  factory Fragment$EnumConfigItem.fromJson(Map<String, dynamic> json) {
    final l$fieldId = json['fieldId'];
    final l$description = json['description'];
    final l$type = json['type'];
    final l$stringValue = json['stringValue'];
    final l$defaultStringValue = json['defaultStringValue'];
    final l$options = json['options'];
    final l$widget = json['widget'];
    final l$$__typename = json['__typename'];
    return Fragment$EnumConfigItem(
      fieldId: (l$fieldId as String),
      description: (l$description as String),
      type: (l$type as String),
      stringValue: (l$stringValue as String),
      defaultStringValue: (l$defaultStringValue as String),
      options: (l$options as List<dynamic>).map((e) => (e as String)).toList(),
      widget: (l$widget as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String fieldId;

  final String description;

  final String type;

  final String stringValue;

  final String defaultStringValue;

  final List<String> options;

  final String widget;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$fieldId = fieldId;
    _resultData['fieldId'] = l$fieldId;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$type = type;
    _resultData['type'] = l$type;
    final l$stringValue = stringValue;
    _resultData['stringValue'] = l$stringValue;
    final l$defaultStringValue = defaultStringValue;
    _resultData['defaultStringValue'] = l$defaultStringValue;
    final l$options = options;
    _resultData['options'] = l$options.map((e) => e).toList();
    final l$widget = widget;
    _resultData['widget'] = l$widget;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$fieldId = fieldId;
    final l$description = description;
    final l$type = type;
    final l$stringValue = stringValue;
    final l$defaultStringValue = defaultStringValue;
    final l$options = options;
    final l$widget = widget;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$fieldId,
      l$description,
      l$type,
      l$stringValue,
      l$defaultStringValue,
      Object.hashAll(l$options.map((v) => v)),
      l$widget,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$EnumConfigItem || runtimeType != other.runtimeType) {
      return false;
    }
    final l$fieldId = fieldId;
    final lOther$fieldId = other.fieldId;
    if (l$fieldId != lOther$fieldId) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
      return false;
    }
    final l$stringValue = stringValue;
    final lOther$stringValue = other.stringValue;
    if (l$stringValue != lOther$stringValue) {
      return false;
    }
    final l$defaultStringValue = defaultStringValue;
    final lOther$defaultStringValue = other.defaultStringValue;
    if (l$defaultStringValue != lOther$defaultStringValue) {
      return false;
    }
    final l$options = options;
    final lOther$options = other.options;
    if (l$options.length != lOther$options.length) {
      return false;
    }
    for (int i = 0; i < l$options.length; i++) {
      final l$options$entry = l$options[i];
      final lOther$options$entry = lOther$options[i];
      if (l$options$entry != lOther$options$entry) {
        return false;
      }
    }
    final l$widget = widget;
    final lOther$widget = other.widget;
    if (l$widget != lOther$widget) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$EnumConfigItem on Fragment$EnumConfigItem {
  CopyWith$Fragment$EnumConfigItem<Fragment$EnumConfigItem> get copyWith =>
      CopyWith$Fragment$EnumConfigItem(this, (i) => i);
}

abstract class CopyWith$Fragment$EnumConfigItem<TRes> {
  factory CopyWith$Fragment$EnumConfigItem(
    Fragment$EnumConfigItem instance,
    TRes Function(Fragment$EnumConfigItem) then,
  ) = _CopyWithImpl$Fragment$EnumConfigItem;

  factory CopyWith$Fragment$EnumConfigItem.stub(TRes res) =
      _CopyWithStubImpl$Fragment$EnumConfigItem;

  TRes call({
    String? fieldId,
    String? description,
    String? type,
    String? stringValue,
    String? defaultStringValue,
    List<String>? options,
    String? widget,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$EnumConfigItem<TRes>
    implements CopyWith$Fragment$EnumConfigItem<TRes> {
  _CopyWithImpl$Fragment$EnumConfigItem(this._instance, this._then);

  final Fragment$EnumConfigItem _instance;

  final TRes Function(Fragment$EnumConfigItem) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? fieldId = _undefined,
    Object? description = _undefined,
    Object? type = _undefined,
    Object? stringValue = _undefined,
    Object? defaultStringValue = _undefined,
    Object? options = _undefined,
    Object? widget = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$EnumConfigItem(
      fieldId:
          fieldId == _undefined || fieldId == null
              ? _instance.fieldId
              : (fieldId as String),
      description:
          description == _undefined || description == null
              ? _instance.description
              : (description as String),
      type:
          type == _undefined || type == null
              ? _instance.type
              : (type as String),
      stringValue:
          stringValue == _undefined || stringValue == null
              ? _instance.stringValue
              : (stringValue as String),
      defaultStringValue:
          defaultStringValue == _undefined || defaultStringValue == null
              ? _instance.defaultStringValue
              : (defaultStringValue as String),
      options:
          options == _undefined || options == null
              ? _instance.options
              : (options as List<String>),
      widget:
          widget == _undefined || widget == null
              ? _instance.widget
              : (widget as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$EnumConfigItem<TRes>
    implements CopyWith$Fragment$EnumConfigItem<TRes> {
  _CopyWithStubImpl$Fragment$EnumConfigItem(this._res);

  TRes _res;

  call({
    String? fieldId,
    String? description,
    String? type,
    String? stringValue,
    String? defaultStringValue,
    List<String>? options,
    String? widget,
    String? $__typename,
  }) => _res;
}

const fragmentDefinitionEnumConfigItem = FragmentDefinitionNode(
  name: NameNode(value: 'EnumConfigItem'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(
      name: NameNode(value: 'EnumConfigItem'),
      isNonNull: false,
    ),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'fieldId'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'description'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'type'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'value'),
        alias: NameNode(value: 'stringValue'),
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'defaultValue'),
        alias: NameNode(value: 'defaultStringValue'),
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'options'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'widget'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentEnumConfigItem = DocumentNode(
  definitions: [fragmentDefinitionEnumConfigItem],
);

extension ClientExtension$Fragment$EnumConfigItem on graphql.GraphQLClient {
  void writeFragment$EnumConfigItem({
    required Fragment$EnumConfigItem data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'EnumConfigItem',
        document: documentNodeFragmentEnumConfigItem,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Fragment$EnumConfigItem? readFragment$EnumConfigItem({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'EnumConfigItem',
          document: documentNodeFragmentEnumConfigItem,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$EnumConfigItem.fromJson(result);
  }
}

class Fragment$StringConfigItem {
  Fragment$StringConfigItem({
    required this.fieldId,
    required this.description,
    required this.type,
    required this.stringValue,
    required this.defaultStringValue,
    this.regex,
    required this.widget,
    this.$__typename = 'StringConfigItem',
  });

  factory Fragment$StringConfigItem.fromJson(Map<String, dynamic> json) {
    final l$fieldId = json['fieldId'];
    final l$description = json['description'];
    final l$type = json['type'];
    final l$stringValue = json['stringValue'];
    final l$defaultStringValue = json['defaultStringValue'];
    final l$regex = json['regex'];
    final l$widget = json['widget'];
    final l$$__typename = json['__typename'];
    return Fragment$StringConfigItem(
      fieldId: (l$fieldId as String),
      description: (l$description as String),
      type: (l$type as String),
      stringValue: (l$stringValue as String),
      defaultStringValue: (l$defaultStringValue as String),
      regex: (l$regex as String?),
      widget: (l$widget as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String fieldId;

  final String description;

  final String type;

  final String stringValue;

  final String defaultStringValue;

  final String? regex;

  final String widget;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$fieldId = fieldId;
    _resultData['fieldId'] = l$fieldId;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$type = type;
    _resultData['type'] = l$type;
    final l$stringValue = stringValue;
    _resultData['stringValue'] = l$stringValue;
    final l$defaultStringValue = defaultStringValue;
    _resultData['defaultStringValue'] = l$defaultStringValue;
    final l$regex = regex;
    _resultData['regex'] = l$regex;
    final l$widget = widget;
    _resultData['widget'] = l$widget;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$fieldId = fieldId;
    final l$description = description;
    final l$type = type;
    final l$stringValue = stringValue;
    final l$defaultStringValue = defaultStringValue;
    final l$regex = regex;
    final l$widget = widget;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$fieldId,
      l$description,
      l$type,
      l$stringValue,
      l$defaultStringValue,
      l$regex,
      l$widget,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$StringConfigItem ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$fieldId = fieldId;
    final lOther$fieldId = other.fieldId;
    if (l$fieldId != lOther$fieldId) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
      return false;
    }
    final l$stringValue = stringValue;
    final lOther$stringValue = other.stringValue;
    if (l$stringValue != lOther$stringValue) {
      return false;
    }
    final l$defaultStringValue = defaultStringValue;
    final lOther$defaultStringValue = other.defaultStringValue;
    if (l$defaultStringValue != lOther$defaultStringValue) {
      return false;
    }
    final l$regex = regex;
    final lOther$regex = other.regex;
    if (l$regex != lOther$regex) {
      return false;
    }
    final l$widget = widget;
    final lOther$widget = other.widget;
    if (l$widget != lOther$widget) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$StringConfigItem
    on Fragment$StringConfigItem {
  CopyWith$Fragment$StringConfigItem<Fragment$StringConfigItem> get copyWith =>
      CopyWith$Fragment$StringConfigItem(this, (i) => i);
}

abstract class CopyWith$Fragment$StringConfigItem<TRes> {
  factory CopyWith$Fragment$StringConfigItem(
    Fragment$StringConfigItem instance,
    TRes Function(Fragment$StringConfigItem) then,
  ) = _CopyWithImpl$Fragment$StringConfigItem;

  factory CopyWith$Fragment$StringConfigItem.stub(TRes res) =
      _CopyWithStubImpl$Fragment$StringConfigItem;

  TRes call({
    String? fieldId,
    String? description,
    String? type,
    String? stringValue,
    String? defaultStringValue,
    String? regex,
    String? widget,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$StringConfigItem<TRes>
    implements CopyWith$Fragment$StringConfigItem<TRes> {
  _CopyWithImpl$Fragment$StringConfigItem(this._instance, this._then);

  final Fragment$StringConfigItem _instance;

  final TRes Function(Fragment$StringConfigItem) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? fieldId = _undefined,
    Object? description = _undefined,
    Object? type = _undefined,
    Object? stringValue = _undefined,
    Object? defaultStringValue = _undefined,
    Object? regex = _undefined,
    Object? widget = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$StringConfigItem(
      fieldId:
          fieldId == _undefined || fieldId == null
              ? _instance.fieldId
              : (fieldId as String),
      description:
          description == _undefined || description == null
              ? _instance.description
              : (description as String),
      type:
          type == _undefined || type == null
              ? _instance.type
              : (type as String),
      stringValue:
          stringValue == _undefined || stringValue == null
              ? _instance.stringValue
              : (stringValue as String),
      defaultStringValue:
          defaultStringValue == _undefined || defaultStringValue == null
              ? _instance.defaultStringValue
              : (defaultStringValue as String),
      regex: regex == _undefined ? _instance.regex : (regex as String?),
      widget:
          widget == _undefined || widget == null
              ? _instance.widget
              : (widget as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Fragment$StringConfigItem<TRes>
    implements CopyWith$Fragment$StringConfigItem<TRes> {
  _CopyWithStubImpl$Fragment$StringConfigItem(this._res);

  TRes _res;

  call({
    String? fieldId,
    String? description,
    String? type,
    String? stringValue,
    String? defaultStringValue,
    String? regex,
    String? widget,
    String? $__typename,
  }) => _res;
}

const fragmentDefinitionStringConfigItem = FragmentDefinitionNode(
  name: NameNode(value: 'StringConfigItem'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(
      name: NameNode(value: 'StringConfigItem'),
      isNonNull: false,
    ),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'fieldId'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'description'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'type'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'value'),
        alias: NameNode(value: 'stringValue'),
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'defaultValue'),
        alias: NameNode(value: 'defaultStringValue'),
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'regex'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'widget'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentStringConfigItem = DocumentNode(
  definitions: [fragmentDefinitionStringConfigItem],
);

extension ClientExtension$Fragment$StringConfigItem on graphql.GraphQLClient {
  void writeFragment$StringConfigItem({
    required Fragment$StringConfigItem data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'StringConfigItem',
        document: documentNodeFragmentStringConfigItem,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Fragment$StringConfigItem? readFragment$StringConfigItem({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'StringConfigItem',
          document: documentNodeFragmentStringConfigItem,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$StringConfigItem.fromJson(result);
  }
}

class Query$AllServices {
  Query$AllServices({required this.services, this.$__typename = 'Query'});

  factory Query$AllServices.fromJson(Map<String, dynamic> json) {
    final l$services = json['services'];
    final l$$__typename = json['__typename'];
    return Query$AllServices(
      services: Query$AllServices$services.fromJson(
        (l$services as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$AllServices$services services;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$services = services;
    _resultData['services'] = l$services.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$services = services;
    final l$$__typename = $__typename;
    return Object.hashAll([l$services, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$AllServices || runtimeType != other.runtimeType) {
      return false;
    }
    final l$services = services;
    final lOther$services = other.services;
    if (l$services != lOther$services) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$AllServices on Query$AllServices {
  CopyWith$Query$AllServices<Query$AllServices> get copyWith =>
      CopyWith$Query$AllServices(this, (i) => i);
}

abstract class CopyWith$Query$AllServices<TRes> {
  factory CopyWith$Query$AllServices(
    Query$AllServices instance,
    TRes Function(Query$AllServices) then,
  ) = _CopyWithImpl$Query$AllServices;

  factory CopyWith$Query$AllServices.stub(TRes res) =
      _CopyWithStubImpl$Query$AllServices;

  TRes call({Query$AllServices$services? services, String? $__typename});
  CopyWith$Query$AllServices$services<TRes> get services;
}

class _CopyWithImpl$Query$AllServices<TRes>
    implements CopyWith$Query$AllServices<TRes> {
  _CopyWithImpl$Query$AllServices(this._instance, this._then);

  final Query$AllServices _instance;

  final TRes Function(Query$AllServices) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? services = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$AllServices(
      services:
          services == _undefined || services == null
              ? _instance.services
              : (services as Query$AllServices$services),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$AllServices$services<TRes> get services {
    final local$services = _instance.services;
    return CopyWith$Query$AllServices$services(
      local$services,
      (e) => call(services: e),
    );
  }
}

class _CopyWithStubImpl$Query$AllServices<TRes>
    implements CopyWith$Query$AllServices<TRes> {
  _CopyWithStubImpl$Query$AllServices(this._res);

  TRes _res;

  call({Query$AllServices$services? services, String? $__typename}) => _res;

  CopyWith$Query$AllServices$services<TRes> get services =>
      CopyWith$Query$AllServices$services.stub(_res);
}

const documentNodeQueryAllServices = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'AllServices'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'services'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'allServices'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'description'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'displayName'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'dnsRecords'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FragmentSpreadNode(
                              name: NameNode(value: 'fragmentDnsRecords'),
                              directives: [],
                            ),
                            FieldNode(
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'isEnabled'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'isInstalled'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'isMovable'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'isRequired'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'isSystemService'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'canBeBackedUp'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'backupDescription'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'status'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'storageUsage'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FieldNode(
                              name: NameNode(value: 'title'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'usedSpace'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'volume'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(
                                selections: [
                                  FieldNode(
                                    name: NameNode(value: 'name'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null,
                                  ),
                                  FieldNode(
                                    name: NameNode(value: '__typename'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null,
                                  ),
                                ],
                              ),
                            ),
                            FieldNode(
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: 'svgIcon'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'url'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'homepage'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'sourcePage'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'license'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FieldNode(
                              name: NameNode(value: 'free'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'fullName'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'redistributable'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'shortName'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'url'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: 'supportLevel'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'configuration'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FieldNode(
                              name: NameNode(value: 'fieldId'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'description'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'type'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FragmentSpreadNode(
                              name: NameNode(value: 'BoolConfigItem'),
                              directives: [],
                            ),
                            FragmentSpreadNode(
                              name: NameNode(value: 'EnumConfigItem'),
                              directives: [],
                            ),
                            FragmentSpreadNode(
                              name: NameNode(value: 'StringConfigItem'),
                              directives: [],
                            ),
                            FieldNode(
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionfragmentDnsRecords,
    fragmentDefinitionBoolConfigItem,
    fragmentDefinitionEnumConfigItem,
    fragmentDefinitionStringConfigItem,
  ],
);
Query$AllServices _parserFn$Query$AllServices(Map<String, dynamic> data) =>
    Query$AllServices.fromJson(data);
typedef OnQueryComplete$Query$AllServices =
    FutureOr<void> Function(Map<String, dynamic>?, Query$AllServices?);

class Options$Query$AllServices
    extends graphql.QueryOptions<Query$AllServices> {
  Options$Query$AllServices({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$AllServices? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$AllServices? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete:
             onComplete == null
                 ? null
                 : (data) => onComplete(
                   data,
                   data == null ? null : _parserFn$Query$AllServices(data),
                 ),
         onError: onError,
         document: documentNodeQueryAllServices,
         parserFn: _parserFn$Query$AllServices,
       );

  final OnQueryComplete$Query$AllServices? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$AllServices
    extends graphql.WatchQueryOptions<Query$AllServices> {
  WatchOptions$Query$AllServices({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$AllServices? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryAllServices,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$AllServices,
       );
}

class FetchMoreOptions$Query$AllServices extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$AllServices({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryAllServices);
}

extension ClientExtension$Query$AllServices on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$AllServices>> query$AllServices([
    Options$Query$AllServices? options,
  ]) async => await this.query(options ?? Options$Query$AllServices());
  graphql.ObservableQuery<Query$AllServices> watchQuery$AllServices([
    WatchOptions$Query$AllServices? options,
  ]) => this.watchQuery(options ?? WatchOptions$Query$AllServices());
  void writeQuery$AllServices({
    required Query$AllServices data,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryAllServices),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );
  Query$AllServices? readQuery$AllServices({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryAllServices),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$AllServices.fromJson(result);
  }
}

class Query$AllServices$services {
  Query$AllServices$services({
    required this.allServices,
    this.$__typename = 'Services',
  });

  factory Query$AllServices$services.fromJson(Map<String, dynamic> json) {
    final l$allServices = json['allServices'];
    final l$$__typename = json['__typename'];
    return Query$AllServices$services(
      allServices:
          (l$allServices as List<dynamic>)
              .map(
                (e) => Query$AllServices$services$allServices.fromJson(
                  (e as Map<String, dynamic>),
                ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$AllServices$services$allServices> allServices;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$allServices = allServices;
    _resultData['allServices'] = l$allServices.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$allServices = allServices;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$allServices.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$AllServices$services ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$allServices = allServices;
    final lOther$allServices = other.allServices;
    if (l$allServices.length != lOther$allServices.length) {
      return false;
    }
    for (int i = 0; i < l$allServices.length; i++) {
      final l$allServices$entry = l$allServices[i];
      final lOther$allServices$entry = lOther$allServices[i];
      if (l$allServices$entry != lOther$allServices$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$AllServices$services
    on Query$AllServices$services {
  CopyWith$Query$AllServices$services<Query$AllServices$services>
  get copyWith => CopyWith$Query$AllServices$services(this, (i) => i);
}

abstract class CopyWith$Query$AllServices$services<TRes> {
  factory CopyWith$Query$AllServices$services(
    Query$AllServices$services instance,
    TRes Function(Query$AllServices$services) then,
  ) = _CopyWithImpl$Query$AllServices$services;

  factory CopyWith$Query$AllServices$services.stub(TRes res) =
      _CopyWithStubImpl$Query$AllServices$services;

  TRes call({
    List<Query$AllServices$services$allServices>? allServices,
    String? $__typename,
  });
  TRes allServices(
    Iterable<Query$AllServices$services$allServices> Function(
      Iterable<
        CopyWith$Query$AllServices$services$allServices<
          Query$AllServices$services$allServices
        >
      >,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$AllServices$services<TRes>
    implements CopyWith$Query$AllServices$services<TRes> {
  _CopyWithImpl$Query$AllServices$services(this._instance, this._then);

  final Query$AllServices$services _instance;

  final TRes Function(Query$AllServices$services) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? allServices = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$AllServices$services(
      allServices:
          allServices == _undefined || allServices == null
              ? _instance.allServices
              : (allServices as List<Query$AllServices$services$allServices>),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes allServices(
    Iterable<Query$AllServices$services$allServices> Function(
      Iterable<
        CopyWith$Query$AllServices$services$allServices<
          Query$AllServices$services$allServices
        >
      >,
    )
    _fn,
  ) => call(
    allServices:
        _fn(
          _instance.allServices.map(
            (e) => CopyWith$Query$AllServices$services$allServices(e, (i) => i),
          ),
        ).toList(),
  );
}

class _CopyWithStubImpl$Query$AllServices$services<TRes>
    implements CopyWith$Query$AllServices$services<TRes> {
  _CopyWithStubImpl$Query$AllServices$services(this._res);

  TRes _res;

  call({
    List<Query$AllServices$services$allServices>? allServices,
    String? $__typename,
  }) => _res;

  allServices(_fn) => _res;
}

class Query$AllServices$services$allServices {
  Query$AllServices$services$allServices({
    required this.description,
    required this.displayName,
    this.dnsRecords,
    required this.id,
    required this.isEnabled,
    required this.isInstalled,
    required this.isMovable,
    required this.isRequired,
    required this.isSystemService,
    required this.canBeBackedUp,
    required this.backupDescription,
    required this.status,
    required this.storageUsage,
    required this.svgIcon,
    this.url,
    this.homepage,
    this.sourcePage,
    required this.license,
    required this.supportLevel,
    this.configuration,
    this.$__typename = 'Service',
  });

  factory Query$AllServices$services$allServices.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$description = json['description'];
    final l$displayName = json['displayName'];
    final l$dnsRecords = json['dnsRecords'];
    final l$id = json['id'];
    final l$isEnabled = json['isEnabled'];
    final l$isInstalled = json['isInstalled'];
    final l$isMovable = json['isMovable'];
    final l$isRequired = json['isRequired'];
    final l$isSystemService = json['isSystemService'];
    final l$canBeBackedUp = json['canBeBackedUp'];
    final l$backupDescription = json['backupDescription'];
    final l$status = json['status'];
    final l$storageUsage = json['storageUsage'];
    final l$svgIcon = json['svgIcon'];
    final l$url = json['url'];
    final l$homepage = json['homepage'];
    final l$sourcePage = json['sourcePage'];
    final l$license = json['license'];
    final l$supportLevel = json['supportLevel'];
    final l$configuration = json['configuration'];
    final l$$__typename = json['__typename'];
    return Query$AllServices$services$allServices(
      description: (l$description as String),
      displayName: (l$displayName as String),
      dnsRecords:
          (l$dnsRecords as List<dynamic>?)
              ?.map(
                (e) => Fragment$fragmentDnsRecords.fromJson(
                  (e as Map<String, dynamic>),
                ),
              )
              .toList(),
      id: (l$id as String),
      isEnabled: (l$isEnabled as bool),
      isInstalled: (l$isInstalled as bool),
      isMovable: (l$isMovable as bool),
      isRequired: (l$isRequired as bool),
      isSystemService: (l$isSystemService as bool),
      canBeBackedUp: (l$canBeBackedUp as bool),
      backupDescription: (l$backupDescription as String),
      status: fromJson$Enum$ServiceStatusEnum((l$status as String)),
      storageUsage:
          Query$AllServices$services$allServices$storageUsage.fromJson(
            (l$storageUsage as Map<String, dynamic>),
          ),
      svgIcon: (l$svgIcon as String),
      url: (l$url as String?),
      homepage: (l$homepage as String?),
      sourcePage: (l$sourcePage as String?),
      license:
          (l$license as List<dynamic>)
              .map(
                (e) => Query$AllServices$services$allServices$license.fromJson(
                  (e as Map<String, dynamic>),
                ),
              )
              .toList(),
      supportLevel: fromJson$Enum$SupportLevelEnum((l$supportLevel as String)),
      configuration:
          (l$configuration as List<dynamic>?)
              ?.map(
                (e) =>
                    Query$AllServices$services$allServices$configuration.fromJson(
                      (e as Map<String, dynamic>),
                    ),
              )
              .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String description;

  final String displayName;

  final List<Fragment$fragmentDnsRecords>? dnsRecords;

  final String id;

  final bool isEnabled;

  final bool isInstalled;

  final bool isMovable;

  final bool isRequired;

  final bool isSystemService;

  final bool canBeBackedUp;

  final String backupDescription;

  final Enum$ServiceStatusEnum status;

  final Query$AllServices$services$allServices$storageUsage storageUsage;

  final String svgIcon;

  final String? url;

  final String? homepage;

  final String? sourcePage;

  final List<Query$AllServices$services$allServices$license> license;

  final Enum$SupportLevelEnum supportLevel;

  final List<Query$AllServices$services$allServices$configuration>?
  configuration;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$description = description;
    _resultData['description'] = l$description;
    final l$displayName = displayName;
    _resultData['displayName'] = l$displayName;
    final l$dnsRecords = dnsRecords;
    _resultData['dnsRecords'] = l$dnsRecords?.map((e) => e.toJson()).toList();
    final l$id = id;
    _resultData['id'] = l$id;
    final l$isEnabled = isEnabled;
    _resultData['isEnabled'] = l$isEnabled;
    final l$isInstalled = isInstalled;
    _resultData['isInstalled'] = l$isInstalled;
    final l$isMovable = isMovable;
    _resultData['isMovable'] = l$isMovable;
    final l$isRequired = isRequired;
    _resultData['isRequired'] = l$isRequired;
    final l$isSystemService = isSystemService;
    _resultData['isSystemService'] = l$isSystemService;
    final l$canBeBackedUp = canBeBackedUp;
    _resultData['canBeBackedUp'] = l$canBeBackedUp;
    final l$backupDescription = backupDescription;
    _resultData['backupDescription'] = l$backupDescription;
    final l$status = status;
    _resultData['status'] = toJson$Enum$ServiceStatusEnum(l$status);
    final l$storageUsage = storageUsage;
    _resultData['storageUsage'] = l$storageUsage.toJson();
    final l$svgIcon = svgIcon;
    _resultData['svgIcon'] = l$svgIcon;
    final l$url = url;
    _resultData['url'] = l$url;
    final l$homepage = homepage;
    _resultData['homepage'] = l$homepage;
    final l$sourcePage = sourcePage;
    _resultData['sourcePage'] = l$sourcePage;
    final l$license = license;
    _resultData['license'] = l$license.map((e) => e.toJson()).toList();
    final l$supportLevel = supportLevel;
    _resultData['supportLevel'] = toJson$Enum$SupportLevelEnum(l$supportLevel);
    final l$configuration = configuration;
    _resultData['configuration'] =
        l$configuration?.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$description = description;
    final l$displayName = displayName;
    final l$dnsRecords = dnsRecords;
    final l$id = id;
    final l$isEnabled = isEnabled;
    final l$isInstalled = isInstalled;
    final l$isMovable = isMovable;
    final l$isRequired = isRequired;
    final l$isSystemService = isSystemService;
    final l$canBeBackedUp = canBeBackedUp;
    final l$backupDescription = backupDescription;
    final l$status = status;
    final l$storageUsage = storageUsage;
    final l$svgIcon = svgIcon;
    final l$url = url;
    final l$homepage = homepage;
    final l$sourcePage = sourcePage;
    final l$license = license;
    final l$supportLevel = supportLevel;
    final l$configuration = configuration;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$description,
      l$displayName,
      l$dnsRecords == null ? null : Object.hashAll(l$dnsRecords.map((v) => v)),
      l$id,
      l$isEnabled,
      l$isInstalled,
      l$isMovable,
      l$isRequired,
      l$isSystemService,
      l$canBeBackedUp,
      l$backupDescription,
      l$status,
      l$storageUsage,
      l$svgIcon,
      l$url,
      l$homepage,
      l$sourcePage,
      Object.hashAll(l$license.map((v) => v)),
      l$supportLevel,
      l$configuration == null
          ? null
          : Object.hashAll(l$configuration.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$AllServices$services$allServices ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) {
      return false;
    }
    final l$dnsRecords = dnsRecords;
    final lOther$dnsRecords = other.dnsRecords;
    if (l$dnsRecords != null && lOther$dnsRecords != null) {
      if (l$dnsRecords.length != lOther$dnsRecords.length) {
        return false;
      }
      for (int i = 0; i < l$dnsRecords.length; i++) {
        final l$dnsRecords$entry = l$dnsRecords[i];
        final lOther$dnsRecords$entry = lOther$dnsRecords[i];
        if (l$dnsRecords$entry != lOther$dnsRecords$entry) {
          return false;
        }
      }
    } else if (l$dnsRecords != lOther$dnsRecords) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$isEnabled = isEnabled;
    final lOther$isEnabled = other.isEnabled;
    if (l$isEnabled != lOther$isEnabled) {
      return false;
    }
    final l$isInstalled = isInstalled;
    final lOther$isInstalled = other.isInstalled;
    if (l$isInstalled != lOther$isInstalled) {
      return false;
    }
    final l$isMovable = isMovable;
    final lOther$isMovable = other.isMovable;
    if (l$isMovable != lOther$isMovable) {
      return false;
    }
    final l$isRequired = isRequired;
    final lOther$isRequired = other.isRequired;
    if (l$isRequired != lOther$isRequired) {
      return false;
    }
    final l$isSystemService = isSystemService;
    final lOther$isSystemService = other.isSystemService;
    if (l$isSystemService != lOther$isSystemService) {
      return false;
    }
    final l$canBeBackedUp = canBeBackedUp;
    final lOther$canBeBackedUp = other.canBeBackedUp;
    if (l$canBeBackedUp != lOther$canBeBackedUp) {
      return false;
    }
    final l$backupDescription = backupDescription;
    final lOther$backupDescription = other.backupDescription;
    if (l$backupDescription != lOther$backupDescription) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$storageUsage = storageUsage;
    final lOther$storageUsage = other.storageUsage;
    if (l$storageUsage != lOther$storageUsage) {
      return false;
    }
    final l$svgIcon = svgIcon;
    final lOther$svgIcon = other.svgIcon;
    if (l$svgIcon != lOther$svgIcon) {
      return false;
    }
    final l$url = url;
    final lOther$url = other.url;
    if (l$url != lOther$url) {
      return false;
    }
    final l$homepage = homepage;
    final lOther$homepage = other.homepage;
    if (l$homepage != lOther$homepage) {
      return false;
    }
    final l$sourcePage = sourcePage;
    final lOther$sourcePage = other.sourcePage;
    if (l$sourcePage != lOther$sourcePage) {
      return false;
    }
    final l$license = license;
    final lOther$license = other.license;
    if (l$license.length != lOther$license.length) {
      return false;
    }
    for (int i = 0; i < l$license.length; i++) {
      final l$license$entry = l$license[i];
      final lOther$license$entry = lOther$license[i];
      if (l$license$entry != lOther$license$entry) {
        return false;
      }
    }
    final l$supportLevel = supportLevel;
    final lOther$supportLevel = other.supportLevel;
    if (l$supportLevel != lOther$supportLevel) {
      return false;
    }
    final l$configuration = configuration;
    final lOther$configuration = other.configuration;
    if (l$configuration != null && lOther$configuration != null) {
      if (l$configuration.length != lOther$configuration.length) {
        return false;
      }
      for (int i = 0; i < l$configuration.length; i++) {
        final l$configuration$entry = l$configuration[i];
        final lOther$configuration$entry = lOther$configuration[i];
        if (l$configuration$entry != lOther$configuration$entry) {
          return false;
        }
      }
    } else if (l$configuration != lOther$configuration) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$AllServices$services$allServices
    on Query$AllServices$services$allServices {
  CopyWith$Query$AllServices$services$allServices<
    Query$AllServices$services$allServices
  >
  get copyWith =>
      CopyWith$Query$AllServices$services$allServices(this, (i) => i);
}

abstract class CopyWith$Query$AllServices$services$allServices<TRes> {
  factory CopyWith$Query$AllServices$services$allServices(
    Query$AllServices$services$allServices instance,
    TRes Function(Query$AllServices$services$allServices) then,
  ) = _CopyWithImpl$Query$AllServices$services$allServices;

  factory CopyWith$Query$AllServices$services$allServices.stub(TRes res) =
      _CopyWithStubImpl$Query$AllServices$services$allServices;

  TRes call({
    String? description,
    String? displayName,
    List<Fragment$fragmentDnsRecords>? dnsRecords,
    String? id,
    bool? isEnabled,
    bool? isInstalled,
    bool? isMovable,
    bool? isRequired,
    bool? isSystemService,
    bool? canBeBackedUp,
    String? backupDescription,
    Enum$ServiceStatusEnum? status,
    Query$AllServices$services$allServices$storageUsage? storageUsage,
    String? svgIcon,
    String? url,
    String? homepage,
    String? sourcePage,
    List<Query$AllServices$services$allServices$license>? license,
    Enum$SupportLevelEnum? supportLevel,
    List<Query$AllServices$services$allServices$configuration>? configuration,
    String? $__typename,
  });
  TRes dnsRecords(
    Iterable<Fragment$fragmentDnsRecords>? Function(
      Iterable<
        CopyWith$Fragment$fragmentDnsRecords<Fragment$fragmentDnsRecords>
      >?,
    )
    _fn,
  );
  CopyWith$Query$AllServices$services$allServices$storageUsage<TRes>
  get storageUsage;
  TRes license(
    Iterable<Query$AllServices$services$allServices$license> Function(
      Iterable<
        CopyWith$Query$AllServices$services$allServices$license<
          Query$AllServices$services$allServices$license
        >
      >,
    )
    _fn,
  );
  TRes configuration(
    Iterable<Query$AllServices$services$allServices$configuration>? Function(
      Iterable<
        CopyWith$Query$AllServices$services$allServices$configuration<
          Query$AllServices$services$allServices$configuration
        >
      >?,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$AllServices$services$allServices<TRes>
    implements CopyWith$Query$AllServices$services$allServices<TRes> {
  _CopyWithImpl$Query$AllServices$services$allServices(
    this._instance,
    this._then,
  );

  final Query$AllServices$services$allServices _instance;

  final TRes Function(Query$AllServices$services$allServices) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? description = _undefined,
    Object? displayName = _undefined,
    Object? dnsRecords = _undefined,
    Object? id = _undefined,
    Object? isEnabled = _undefined,
    Object? isInstalled = _undefined,
    Object? isMovable = _undefined,
    Object? isRequired = _undefined,
    Object? isSystemService = _undefined,
    Object? canBeBackedUp = _undefined,
    Object? backupDescription = _undefined,
    Object? status = _undefined,
    Object? storageUsage = _undefined,
    Object? svgIcon = _undefined,
    Object? url = _undefined,
    Object? homepage = _undefined,
    Object? sourcePage = _undefined,
    Object? license = _undefined,
    Object? supportLevel = _undefined,
    Object? configuration = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$AllServices$services$allServices(
      description:
          description == _undefined || description == null
              ? _instance.description
              : (description as String),
      displayName:
          displayName == _undefined || displayName == null
              ? _instance.displayName
              : (displayName as String),
      dnsRecords:
          dnsRecords == _undefined
              ? _instance.dnsRecords
              : (dnsRecords as List<Fragment$fragmentDnsRecords>?),
      id: id == _undefined || id == null ? _instance.id : (id as String),
      isEnabled:
          isEnabled == _undefined || isEnabled == null
              ? _instance.isEnabled
              : (isEnabled as bool),
      isInstalled:
          isInstalled == _undefined || isInstalled == null
              ? _instance.isInstalled
              : (isInstalled as bool),
      isMovable:
          isMovable == _undefined || isMovable == null
              ? _instance.isMovable
              : (isMovable as bool),
      isRequired:
          isRequired == _undefined || isRequired == null
              ? _instance.isRequired
              : (isRequired as bool),
      isSystemService:
          isSystemService == _undefined || isSystemService == null
              ? _instance.isSystemService
              : (isSystemService as bool),
      canBeBackedUp:
          canBeBackedUp == _undefined || canBeBackedUp == null
              ? _instance.canBeBackedUp
              : (canBeBackedUp as bool),
      backupDescription:
          backupDescription == _undefined || backupDescription == null
              ? _instance.backupDescription
              : (backupDescription as String),
      status:
          status == _undefined || status == null
              ? _instance.status
              : (status as Enum$ServiceStatusEnum),
      storageUsage:
          storageUsage == _undefined || storageUsage == null
              ? _instance.storageUsage
              : (storageUsage
                  as Query$AllServices$services$allServices$storageUsage),
      svgIcon:
          svgIcon == _undefined || svgIcon == null
              ? _instance.svgIcon
              : (svgIcon as String),
      url: url == _undefined ? _instance.url : (url as String?),
      homepage:
          homepage == _undefined ? _instance.homepage : (homepage as String?),
      sourcePage:
          sourcePage == _undefined
              ? _instance.sourcePage
              : (sourcePage as String?),
      license:
          license == _undefined || license == null
              ? _instance.license
              : (license
                  as List<Query$AllServices$services$allServices$license>),
      supportLevel:
          supportLevel == _undefined || supportLevel == null
              ? _instance.supportLevel
              : (supportLevel as Enum$SupportLevelEnum),
      configuration:
          configuration == _undefined
              ? _instance.configuration
              : (configuration
                  as List<
                    Query$AllServices$services$allServices$configuration
                  >?),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  TRes dnsRecords(
    Iterable<Fragment$fragmentDnsRecords>? Function(
      Iterable<
        CopyWith$Fragment$fragmentDnsRecords<Fragment$fragmentDnsRecords>
      >?,
    )
    _fn,
  ) => call(
    dnsRecords:
        _fn(
          _instance.dnsRecords?.map(
            (e) => CopyWith$Fragment$fragmentDnsRecords(e, (i) => i),
          ),
        )?.toList(),
  );

  CopyWith$Query$AllServices$services$allServices$storageUsage<TRes>
  get storageUsage {
    final local$storageUsage = _instance.storageUsage;
    return CopyWith$Query$AllServices$services$allServices$storageUsage(
      local$storageUsage,
      (e) => call(storageUsage: e),
    );
  }

  TRes license(
    Iterable<Query$AllServices$services$allServices$license> Function(
      Iterable<
        CopyWith$Query$AllServices$services$allServices$license<
          Query$AllServices$services$allServices$license
        >
      >,
    )
    _fn,
  ) => call(
    license:
        _fn(
          _instance.license.map(
            (e) => CopyWith$Query$AllServices$services$allServices$license(
              e,
              (i) => i,
            ),
          ),
        ).toList(),
  );

  TRes configuration(
    Iterable<Query$AllServices$services$allServices$configuration>? Function(
      Iterable<
        CopyWith$Query$AllServices$services$allServices$configuration<
          Query$AllServices$services$allServices$configuration
        >
      >?,
    )
    _fn,
  ) => call(
    configuration:
        _fn(
          _instance.configuration?.map(
            (e) =>
                CopyWith$Query$AllServices$services$allServices$configuration(
                  e,
                  (i) => i,
                ),
          ),
        )?.toList(),
  );
}

class _CopyWithStubImpl$Query$AllServices$services$allServices<TRes>
    implements CopyWith$Query$AllServices$services$allServices<TRes> {
  _CopyWithStubImpl$Query$AllServices$services$allServices(this._res);

  TRes _res;

  call({
    String? description,
    String? displayName,
    List<Fragment$fragmentDnsRecords>? dnsRecords,
    String? id,
    bool? isEnabled,
    bool? isInstalled,
    bool? isMovable,
    bool? isRequired,
    bool? isSystemService,
    bool? canBeBackedUp,
    String? backupDescription,
    Enum$ServiceStatusEnum? status,
    Query$AllServices$services$allServices$storageUsage? storageUsage,
    String? svgIcon,
    String? url,
    String? homepage,
    String? sourcePage,
    List<Query$AllServices$services$allServices$license>? license,
    Enum$SupportLevelEnum? supportLevel,
    List<Query$AllServices$services$allServices$configuration>? configuration,
    String? $__typename,
  }) => _res;

  dnsRecords(_fn) => _res;

  CopyWith$Query$AllServices$services$allServices$storageUsage<TRes>
  get storageUsage =>
      CopyWith$Query$AllServices$services$allServices$storageUsage.stub(_res);

  license(_fn) => _res;

  configuration(_fn) => _res;
}

class Query$AllServices$services$allServices$storageUsage {
  Query$AllServices$services$allServices$storageUsage({
    required this.title,
    required this.usedSpace,
    this.volume,
    this.$__typename = 'ServiceStorageUsage',
  });

  factory Query$AllServices$services$allServices$storageUsage.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$title = json['title'];
    final l$usedSpace = json['usedSpace'];
    final l$volume = json['volume'];
    final l$$__typename = json['__typename'];
    return Query$AllServices$services$allServices$storageUsage(
      title: (l$title as String),
      usedSpace: (l$usedSpace as String),
      volume:
          l$volume == null
              ? null
              : Query$AllServices$services$allServices$storageUsage$volume.fromJson(
                (l$volume as Map<String, dynamic>),
              ),
      $__typename: (l$$__typename as String),
    );
  }

  final String title;

  final String usedSpace;

  final Query$AllServices$services$allServices$storageUsage$volume? volume;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$title = title;
    _resultData['title'] = l$title;
    final l$usedSpace = usedSpace;
    _resultData['usedSpace'] = l$usedSpace;
    final l$volume = volume;
    _resultData['volume'] = l$volume?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$title = title;
    final l$usedSpace = usedSpace;
    final l$volume = volume;
    final l$$__typename = $__typename;
    return Object.hashAll([l$title, l$usedSpace, l$volume, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$AllServices$services$allServices$storageUsage ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$usedSpace = usedSpace;
    final lOther$usedSpace = other.usedSpace;
    if (l$usedSpace != lOther$usedSpace) {
      return false;
    }
    final l$volume = volume;
    final lOther$volume = other.volume;
    if (l$volume != lOther$volume) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$AllServices$services$allServices$storageUsage
    on Query$AllServices$services$allServices$storageUsage {
  CopyWith$Query$AllServices$services$allServices$storageUsage<
    Query$AllServices$services$allServices$storageUsage
  >
  get copyWith => CopyWith$Query$AllServices$services$allServices$storageUsage(
    this,
    (i) => i,
  );
}

abstract class CopyWith$Query$AllServices$services$allServices$storageUsage<
  TRes
> {
  factory CopyWith$Query$AllServices$services$allServices$storageUsage(
    Query$AllServices$services$allServices$storageUsage instance,
    TRes Function(Query$AllServices$services$allServices$storageUsage) then,
  ) = _CopyWithImpl$Query$AllServices$services$allServices$storageUsage;

  factory CopyWith$Query$AllServices$services$allServices$storageUsage.stub(
    TRes res,
  ) = _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage;

  TRes call({
    String? title,
    String? usedSpace,
    Query$AllServices$services$allServices$storageUsage$volume? volume,
    String? $__typename,
  });
  CopyWith$Query$AllServices$services$allServices$storageUsage$volume<TRes>
  get volume;
}

class _CopyWithImpl$Query$AllServices$services$allServices$storageUsage<TRes>
    implements
        CopyWith$Query$AllServices$services$allServices$storageUsage<TRes> {
  _CopyWithImpl$Query$AllServices$services$allServices$storageUsage(
    this._instance,
    this._then,
  );

  final Query$AllServices$services$allServices$storageUsage _instance;

  final TRes Function(Query$AllServices$services$allServices$storageUsage)
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? title = _undefined,
    Object? usedSpace = _undefined,
    Object? volume = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$AllServices$services$allServices$storageUsage(
      title:
          title == _undefined || title == null
              ? _instance.title
              : (title as String),
      usedSpace:
          usedSpace == _undefined || usedSpace == null
              ? _instance.usedSpace
              : (usedSpace as String),
      volume:
          volume == _undefined
              ? _instance.volume
              : (volume
                  as Query$AllServices$services$allServices$storageUsage$volume?),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Query$AllServices$services$allServices$storageUsage$volume<TRes>
  get volume {
    final local$volume = _instance.volume;
    return local$volume == null
        ? CopyWith$Query$AllServices$services$allServices$storageUsage$volume.stub(
          _then(_instance),
        )
        : CopyWith$Query$AllServices$services$allServices$storageUsage$volume(
          local$volume,
          (e) => call(volume: e),
        );
  }
}

class _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage<
  TRes
>
    implements
        CopyWith$Query$AllServices$services$allServices$storageUsage<TRes> {
  _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage(
    this._res,
  );

  TRes _res;

  call({
    String? title,
    String? usedSpace,
    Query$AllServices$services$allServices$storageUsage$volume? volume,
    String? $__typename,
  }) => _res;

  CopyWith$Query$AllServices$services$allServices$storageUsage$volume<TRes>
  get volume =>
      CopyWith$Query$AllServices$services$allServices$storageUsage$volume.stub(
        _res,
      );
}

class Query$AllServices$services$allServices$storageUsage$volume {
  Query$AllServices$services$allServices$storageUsage$volume({
    required this.name,
    this.$__typename = 'StorageVolume',
  });

  factory Query$AllServices$services$allServices$storageUsage$volume.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$name = json['name'];
    final l$$__typename = json['__typename'];
    return Query$AllServices$services$allServices$storageUsage$volume(
      name: (l$name as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String name;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$name = name;
    _resultData['name'] = l$name;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$name = name;
    final l$$__typename = $__typename;
    return Object.hashAll([l$name, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$AllServices$services$allServices$storageUsage$volume ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$AllServices$services$allServices$storageUsage$volume
    on Query$AllServices$services$allServices$storageUsage$volume {
  CopyWith$Query$AllServices$services$allServices$storageUsage$volume<
    Query$AllServices$services$allServices$storageUsage$volume
  >
  get copyWith =>
      CopyWith$Query$AllServices$services$allServices$storageUsage$volume(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$AllServices$services$allServices$storageUsage$volume<
  TRes
> {
  factory CopyWith$Query$AllServices$services$allServices$storageUsage$volume(
    Query$AllServices$services$allServices$storageUsage$volume instance,
    TRes Function(Query$AllServices$services$allServices$storageUsage$volume)
    then,
  ) = _CopyWithImpl$Query$AllServices$services$allServices$storageUsage$volume;

  factory CopyWith$Query$AllServices$services$allServices$storageUsage$volume.stub(
    TRes res,
  ) = _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage$volume;

  TRes call({String? name, String? $__typename});
}

class _CopyWithImpl$Query$AllServices$services$allServices$storageUsage$volume<
  TRes
>
    implements
        CopyWith$Query$AllServices$services$allServices$storageUsage$volume<
          TRes
        > {
  _CopyWithImpl$Query$AllServices$services$allServices$storageUsage$volume(
    this._instance,
    this._then,
  );

  final Query$AllServices$services$allServices$storageUsage$volume _instance;

  final TRes Function(
    Query$AllServices$services$allServices$storageUsage$volume,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? name = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$AllServices$services$allServices$storageUsage$volume(
          name:
              name == _undefined || name == null
                  ? _instance.name
                  : (name as String),
          $__typename:
              $__typename == _undefined || $__typename == null
                  ? _instance.$__typename
                  : ($__typename as String),
        ),
      );
}

class _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage$volume<
  TRes
>
    implements
        CopyWith$Query$AllServices$services$allServices$storageUsage$volume<
          TRes
        > {
  _CopyWithStubImpl$Query$AllServices$services$allServices$storageUsage$volume(
    this._res,
  );

  TRes _res;

  call({String? name, String? $__typename}) => _res;
}

class Query$AllServices$services$allServices$license {
  Query$AllServices$services$allServices$license({
    required this.free,
    required this.fullName,
    required this.redistributable,
    required this.shortName,
    this.url,
    this.$__typename = 'LicenseType',
  });

  factory Query$AllServices$services$allServices$license.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$free = json['free'];
    final l$fullName = json['fullName'];
    final l$redistributable = json['redistributable'];
    final l$shortName = json['shortName'];
    final l$url = json['url'];
    final l$$__typename = json['__typename'];
    return Query$AllServices$services$allServices$license(
      free: (l$free as bool),
      fullName: (l$fullName as String),
      redistributable: (l$redistributable as bool),
      shortName: (l$shortName as String),
      url: (l$url as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final bool free;

  final String fullName;

  final bool redistributable;

  final String shortName;

  final String? url;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$free = free;
    _resultData['free'] = l$free;
    final l$fullName = fullName;
    _resultData['fullName'] = l$fullName;
    final l$redistributable = redistributable;
    _resultData['redistributable'] = l$redistributable;
    final l$shortName = shortName;
    _resultData['shortName'] = l$shortName;
    final l$url = url;
    _resultData['url'] = l$url;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$free = free;
    final l$fullName = fullName;
    final l$redistributable = redistributable;
    final l$shortName = shortName;
    final l$url = url;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$free,
      l$fullName,
      l$redistributable,
      l$shortName,
      l$url,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$AllServices$services$allServices$license ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$free = free;
    final lOther$free = other.free;
    if (l$free != lOther$free) {
      return false;
    }
    final l$fullName = fullName;
    final lOther$fullName = other.fullName;
    if (l$fullName != lOther$fullName) {
      return false;
    }
    final l$redistributable = redistributable;
    final lOther$redistributable = other.redistributable;
    if (l$redistributable != lOther$redistributable) {
      return false;
    }
    final l$shortName = shortName;
    final lOther$shortName = other.shortName;
    if (l$shortName != lOther$shortName) {
      return false;
    }
    final l$url = url;
    final lOther$url = other.url;
    if (l$url != lOther$url) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$AllServices$services$allServices$license
    on Query$AllServices$services$allServices$license {
  CopyWith$Query$AllServices$services$allServices$license<
    Query$AllServices$services$allServices$license
  >
  get copyWith =>
      CopyWith$Query$AllServices$services$allServices$license(this, (i) => i);
}

abstract class CopyWith$Query$AllServices$services$allServices$license<TRes> {
  factory CopyWith$Query$AllServices$services$allServices$license(
    Query$AllServices$services$allServices$license instance,
    TRes Function(Query$AllServices$services$allServices$license) then,
  ) = _CopyWithImpl$Query$AllServices$services$allServices$license;

  factory CopyWith$Query$AllServices$services$allServices$license.stub(
    TRes res,
  ) = _CopyWithStubImpl$Query$AllServices$services$allServices$license;

  TRes call({
    bool? free,
    String? fullName,
    bool? redistributable,
    String? shortName,
    String? url,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$AllServices$services$allServices$license<TRes>
    implements CopyWith$Query$AllServices$services$allServices$license<TRes> {
  _CopyWithImpl$Query$AllServices$services$allServices$license(
    this._instance,
    this._then,
  );

  final Query$AllServices$services$allServices$license _instance;

  final TRes Function(Query$AllServices$services$allServices$license) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? free = _undefined,
    Object? fullName = _undefined,
    Object? redistributable = _undefined,
    Object? shortName = _undefined,
    Object? url = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$AllServices$services$allServices$license(
      free:
          free == _undefined || free == null ? _instance.free : (free as bool),
      fullName:
          fullName == _undefined || fullName == null
              ? _instance.fullName
              : (fullName as String),
      redistributable:
          redistributable == _undefined || redistributable == null
              ? _instance.redistributable
              : (redistributable as bool),
      shortName:
          shortName == _undefined || shortName == null
              ? _instance.shortName
              : (shortName as String),
      url: url == _undefined ? _instance.url : (url as String?),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$AllServices$services$allServices$license<TRes>
    implements CopyWith$Query$AllServices$services$allServices$license<TRes> {
  _CopyWithStubImpl$Query$AllServices$services$allServices$license(this._res);

  TRes _res;

  call({
    bool? free,
    String? fullName,
    bool? redistributable,
    String? shortName,
    String? url,
    String? $__typename,
  }) => _res;
}

class Query$AllServices$services$allServices$configuration {
  Query$AllServices$services$allServices$configuration({
    required this.fieldId,
    required this.description,
    required this.type,
    required this.$__typename,
  });

  factory Query$AllServices$services$allServices$configuration.fromJson(
    Map<String, dynamic> json,
  ) {
    switch (json["__typename"] as String) {
      case "BoolConfigItem":
        return Query$AllServices$services$allServices$configuration$$BoolConfigItem.fromJson(
          json,
        );

      case "EnumConfigItem":
        return Query$AllServices$services$allServices$configuration$$EnumConfigItem.fromJson(
          json,
        );

      case "StringConfigItem":
        return Query$AllServices$services$allServices$configuration$$StringConfigItem.fromJson(
          json,
        );

      default:
        final l$fieldId = json['fieldId'];
        final l$description = json['description'];
        final l$type = json['type'];
        final l$$__typename = json['__typename'];
        return Query$AllServices$services$allServices$configuration(
          fieldId: (l$fieldId as String),
          description: (l$description as String),
          type: (l$type as String),
          $__typename: (l$$__typename as String),
        );
    }
  }

  final String fieldId;

  final String description;

  final String type;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$fieldId = fieldId;
    _resultData['fieldId'] = l$fieldId;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$type = type;
    _resultData['type'] = l$type;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$fieldId = fieldId;
    final l$description = description;
    final l$type = type;
    final l$$__typename = $__typename;
    return Object.hashAll([l$fieldId, l$description, l$type, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$AllServices$services$allServices$configuration ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$fieldId = fieldId;
    final lOther$fieldId = other.fieldId;
    if (l$fieldId != lOther$fieldId) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$AllServices$services$allServices$configuration
    on Query$AllServices$services$allServices$configuration {
  CopyWith$Query$AllServices$services$allServices$configuration<
    Query$AllServices$services$allServices$configuration
  >
  get copyWith => CopyWith$Query$AllServices$services$allServices$configuration(
    this,
    (i) => i,
  );
  _T when<_T>({
    required _T Function(
      Query$AllServices$services$allServices$configuration$$BoolConfigItem,
    )
    boolConfigItem,
    required _T Function(
      Query$AllServices$services$allServices$configuration$$EnumConfigItem,
    )
    enumConfigItem,
    required _T Function(
      Query$AllServices$services$allServices$configuration$$StringConfigItem,
    )
    stringConfigItem,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "BoolConfigItem":
        return boolConfigItem(
          this
              as Query$AllServices$services$allServices$configuration$$BoolConfigItem,
        );

      case "EnumConfigItem":
        return enumConfigItem(
          this
              as Query$AllServices$services$allServices$configuration$$EnumConfigItem,
        );

      case "StringConfigItem":
        return stringConfigItem(
          this
              as Query$AllServices$services$allServices$configuration$$StringConfigItem,
        );

      default:
        return orElse();
    }
  }

  _T maybeWhen<_T>({
    _T Function(
      Query$AllServices$services$allServices$configuration$$BoolConfigItem,
    )?
    boolConfigItem,
    _T Function(
      Query$AllServices$services$allServices$configuration$$EnumConfigItem,
    )?
    enumConfigItem,
    _T Function(
      Query$AllServices$services$allServices$configuration$$StringConfigItem,
    )?
    stringConfigItem,
    required _T Function() orElse,
  }) {
    switch ($__typename) {
      case "BoolConfigItem":
        if (boolConfigItem != null) {
          return boolConfigItem(
            this
                as Query$AllServices$services$allServices$configuration$$BoolConfigItem,
          );
        } else {
          return orElse();
        }

      case "EnumConfigItem":
        if (enumConfigItem != null) {
          return enumConfigItem(
            this
                as Query$AllServices$services$allServices$configuration$$EnumConfigItem,
          );
        } else {
          return orElse();
        }

      case "StringConfigItem":
        if (stringConfigItem != null) {
          return stringConfigItem(
            this
                as Query$AllServices$services$allServices$configuration$$StringConfigItem,
          );
        } else {
          return orElse();
        }

      default:
        return orElse();
    }
  }
}

abstract class CopyWith$Query$AllServices$services$allServices$configuration<
  TRes
> {
  factory CopyWith$Query$AllServices$services$allServices$configuration(
    Query$AllServices$services$allServices$configuration instance,
    TRes Function(Query$AllServices$services$allServices$configuration) then,
  ) = _CopyWithImpl$Query$AllServices$services$allServices$configuration;

  factory CopyWith$Query$AllServices$services$allServices$configuration.stub(
    TRes res,
  ) = _CopyWithStubImpl$Query$AllServices$services$allServices$configuration;

  TRes call({
    String? fieldId,
    String? description,
    String? type,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$AllServices$services$allServices$configuration<TRes>
    implements
        CopyWith$Query$AllServices$services$allServices$configuration<TRes> {
  _CopyWithImpl$Query$AllServices$services$allServices$configuration(
    this._instance,
    this._then,
  );

  final Query$AllServices$services$allServices$configuration _instance;

  final TRes Function(Query$AllServices$services$allServices$configuration)
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? fieldId = _undefined,
    Object? description = _undefined,
    Object? type = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$AllServices$services$allServices$configuration(
      fieldId:
          fieldId == _undefined || fieldId == null
              ? _instance.fieldId
              : (fieldId as String),
      description:
          description == _undefined || description == null
              ? _instance.description
              : (description as String),
      type:
          type == _undefined || type == null
              ? _instance.type
              : (type as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$AllServices$services$allServices$configuration<
  TRes
>
    implements
        CopyWith$Query$AllServices$services$allServices$configuration<TRes> {
  _CopyWithStubImpl$Query$AllServices$services$allServices$configuration(
    this._res,
  );

  TRes _res;

  call({
    String? fieldId,
    String? description,
    String? type,
    String? $__typename,
  }) => _res;
}

class Query$AllServices$services$allServices$configuration$$BoolConfigItem
    implements
        Fragment$BoolConfigItem,
        Query$AllServices$services$allServices$configuration {
  Query$AllServices$services$allServices$configuration$$BoolConfigItem({
    required this.fieldId,
    required this.description,
    required this.type,
    required this.boolValue,
    required this.defaultBoolValue,
    required this.widget,
    this.$__typename = 'BoolConfigItem',
  });

  factory Query$AllServices$services$allServices$configuration$$BoolConfigItem.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$fieldId = json['fieldId'];
    final l$description = json['description'];
    final l$type = json['type'];
    final l$boolValue = json['boolValue'];
    final l$defaultBoolValue = json['defaultBoolValue'];
    final l$widget = json['widget'];
    final l$$__typename = json['__typename'];
    return Query$AllServices$services$allServices$configuration$$BoolConfigItem(
      fieldId: (l$fieldId as String),
      description: (l$description as String),
      type: (l$type as String),
      boolValue: (l$boolValue as bool),
      defaultBoolValue: (l$defaultBoolValue as bool),
      widget: (l$widget as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String fieldId;

  final String description;

  final String type;

  final bool boolValue;

  final bool defaultBoolValue;

  final String widget;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$fieldId = fieldId;
    _resultData['fieldId'] = l$fieldId;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$type = type;
    _resultData['type'] = l$type;
    final l$boolValue = boolValue;
    _resultData['boolValue'] = l$boolValue;
    final l$defaultBoolValue = defaultBoolValue;
    _resultData['defaultBoolValue'] = l$defaultBoolValue;
    final l$widget = widget;
    _resultData['widget'] = l$widget;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$fieldId = fieldId;
    final l$description = description;
    final l$type = type;
    final l$boolValue = boolValue;
    final l$defaultBoolValue = defaultBoolValue;
    final l$widget = widget;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$fieldId,
      l$description,
      l$type,
      l$boolValue,
      l$defaultBoolValue,
      l$widget,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$AllServices$services$allServices$configuration$$BoolConfigItem ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$fieldId = fieldId;
    final lOther$fieldId = other.fieldId;
    if (l$fieldId != lOther$fieldId) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
      return false;
    }
    final l$boolValue = boolValue;
    final lOther$boolValue = other.boolValue;
    if (l$boolValue != lOther$boolValue) {
      return false;
    }
    final l$defaultBoolValue = defaultBoolValue;
    final lOther$defaultBoolValue = other.defaultBoolValue;
    if (l$defaultBoolValue != lOther$defaultBoolValue) {
      return false;
    }
    final l$widget = widget;
    final lOther$widget = other.widget;
    if (l$widget != lOther$widget) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$AllServices$services$allServices$configuration$$BoolConfigItem
    on Query$AllServices$services$allServices$configuration$$BoolConfigItem {
  CopyWith$Query$AllServices$services$allServices$configuration$$BoolConfigItem<
    Query$AllServices$services$allServices$configuration$$BoolConfigItem
  >
  get copyWith =>
      CopyWith$Query$AllServices$services$allServices$configuration$$BoolConfigItem(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$AllServices$services$allServices$configuration$$BoolConfigItem<
  TRes
> {
  factory CopyWith$Query$AllServices$services$allServices$configuration$$BoolConfigItem(
    Query$AllServices$services$allServices$configuration$$BoolConfigItem
    instance,
    TRes Function(
      Query$AllServices$services$allServices$configuration$$BoolConfigItem,
    )
    then,
  ) =
      _CopyWithImpl$Query$AllServices$services$allServices$configuration$$BoolConfigItem;

  factory CopyWith$Query$AllServices$services$allServices$configuration$$BoolConfigItem.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$AllServices$services$allServices$configuration$$BoolConfigItem;

  TRes call({
    String? fieldId,
    String? description,
    String? type,
    bool? boolValue,
    bool? defaultBoolValue,
    String? widget,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$AllServices$services$allServices$configuration$$BoolConfigItem<
  TRes
>
    implements
        CopyWith$Query$AllServices$services$allServices$configuration$$BoolConfigItem<
          TRes
        > {
  _CopyWithImpl$Query$AllServices$services$allServices$configuration$$BoolConfigItem(
    this._instance,
    this._then,
  );

  final Query$AllServices$services$allServices$configuration$$BoolConfigItem
  _instance;

  final TRes Function(
    Query$AllServices$services$allServices$configuration$$BoolConfigItem,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? fieldId = _undefined,
    Object? description = _undefined,
    Object? type = _undefined,
    Object? boolValue = _undefined,
    Object? defaultBoolValue = _undefined,
    Object? widget = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$AllServices$services$allServices$configuration$$BoolConfigItem(
      fieldId:
          fieldId == _undefined || fieldId == null
              ? _instance.fieldId
              : (fieldId as String),
      description:
          description == _undefined || description == null
              ? _instance.description
              : (description as String),
      type:
          type == _undefined || type == null
              ? _instance.type
              : (type as String),
      boolValue:
          boolValue == _undefined || boolValue == null
              ? _instance.boolValue
              : (boolValue as bool),
      defaultBoolValue:
          defaultBoolValue == _undefined || defaultBoolValue == null
              ? _instance.defaultBoolValue
              : (defaultBoolValue as bool),
      widget:
          widget == _undefined || widget == null
              ? _instance.widget
              : (widget as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$AllServices$services$allServices$configuration$$BoolConfigItem<
  TRes
>
    implements
        CopyWith$Query$AllServices$services$allServices$configuration$$BoolConfigItem<
          TRes
        > {
  _CopyWithStubImpl$Query$AllServices$services$allServices$configuration$$BoolConfigItem(
    this._res,
  );

  TRes _res;

  call({
    String? fieldId,
    String? description,
    String? type,
    bool? boolValue,
    bool? defaultBoolValue,
    String? widget,
    String? $__typename,
  }) => _res;
}

class Query$AllServices$services$allServices$configuration$$EnumConfigItem
    implements
        Fragment$EnumConfigItem,
        Query$AllServices$services$allServices$configuration {
  Query$AllServices$services$allServices$configuration$$EnumConfigItem({
    required this.fieldId,
    required this.description,
    required this.type,
    required this.stringValue,
    required this.defaultStringValue,
    required this.options,
    required this.widget,
    this.$__typename = 'EnumConfigItem',
  });

  factory Query$AllServices$services$allServices$configuration$$EnumConfigItem.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$fieldId = json['fieldId'];
    final l$description = json['description'];
    final l$type = json['type'];
    final l$stringValue = json['stringValue'];
    final l$defaultStringValue = json['defaultStringValue'];
    final l$options = json['options'];
    final l$widget = json['widget'];
    final l$$__typename = json['__typename'];
    return Query$AllServices$services$allServices$configuration$$EnumConfigItem(
      fieldId: (l$fieldId as String),
      description: (l$description as String),
      type: (l$type as String),
      stringValue: (l$stringValue as String),
      defaultStringValue: (l$defaultStringValue as String),
      options: (l$options as List<dynamic>).map((e) => (e as String)).toList(),
      widget: (l$widget as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String fieldId;

  final String description;

  final String type;

  final String stringValue;

  final String defaultStringValue;

  final List<String> options;

  final String widget;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$fieldId = fieldId;
    _resultData['fieldId'] = l$fieldId;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$type = type;
    _resultData['type'] = l$type;
    final l$stringValue = stringValue;
    _resultData['stringValue'] = l$stringValue;
    final l$defaultStringValue = defaultStringValue;
    _resultData['defaultStringValue'] = l$defaultStringValue;
    final l$options = options;
    _resultData['options'] = l$options.map((e) => e).toList();
    final l$widget = widget;
    _resultData['widget'] = l$widget;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$fieldId = fieldId;
    final l$description = description;
    final l$type = type;
    final l$stringValue = stringValue;
    final l$defaultStringValue = defaultStringValue;
    final l$options = options;
    final l$widget = widget;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$fieldId,
      l$description,
      l$type,
      l$stringValue,
      l$defaultStringValue,
      Object.hashAll(l$options.map((v) => v)),
      l$widget,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$AllServices$services$allServices$configuration$$EnumConfigItem ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$fieldId = fieldId;
    final lOther$fieldId = other.fieldId;
    if (l$fieldId != lOther$fieldId) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
      return false;
    }
    final l$stringValue = stringValue;
    final lOther$stringValue = other.stringValue;
    if (l$stringValue != lOther$stringValue) {
      return false;
    }
    final l$defaultStringValue = defaultStringValue;
    final lOther$defaultStringValue = other.defaultStringValue;
    if (l$defaultStringValue != lOther$defaultStringValue) {
      return false;
    }
    final l$options = options;
    final lOther$options = other.options;
    if (l$options.length != lOther$options.length) {
      return false;
    }
    for (int i = 0; i < l$options.length; i++) {
      final l$options$entry = l$options[i];
      final lOther$options$entry = lOther$options[i];
      if (l$options$entry != lOther$options$entry) {
        return false;
      }
    }
    final l$widget = widget;
    final lOther$widget = other.widget;
    if (l$widget != lOther$widget) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$AllServices$services$allServices$configuration$$EnumConfigItem
    on Query$AllServices$services$allServices$configuration$$EnumConfigItem {
  CopyWith$Query$AllServices$services$allServices$configuration$$EnumConfigItem<
    Query$AllServices$services$allServices$configuration$$EnumConfigItem
  >
  get copyWith =>
      CopyWith$Query$AllServices$services$allServices$configuration$$EnumConfigItem(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$AllServices$services$allServices$configuration$$EnumConfigItem<
  TRes
> {
  factory CopyWith$Query$AllServices$services$allServices$configuration$$EnumConfigItem(
    Query$AllServices$services$allServices$configuration$$EnumConfigItem
    instance,
    TRes Function(
      Query$AllServices$services$allServices$configuration$$EnumConfigItem,
    )
    then,
  ) =
      _CopyWithImpl$Query$AllServices$services$allServices$configuration$$EnumConfigItem;

  factory CopyWith$Query$AllServices$services$allServices$configuration$$EnumConfigItem.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$AllServices$services$allServices$configuration$$EnumConfigItem;

  TRes call({
    String? fieldId,
    String? description,
    String? type,
    String? stringValue,
    String? defaultStringValue,
    List<String>? options,
    String? widget,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$AllServices$services$allServices$configuration$$EnumConfigItem<
  TRes
>
    implements
        CopyWith$Query$AllServices$services$allServices$configuration$$EnumConfigItem<
          TRes
        > {
  _CopyWithImpl$Query$AllServices$services$allServices$configuration$$EnumConfigItem(
    this._instance,
    this._then,
  );

  final Query$AllServices$services$allServices$configuration$$EnumConfigItem
  _instance;

  final TRes Function(
    Query$AllServices$services$allServices$configuration$$EnumConfigItem,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? fieldId = _undefined,
    Object? description = _undefined,
    Object? type = _undefined,
    Object? stringValue = _undefined,
    Object? defaultStringValue = _undefined,
    Object? options = _undefined,
    Object? widget = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$AllServices$services$allServices$configuration$$EnumConfigItem(
      fieldId:
          fieldId == _undefined || fieldId == null
              ? _instance.fieldId
              : (fieldId as String),
      description:
          description == _undefined || description == null
              ? _instance.description
              : (description as String),
      type:
          type == _undefined || type == null
              ? _instance.type
              : (type as String),
      stringValue:
          stringValue == _undefined || stringValue == null
              ? _instance.stringValue
              : (stringValue as String),
      defaultStringValue:
          defaultStringValue == _undefined || defaultStringValue == null
              ? _instance.defaultStringValue
              : (defaultStringValue as String),
      options:
          options == _undefined || options == null
              ? _instance.options
              : (options as List<String>),
      widget:
          widget == _undefined || widget == null
              ? _instance.widget
              : (widget as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$AllServices$services$allServices$configuration$$EnumConfigItem<
  TRes
>
    implements
        CopyWith$Query$AllServices$services$allServices$configuration$$EnumConfigItem<
          TRes
        > {
  _CopyWithStubImpl$Query$AllServices$services$allServices$configuration$$EnumConfigItem(
    this._res,
  );

  TRes _res;

  call({
    String? fieldId,
    String? description,
    String? type,
    String? stringValue,
    String? defaultStringValue,
    List<String>? options,
    String? widget,
    String? $__typename,
  }) => _res;
}

class Query$AllServices$services$allServices$configuration$$StringConfigItem
    implements
        Fragment$StringConfigItem,
        Query$AllServices$services$allServices$configuration {
  Query$AllServices$services$allServices$configuration$$StringConfigItem({
    required this.fieldId,
    required this.description,
    required this.type,
    required this.stringValue,
    required this.defaultStringValue,
    this.regex,
    required this.widget,
    this.$__typename = 'StringConfigItem',
  });

  factory Query$AllServices$services$allServices$configuration$$StringConfigItem.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$fieldId = json['fieldId'];
    final l$description = json['description'];
    final l$type = json['type'];
    final l$stringValue = json['stringValue'];
    final l$defaultStringValue = json['defaultStringValue'];
    final l$regex = json['regex'];
    final l$widget = json['widget'];
    final l$$__typename = json['__typename'];
    return Query$AllServices$services$allServices$configuration$$StringConfigItem(
      fieldId: (l$fieldId as String),
      description: (l$description as String),
      type: (l$type as String),
      stringValue: (l$stringValue as String),
      defaultStringValue: (l$defaultStringValue as String),
      regex: (l$regex as String?),
      widget: (l$widget as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String fieldId;

  final String description;

  final String type;

  final String stringValue;

  final String defaultStringValue;

  final String? regex;

  final String widget;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$fieldId = fieldId;
    _resultData['fieldId'] = l$fieldId;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$type = type;
    _resultData['type'] = l$type;
    final l$stringValue = stringValue;
    _resultData['stringValue'] = l$stringValue;
    final l$defaultStringValue = defaultStringValue;
    _resultData['defaultStringValue'] = l$defaultStringValue;
    final l$regex = regex;
    _resultData['regex'] = l$regex;
    final l$widget = widget;
    _resultData['widget'] = l$widget;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$fieldId = fieldId;
    final l$description = description;
    final l$type = type;
    final l$stringValue = stringValue;
    final l$defaultStringValue = defaultStringValue;
    final l$regex = regex;
    final l$widget = widget;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$fieldId,
      l$description,
      l$type,
      l$stringValue,
      l$defaultStringValue,
      l$regex,
      l$widget,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Query$AllServices$services$allServices$configuration$$StringConfigItem ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$fieldId = fieldId;
    final lOther$fieldId = other.fieldId;
    if (l$fieldId != lOther$fieldId) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
      return false;
    }
    final l$stringValue = stringValue;
    final lOther$stringValue = other.stringValue;
    if (l$stringValue != lOther$stringValue) {
      return false;
    }
    final l$defaultStringValue = defaultStringValue;
    final lOther$defaultStringValue = other.defaultStringValue;
    if (l$defaultStringValue != lOther$defaultStringValue) {
      return false;
    }
    final l$regex = regex;
    final lOther$regex = other.regex;
    if (l$regex != lOther$regex) {
      return false;
    }
    final l$widget = widget;
    final lOther$widget = other.widget;
    if (l$widget != lOther$widget) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$AllServices$services$allServices$configuration$$StringConfigItem
    on Query$AllServices$services$allServices$configuration$$StringConfigItem {
  CopyWith$Query$AllServices$services$allServices$configuration$$StringConfigItem<
    Query$AllServices$services$allServices$configuration$$StringConfigItem
  >
  get copyWith =>
      CopyWith$Query$AllServices$services$allServices$configuration$$StringConfigItem(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$AllServices$services$allServices$configuration$$StringConfigItem<
  TRes
> {
  factory CopyWith$Query$AllServices$services$allServices$configuration$$StringConfigItem(
    Query$AllServices$services$allServices$configuration$$StringConfigItem
    instance,
    TRes Function(
      Query$AllServices$services$allServices$configuration$$StringConfigItem,
    )
    then,
  ) =
      _CopyWithImpl$Query$AllServices$services$allServices$configuration$$StringConfigItem;

  factory CopyWith$Query$AllServices$services$allServices$configuration$$StringConfigItem.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Query$AllServices$services$allServices$configuration$$StringConfigItem;

  TRes call({
    String? fieldId,
    String? description,
    String? type,
    String? stringValue,
    String? defaultStringValue,
    String? regex,
    String? widget,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$AllServices$services$allServices$configuration$$StringConfigItem<
  TRes
>
    implements
        CopyWith$Query$AllServices$services$allServices$configuration$$StringConfigItem<
          TRes
        > {
  _CopyWithImpl$Query$AllServices$services$allServices$configuration$$StringConfigItem(
    this._instance,
    this._then,
  );

  final Query$AllServices$services$allServices$configuration$$StringConfigItem
  _instance;

  final TRes Function(
    Query$AllServices$services$allServices$configuration$$StringConfigItem,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? fieldId = _undefined,
    Object? description = _undefined,
    Object? type = _undefined,
    Object? stringValue = _undefined,
    Object? defaultStringValue = _undefined,
    Object? regex = _undefined,
    Object? widget = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$AllServices$services$allServices$configuration$$StringConfigItem(
      fieldId:
          fieldId == _undefined || fieldId == null
              ? _instance.fieldId
              : (fieldId as String),
      description:
          description == _undefined || description == null
              ? _instance.description
              : (description as String),
      type:
          type == _undefined || type == null
              ? _instance.type
              : (type as String),
      stringValue:
          stringValue == _undefined || stringValue == null
              ? _instance.stringValue
              : (stringValue as String),
      defaultStringValue:
          defaultStringValue == _undefined || defaultStringValue == null
              ? _instance.defaultStringValue
              : (defaultStringValue as String),
      regex: regex == _undefined ? _instance.regex : (regex as String?),
      widget:
          widget == _undefined || widget == null
              ? _instance.widget
              : (widget as String),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$AllServices$services$allServices$configuration$$StringConfigItem<
  TRes
>
    implements
        CopyWith$Query$AllServices$services$allServices$configuration$$StringConfigItem<
          TRes
        > {
  _CopyWithStubImpl$Query$AllServices$services$allServices$configuration$$StringConfigItem(
    this._res,
  );

  TRes _res;

  call({
    String? fieldId,
    String? description,
    String? type,
    String? stringValue,
    String? defaultStringValue,
    String? regex,
    String? widget,
    String? $__typename,
  }) => _res;
}

class Variables$Mutation$EnableService {
  factory Variables$Mutation$EnableService({required String serviceId}) =>
      Variables$Mutation$EnableService._({r'serviceId': serviceId});

  Variables$Mutation$EnableService._(this._$data);

  factory Variables$Mutation$EnableService.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$serviceId = data['serviceId'];
    result$data['serviceId'] = (l$serviceId as String);
    return Variables$Mutation$EnableService._(result$data);
  }

  Map<String, dynamic> _$data;

  String get serviceId => (_$data['serviceId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$serviceId = serviceId;
    result$data['serviceId'] = l$serviceId;
    return result$data;
  }

  CopyWith$Variables$Mutation$EnableService<Variables$Mutation$EnableService>
  get copyWith => CopyWith$Variables$Mutation$EnableService(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$EnableService ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$serviceId = serviceId;
    final lOther$serviceId = other.serviceId;
    if (l$serviceId != lOther$serviceId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$serviceId = serviceId;
    return Object.hashAll([l$serviceId]);
  }
}

abstract class CopyWith$Variables$Mutation$EnableService<TRes> {
  factory CopyWith$Variables$Mutation$EnableService(
    Variables$Mutation$EnableService instance,
    TRes Function(Variables$Mutation$EnableService) then,
  ) = _CopyWithImpl$Variables$Mutation$EnableService;

  factory CopyWith$Variables$Mutation$EnableService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$EnableService;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$EnableService<TRes>
    implements CopyWith$Variables$Mutation$EnableService<TRes> {
  _CopyWithImpl$Variables$Mutation$EnableService(this._instance, this._then);

  final Variables$Mutation$EnableService _instance;

  final TRes Function(Variables$Mutation$EnableService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? serviceId = _undefined}) => _then(
    Variables$Mutation$EnableService._({
      ..._instance._$data,
      if (serviceId != _undefined && serviceId != null)
        'serviceId': (serviceId as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$EnableService<TRes>
    implements CopyWith$Variables$Mutation$EnableService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$EnableService(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

class Mutation$EnableService {
  Mutation$EnableService({
    required this.services,
    this.$__typename = 'Mutation',
  });

  factory Mutation$EnableService.fromJson(Map<String, dynamic> json) {
    final l$services = json['services'];
    final l$$__typename = json['__typename'];
    return Mutation$EnableService(
      services: Mutation$EnableService$services.fromJson(
        (l$services as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$EnableService$services services;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$services = services;
    _resultData['services'] = l$services.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$services = services;
    final l$$__typename = $__typename;
    return Object.hashAll([l$services, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$EnableService || runtimeType != other.runtimeType) {
      return false;
    }
    final l$services = services;
    final lOther$services = other.services;
    if (l$services != lOther$services) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$EnableService on Mutation$EnableService {
  CopyWith$Mutation$EnableService<Mutation$EnableService> get copyWith =>
      CopyWith$Mutation$EnableService(this, (i) => i);
}

abstract class CopyWith$Mutation$EnableService<TRes> {
  factory CopyWith$Mutation$EnableService(
    Mutation$EnableService instance,
    TRes Function(Mutation$EnableService) then,
  ) = _CopyWithImpl$Mutation$EnableService;

  factory CopyWith$Mutation$EnableService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$EnableService;

  TRes call({Mutation$EnableService$services? services, String? $__typename});
  CopyWith$Mutation$EnableService$services<TRes> get services;
}

class _CopyWithImpl$Mutation$EnableService<TRes>
    implements CopyWith$Mutation$EnableService<TRes> {
  _CopyWithImpl$Mutation$EnableService(this._instance, this._then);

  final Mutation$EnableService _instance;

  final TRes Function(Mutation$EnableService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? services = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$EnableService(
      services:
          services == _undefined || services == null
              ? _instance.services
              : (services as Mutation$EnableService$services),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$EnableService$services<TRes> get services {
    final local$services = _instance.services;
    return CopyWith$Mutation$EnableService$services(
      local$services,
      (e) => call(services: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$EnableService<TRes>
    implements CopyWith$Mutation$EnableService<TRes> {
  _CopyWithStubImpl$Mutation$EnableService(this._res);

  TRes _res;

  call({Mutation$EnableService$services? services, String? $__typename}) =>
      _res;

  CopyWith$Mutation$EnableService$services<TRes> get services =>
      CopyWith$Mutation$EnableService$services.stub(_res);
}

const documentNodeMutationEnableService = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'EnableService'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'serviceId')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'services'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'enableService'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'serviceId'),
                      value: VariableNode(name: NameNode(value: 'serviceId')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'basicMutationReturnFields'),
                        directives: [],
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionbasicMutationReturnFields,
  ],
);
Mutation$EnableService _parserFn$Mutation$EnableService(
  Map<String, dynamic> data,
) => Mutation$EnableService.fromJson(data);
typedef OnMutationCompleted$Mutation$EnableService =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$EnableService?);

class Options$Mutation$EnableService
    extends graphql.MutationOptions<Mutation$EnableService> {
  Options$Mutation$EnableService({
    String? operationName,
    required Variables$Mutation$EnableService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$EnableService? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$EnableService? onCompleted,
    graphql.OnMutationUpdate<Mutation$EnableService>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null ? null : _parserFn$Mutation$EnableService(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationEnableService,
         parserFn: _parserFn$Mutation$EnableService,
       );

  final OnMutationCompleted$Mutation$EnableService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$EnableService
    extends graphql.WatchQueryOptions<Mutation$EnableService> {
  WatchOptions$Mutation$EnableService({
    String? operationName,
    required Variables$Mutation$EnableService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$EnableService? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationEnableService,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$EnableService,
       );
}

extension ClientExtension$Mutation$EnableService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$EnableService>> mutate$EnableService(
    Options$Mutation$EnableService options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$EnableService> watchMutation$EnableService(
    WatchOptions$Mutation$EnableService options,
  ) => this.watchMutation(options);
}

class Mutation$EnableService$services {
  Mutation$EnableService$services({
    required this.enableService,
    this.$__typename = 'ServicesMutations',
  });

  factory Mutation$EnableService$services.fromJson(Map<String, dynamic> json) {
    final l$enableService = json['enableService'];
    final l$$__typename = json['__typename'];
    return Mutation$EnableService$services(
      enableService: Mutation$EnableService$services$enableService.fromJson(
        (l$enableService as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$EnableService$services$enableService enableService;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$enableService = enableService;
    _resultData['enableService'] = l$enableService.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$enableService = enableService;
    final l$$__typename = $__typename;
    return Object.hashAll([l$enableService, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$EnableService$services ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$enableService = enableService;
    final lOther$enableService = other.enableService;
    if (l$enableService != lOther$enableService) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$EnableService$services
    on Mutation$EnableService$services {
  CopyWith$Mutation$EnableService$services<Mutation$EnableService$services>
  get copyWith => CopyWith$Mutation$EnableService$services(this, (i) => i);
}

abstract class CopyWith$Mutation$EnableService$services<TRes> {
  factory CopyWith$Mutation$EnableService$services(
    Mutation$EnableService$services instance,
    TRes Function(Mutation$EnableService$services) then,
  ) = _CopyWithImpl$Mutation$EnableService$services;

  factory CopyWith$Mutation$EnableService$services.stub(TRes res) =
      _CopyWithStubImpl$Mutation$EnableService$services;

  TRes call({
    Mutation$EnableService$services$enableService? enableService,
    String? $__typename,
  });
  CopyWith$Mutation$EnableService$services$enableService<TRes>
  get enableService;
}

class _CopyWithImpl$Mutation$EnableService$services<TRes>
    implements CopyWith$Mutation$EnableService$services<TRes> {
  _CopyWithImpl$Mutation$EnableService$services(this._instance, this._then);

  final Mutation$EnableService$services _instance;

  final TRes Function(Mutation$EnableService$services) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? enableService = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$EnableService$services(
      enableService:
          enableService == _undefined || enableService == null
              ? _instance.enableService
              : (enableService
                  as Mutation$EnableService$services$enableService),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$EnableService$services$enableService<TRes>
  get enableService {
    final local$enableService = _instance.enableService;
    return CopyWith$Mutation$EnableService$services$enableService(
      local$enableService,
      (e) => call(enableService: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$EnableService$services<TRes>
    implements CopyWith$Mutation$EnableService$services<TRes> {
  _CopyWithStubImpl$Mutation$EnableService$services(this._res);

  TRes _res;

  call({
    Mutation$EnableService$services$enableService? enableService,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$EnableService$services$enableService<TRes>
  get enableService =>
      CopyWith$Mutation$EnableService$services$enableService.stub(_res);
}

class Mutation$EnableService$services$enableService
    implements Fragment$basicMutationReturnFields$$ServiceMutationReturn {
  Mutation$EnableService$services$enableService({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ServiceMutationReturn',
  });

  factory Mutation$EnableService$services$enableService.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$EnableService$services$enableService(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    return Object.hashAll([l$code, l$message, l$success, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$EnableService$services$enableService ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$EnableService$services$enableService
    on Mutation$EnableService$services$enableService {
  CopyWith$Mutation$EnableService$services$enableService<
    Mutation$EnableService$services$enableService
  >
  get copyWith =>
      CopyWith$Mutation$EnableService$services$enableService(this, (i) => i);
}

abstract class CopyWith$Mutation$EnableService$services$enableService<TRes> {
  factory CopyWith$Mutation$EnableService$services$enableService(
    Mutation$EnableService$services$enableService instance,
    TRes Function(Mutation$EnableService$services$enableService) then,
  ) = _CopyWithImpl$Mutation$EnableService$services$enableService;

  factory CopyWith$Mutation$EnableService$services$enableService.stub(
    TRes res,
  ) = _CopyWithStubImpl$Mutation$EnableService$services$enableService;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$EnableService$services$enableService<TRes>
    implements CopyWith$Mutation$EnableService$services$enableService<TRes> {
  _CopyWithImpl$Mutation$EnableService$services$enableService(
    this._instance,
    this._then,
  );

  final Mutation$EnableService$services$enableService _instance;

  final TRes Function(Mutation$EnableService$services$enableService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$EnableService$services$enableService(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Mutation$EnableService$services$enableService<TRes>
    implements CopyWith$Mutation$EnableService$services$enableService<TRes> {
  _CopyWithStubImpl$Mutation$EnableService$services$enableService(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

class Variables$Mutation$DisableService {
  factory Variables$Mutation$DisableService({required String serviceId}) =>
      Variables$Mutation$DisableService._({r'serviceId': serviceId});

  Variables$Mutation$DisableService._(this._$data);

  factory Variables$Mutation$DisableService.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$serviceId = data['serviceId'];
    result$data['serviceId'] = (l$serviceId as String);
    return Variables$Mutation$DisableService._(result$data);
  }

  Map<String, dynamic> _$data;

  String get serviceId => (_$data['serviceId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$serviceId = serviceId;
    result$data['serviceId'] = l$serviceId;
    return result$data;
  }

  CopyWith$Variables$Mutation$DisableService<Variables$Mutation$DisableService>
  get copyWith => CopyWith$Variables$Mutation$DisableService(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$DisableService ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$serviceId = serviceId;
    final lOther$serviceId = other.serviceId;
    if (l$serviceId != lOther$serviceId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$serviceId = serviceId;
    return Object.hashAll([l$serviceId]);
  }
}

abstract class CopyWith$Variables$Mutation$DisableService<TRes> {
  factory CopyWith$Variables$Mutation$DisableService(
    Variables$Mutation$DisableService instance,
    TRes Function(Variables$Mutation$DisableService) then,
  ) = _CopyWithImpl$Variables$Mutation$DisableService;

  factory CopyWith$Variables$Mutation$DisableService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$DisableService;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$DisableService<TRes>
    implements CopyWith$Variables$Mutation$DisableService<TRes> {
  _CopyWithImpl$Variables$Mutation$DisableService(this._instance, this._then);

  final Variables$Mutation$DisableService _instance;

  final TRes Function(Variables$Mutation$DisableService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? serviceId = _undefined}) => _then(
    Variables$Mutation$DisableService._({
      ..._instance._$data,
      if (serviceId != _undefined && serviceId != null)
        'serviceId': (serviceId as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$DisableService<TRes>
    implements CopyWith$Variables$Mutation$DisableService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$DisableService(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

class Mutation$DisableService {
  Mutation$DisableService({
    required this.services,
    this.$__typename = 'Mutation',
  });

  factory Mutation$DisableService.fromJson(Map<String, dynamic> json) {
    final l$services = json['services'];
    final l$$__typename = json['__typename'];
    return Mutation$DisableService(
      services: Mutation$DisableService$services.fromJson(
        (l$services as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$DisableService$services services;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$services = services;
    _resultData['services'] = l$services.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$services = services;
    final l$$__typename = $__typename;
    return Object.hashAll([l$services, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$DisableService || runtimeType != other.runtimeType) {
      return false;
    }
    final l$services = services;
    final lOther$services = other.services;
    if (l$services != lOther$services) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$DisableService on Mutation$DisableService {
  CopyWith$Mutation$DisableService<Mutation$DisableService> get copyWith =>
      CopyWith$Mutation$DisableService(this, (i) => i);
}

abstract class CopyWith$Mutation$DisableService<TRes> {
  factory CopyWith$Mutation$DisableService(
    Mutation$DisableService instance,
    TRes Function(Mutation$DisableService) then,
  ) = _CopyWithImpl$Mutation$DisableService;

  factory CopyWith$Mutation$DisableService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DisableService;

  TRes call({Mutation$DisableService$services? services, String? $__typename});
  CopyWith$Mutation$DisableService$services<TRes> get services;
}

class _CopyWithImpl$Mutation$DisableService<TRes>
    implements CopyWith$Mutation$DisableService<TRes> {
  _CopyWithImpl$Mutation$DisableService(this._instance, this._then);

  final Mutation$DisableService _instance;

  final TRes Function(Mutation$DisableService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? services = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$DisableService(
      services:
          services == _undefined || services == null
              ? _instance.services
              : (services as Mutation$DisableService$services),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$DisableService$services<TRes> get services {
    final local$services = _instance.services;
    return CopyWith$Mutation$DisableService$services(
      local$services,
      (e) => call(services: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$DisableService<TRes>
    implements CopyWith$Mutation$DisableService<TRes> {
  _CopyWithStubImpl$Mutation$DisableService(this._res);

  TRes _res;

  call({Mutation$DisableService$services? services, String? $__typename}) =>
      _res;

  CopyWith$Mutation$DisableService$services<TRes> get services =>
      CopyWith$Mutation$DisableService$services.stub(_res);
}

const documentNodeMutationDisableService = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DisableService'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'serviceId')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'services'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'disableService'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'serviceId'),
                      value: VariableNode(name: NameNode(value: 'serviceId')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'basicMutationReturnFields'),
                        directives: [],
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionbasicMutationReturnFields,
  ],
);
Mutation$DisableService _parserFn$Mutation$DisableService(
  Map<String, dynamic> data,
) => Mutation$DisableService.fromJson(data);
typedef OnMutationCompleted$Mutation$DisableService =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$DisableService?);

class Options$Mutation$DisableService
    extends graphql.MutationOptions<Mutation$DisableService> {
  Options$Mutation$DisableService({
    String? operationName,
    required Variables$Mutation$DisableService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DisableService? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$DisableService? onCompleted,
    graphql.OnMutationUpdate<Mutation$DisableService>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null
                       ? null
                       : _parserFn$Mutation$DisableService(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationDisableService,
         parserFn: _parserFn$Mutation$DisableService,
       );

  final OnMutationCompleted$Mutation$DisableService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$DisableService
    extends graphql.WatchQueryOptions<Mutation$DisableService> {
  WatchOptions$Mutation$DisableService({
    String? operationName,
    required Variables$Mutation$DisableService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DisableService? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationDisableService,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$DisableService,
       );
}

extension ClientExtension$Mutation$DisableService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$DisableService>> mutate$DisableService(
    Options$Mutation$DisableService options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$DisableService> watchMutation$DisableService(
    WatchOptions$Mutation$DisableService options,
  ) => this.watchMutation(options);
}

class Mutation$DisableService$services {
  Mutation$DisableService$services({
    required this.disableService,
    this.$__typename = 'ServicesMutations',
  });

  factory Mutation$DisableService$services.fromJson(Map<String, dynamic> json) {
    final l$disableService = json['disableService'];
    final l$$__typename = json['__typename'];
    return Mutation$DisableService$services(
      disableService: Mutation$DisableService$services$disableService.fromJson(
        (l$disableService as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$DisableService$services$disableService disableService;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$disableService = disableService;
    _resultData['disableService'] = l$disableService.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$disableService = disableService;
    final l$$__typename = $__typename;
    return Object.hashAll([l$disableService, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$DisableService$services ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$disableService = disableService;
    final lOther$disableService = other.disableService;
    if (l$disableService != lOther$disableService) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$DisableService$services
    on Mutation$DisableService$services {
  CopyWith$Mutation$DisableService$services<Mutation$DisableService$services>
  get copyWith => CopyWith$Mutation$DisableService$services(this, (i) => i);
}

abstract class CopyWith$Mutation$DisableService$services<TRes> {
  factory CopyWith$Mutation$DisableService$services(
    Mutation$DisableService$services instance,
    TRes Function(Mutation$DisableService$services) then,
  ) = _CopyWithImpl$Mutation$DisableService$services;

  factory CopyWith$Mutation$DisableService$services.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DisableService$services;

  TRes call({
    Mutation$DisableService$services$disableService? disableService,
    String? $__typename,
  });
  CopyWith$Mutation$DisableService$services$disableService<TRes>
  get disableService;
}

class _CopyWithImpl$Mutation$DisableService$services<TRes>
    implements CopyWith$Mutation$DisableService$services<TRes> {
  _CopyWithImpl$Mutation$DisableService$services(this._instance, this._then);

  final Mutation$DisableService$services _instance;

  final TRes Function(Mutation$DisableService$services) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? disableService = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$DisableService$services(
      disableService:
          disableService == _undefined || disableService == null
              ? _instance.disableService
              : (disableService
                  as Mutation$DisableService$services$disableService),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$DisableService$services$disableService<TRes>
  get disableService {
    final local$disableService = _instance.disableService;
    return CopyWith$Mutation$DisableService$services$disableService(
      local$disableService,
      (e) => call(disableService: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$DisableService$services<TRes>
    implements CopyWith$Mutation$DisableService$services<TRes> {
  _CopyWithStubImpl$Mutation$DisableService$services(this._res);

  TRes _res;

  call({
    Mutation$DisableService$services$disableService? disableService,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$DisableService$services$disableService<TRes>
  get disableService =>
      CopyWith$Mutation$DisableService$services$disableService.stub(_res);
}

class Mutation$DisableService$services$disableService
    implements Fragment$basicMutationReturnFields$$ServiceMutationReturn {
  Mutation$DisableService$services$disableService({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ServiceMutationReturn',
  });

  factory Mutation$DisableService$services$disableService.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$DisableService$services$disableService(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    return Object.hashAll([l$code, l$message, l$success, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$DisableService$services$disableService ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$DisableService$services$disableService
    on Mutation$DisableService$services$disableService {
  CopyWith$Mutation$DisableService$services$disableService<
    Mutation$DisableService$services$disableService
  >
  get copyWith =>
      CopyWith$Mutation$DisableService$services$disableService(this, (i) => i);
}

abstract class CopyWith$Mutation$DisableService$services$disableService<TRes> {
  factory CopyWith$Mutation$DisableService$services$disableService(
    Mutation$DisableService$services$disableService instance,
    TRes Function(Mutation$DisableService$services$disableService) then,
  ) = _CopyWithImpl$Mutation$DisableService$services$disableService;

  factory CopyWith$Mutation$DisableService$services$disableService.stub(
    TRes res,
  ) = _CopyWithStubImpl$Mutation$DisableService$services$disableService;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$DisableService$services$disableService<TRes>
    implements CopyWith$Mutation$DisableService$services$disableService<TRes> {
  _CopyWithImpl$Mutation$DisableService$services$disableService(
    this._instance,
    this._then,
  );

  final Mutation$DisableService$services$disableService _instance;

  final TRes Function(Mutation$DisableService$services$disableService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$DisableService$services$disableService(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Mutation$DisableService$services$disableService<TRes>
    implements CopyWith$Mutation$DisableService$services$disableService<TRes> {
  _CopyWithStubImpl$Mutation$DisableService$services$disableService(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

class Variables$Mutation$StopService {
  factory Variables$Mutation$StopService({required String serviceId}) =>
      Variables$Mutation$StopService._({r'serviceId': serviceId});

  Variables$Mutation$StopService._(this._$data);

  factory Variables$Mutation$StopService.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$serviceId = data['serviceId'];
    result$data['serviceId'] = (l$serviceId as String);
    return Variables$Mutation$StopService._(result$data);
  }

  Map<String, dynamic> _$data;

  String get serviceId => (_$data['serviceId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$serviceId = serviceId;
    result$data['serviceId'] = l$serviceId;
    return result$data;
  }

  CopyWith$Variables$Mutation$StopService<Variables$Mutation$StopService>
  get copyWith => CopyWith$Variables$Mutation$StopService(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$StopService ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$serviceId = serviceId;
    final lOther$serviceId = other.serviceId;
    if (l$serviceId != lOther$serviceId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$serviceId = serviceId;
    return Object.hashAll([l$serviceId]);
  }
}

abstract class CopyWith$Variables$Mutation$StopService<TRes> {
  factory CopyWith$Variables$Mutation$StopService(
    Variables$Mutation$StopService instance,
    TRes Function(Variables$Mutation$StopService) then,
  ) = _CopyWithImpl$Variables$Mutation$StopService;

  factory CopyWith$Variables$Mutation$StopService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$StopService;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$StopService<TRes>
    implements CopyWith$Variables$Mutation$StopService<TRes> {
  _CopyWithImpl$Variables$Mutation$StopService(this._instance, this._then);

  final Variables$Mutation$StopService _instance;

  final TRes Function(Variables$Mutation$StopService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? serviceId = _undefined}) => _then(
    Variables$Mutation$StopService._({
      ..._instance._$data,
      if (serviceId != _undefined && serviceId != null)
        'serviceId': (serviceId as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$StopService<TRes>
    implements CopyWith$Variables$Mutation$StopService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$StopService(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

class Mutation$StopService {
  Mutation$StopService({required this.services, this.$__typename = 'Mutation'});

  factory Mutation$StopService.fromJson(Map<String, dynamic> json) {
    final l$services = json['services'];
    final l$$__typename = json['__typename'];
    return Mutation$StopService(
      services: Mutation$StopService$services.fromJson(
        (l$services as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$StopService$services services;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$services = services;
    _resultData['services'] = l$services.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$services = services;
    final l$$__typename = $__typename;
    return Object.hashAll([l$services, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$StopService || runtimeType != other.runtimeType) {
      return false;
    }
    final l$services = services;
    final lOther$services = other.services;
    if (l$services != lOther$services) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$StopService on Mutation$StopService {
  CopyWith$Mutation$StopService<Mutation$StopService> get copyWith =>
      CopyWith$Mutation$StopService(this, (i) => i);
}

abstract class CopyWith$Mutation$StopService<TRes> {
  factory CopyWith$Mutation$StopService(
    Mutation$StopService instance,
    TRes Function(Mutation$StopService) then,
  ) = _CopyWithImpl$Mutation$StopService;

  factory CopyWith$Mutation$StopService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StopService;

  TRes call({Mutation$StopService$services? services, String? $__typename});
  CopyWith$Mutation$StopService$services<TRes> get services;
}

class _CopyWithImpl$Mutation$StopService<TRes>
    implements CopyWith$Mutation$StopService<TRes> {
  _CopyWithImpl$Mutation$StopService(this._instance, this._then);

  final Mutation$StopService _instance;

  final TRes Function(Mutation$StopService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? services = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$StopService(
      services:
          services == _undefined || services == null
              ? _instance.services
              : (services as Mutation$StopService$services),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$StopService$services<TRes> get services {
    final local$services = _instance.services;
    return CopyWith$Mutation$StopService$services(
      local$services,
      (e) => call(services: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$StopService<TRes>
    implements CopyWith$Mutation$StopService<TRes> {
  _CopyWithStubImpl$Mutation$StopService(this._res);

  TRes _res;

  call({Mutation$StopService$services? services, String? $__typename}) => _res;

  CopyWith$Mutation$StopService$services<TRes> get services =>
      CopyWith$Mutation$StopService$services.stub(_res);
}

const documentNodeMutationStopService = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'StopService'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'serviceId')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'services'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'stopService'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'serviceId'),
                      value: VariableNode(name: NameNode(value: 'serviceId')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'basicMutationReturnFields'),
                        directives: [],
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionbasicMutationReturnFields,
  ],
);
Mutation$StopService _parserFn$Mutation$StopService(
  Map<String, dynamic> data,
) => Mutation$StopService.fromJson(data);
typedef OnMutationCompleted$Mutation$StopService =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$StopService?);

class Options$Mutation$StopService
    extends graphql.MutationOptions<Mutation$StopService> {
  Options$Mutation$StopService({
    String? operationName,
    required Variables$Mutation$StopService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$StopService? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$StopService? onCompleted,
    graphql.OnMutationUpdate<Mutation$StopService>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null ? null : _parserFn$Mutation$StopService(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationStopService,
         parserFn: _parserFn$Mutation$StopService,
       );

  final OnMutationCompleted$Mutation$StopService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$StopService
    extends graphql.WatchQueryOptions<Mutation$StopService> {
  WatchOptions$Mutation$StopService({
    String? operationName,
    required Variables$Mutation$StopService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$StopService? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationStopService,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$StopService,
       );
}

extension ClientExtension$Mutation$StopService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$StopService>> mutate$StopService(
    Options$Mutation$StopService options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$StopService> watchMutation$StopService(
    WatchOptions$Mutation$StopService options,
  ) => this.watchMutation(options);
}

class Mutation$StopService$services {
  Mutation$StopService$services({
    required this.stopService,
    this.$__typename = 'ServicesMutations',
  });

  factory Mutation$StopService$services.fromJson(Map<String, dynamic> json) {
    final l$stopService = json['stopService'];
    final l$$__typename = json['__typename'];
    return Mutation$StopService$services(
      stopService: Mutation$StopService$services$stopService.fromJson(
        (l$stopService as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$StopService$services$stopService stopService;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$stopService = stopService;
    _resultData['stopService'] = l$stopService.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$stopService = stopService;
    final l$$__typename = $__typename;
    return Object.hashAll([l$stopService, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$StopService$services ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$stopService = stopService;
    final lOther$stopService = other.stopService;
    if (l$stopService != lOther$stopService) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$StopService$services
    on Mutation$StopService$services {
  CopyWith$Mutation$StopService$services<Mutation$StopService$services>
  get copyWith => CopyWith$Mutation$StopService$services(this, (i) => i);
}

abstract class CopyWith$Mutation$StopService$services<TRes> {
  factory CopyWith$Mutation$StopService$services(
    Mutation$StopService$services instance,
    TRes Function(Mutation$StopService$services) then,
  ) = _CopyWithImpl$Mutation$StopService$services;

  factory CopyWith$Mutation$StopService$services.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StopService$services;

  TRes call({
    Mutation$StopService$services$stopService? stopService,
    String? $__typename,
  });
  CopyWith$Mutation$StopService$services$stopService<TRes> get stopService;
}

class _CopyWithImpl$Mutation$StopService$services<TRes>
    implements CopyWith$Mutation$StopService$services<TRes> {
  _CopyWithImpl$Mutation$StopService$services(this._instance, this._then);

  final Mutation$StopService$services _instance;

  final TRes Function(Mutation$StopService$services) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? stopService = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$StopService$services(
      stopService:
          stopService == _undefined || stopService == null
              ? _instance.stopService
              : (stopService as Mutation$StopService$services$stopService),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$StopService$services$stopService<TRes> get stopService {
    final local$stopService = _instance.stopService;
    return CopyWith$Mutation$StopService$services$stopService(
      local$stopService,
      (e) => call(stopService: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$StopService$services<TRes>
    implements CopyWith$Mutation$StopService$services<TRes> {
  _CopyWithStubImpl$Mutation$StopService$services(this._res);

  TRes _res;

  call({
    Mutation$StopService$services$stopService? stopService,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$StopService$services$stopService<TRes> get stopService =>
      CopyWith$Mutation$StopService$services$stopService.stub(_res);
}

class Mutation$StopService$services$stopService
    implements Fragment$basicMutationReturnFields$$ServiceMutationReturn {
  Mutation$StopService$services$stopService({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ServiceMutationReturn',
  });

  factory Mutation$StopService$services$stopService.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$StopService$services$stopService(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    return Object.hashAll([l$code, l$message, l$success, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$StopService$services$stopService ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$StopService$services$stopService
    on Mutation$StopService$services$stopService {
  CopyWith$Mutation$StopService$services$stopService<
    Mutation$StopService$services$stopService
  >
  get copyWith =>
      CopyWith$Mutation$StopService$services$stopService(this, (i) => i);
}

abstract class CopyWith$Mutation$StopService$services$stopService<TRes> {
  factory CopyWith$Mutation$StopService$services$stopService(
    Mutation$StopService$services$stopService instance,
    TRes Function(Mutation$StopService$services$stopService) then,
  ) = _CopyWithImpl$Mutation$StopService$services$stopService;

  factory CopyWith$Mutation$StopService$services$stopService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StopService$services$stopService;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$StopService$services$stopService<TRes>
    implements CopyWith$Mutation$StopService$services$stopService<TRes> {
  _CopyWithImpl$Mutation$StopService$services$stopService(
    this._instance,
    this._then,
  );

  final Mutation$StopService$services$stopService _instance;

  final TRes Function(Mutation$StopService$services$stopService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$StopService$services$stopService(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Mutation$StopService$services$stopService<TRes>
    implements CopyWith$Mutation$StopService$services$stopService<TRes> {
  _CopyWithStubImpl$Mutation$StopService$services$stopService(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

class Variables$Mutation$StartService {
  factory Variables$Mutation$StartService({required String serviceId}) =>
      Variables$Mutation$StartService._({r'serviceId': serviceId});

  Variables$Mutation$StartService._(this._$data);

  factory Variables$Mutation$StartService.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$serviceId = data['serviceId'];
    result$data['serviceId'] = (l$serviceId as String);
    return Variables$Mutation$StartService._(result$data);
  }

  Map<String, dynamic> _$data;

  String get serviceId => (_$data['serviceId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$serviceId = serviceId;
    result$data['serviceId'] = l$serviceId;
    return result$data;
  }

  CopyWith$Variables$Mutation$StartService<Variables$Mutation$StartService>
  get copyWith => CopyWith$Variables$Mutation$StartService(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$StartService ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$serviceId = serviceId;
    final lOther$serviceId = other.serviceId;
    if (l$serviceId != lOther$serviceId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$serviceId = serviceId;
    return Object.hashAll([l$serviceId]);
  }
}

abstract class CopyWith$Variables$Mutation$StartService<TRes> {
  factory CopyWith$Variables$Mutation$StartService(
    Variables$Mutation$StartService instance,
    TRes Function(Variables$Mutation$StartService) then,
  ) = _CopyWithImpl$Variables$Mutation$StartService;

  factory CopyWith$Variables$Mutation$StartService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$StartService;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$StartService<TRes>
    implements CopyWith$Variables$Mutation$StartService<TRes> {
  _CopyWithImpl$Variables$Mutation$StartService(this._instance, this._then);

  final Variables$Mutation$StartService _instance;

  final TRes Function(Variables$Mutation$StartService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? serviceId = _undefined}) => _then(
    Variables$Mutation$StartService._({
      ..._instance._$data,
      if (serviceId != _undefined && serviceId != null)
        'serviceId': (serviceId as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$StartService<TRes>
    implements CopyWith$Variables$Mutation$StartService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$StartService(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

class Mutation$StartService {
  Mutation$StartService({
    required this.services,
    this.$__typename = 'Mutation',
  });

  factory Mutation$StartService.fromJson(Map<String, dynamic> json) {
    final l$services = json['services'];
    final l$$__typename = json['__typename'];
    return Mutation$StartService(
      services: Mutation$StartService$services.fromJson(
        (l$services as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$StartService$services services;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$services = services;
    _resultData['services'] = l$services.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$services = services;
    final l$$__typename = $__typename;
    return Object.hashAll([l$services, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$StartService || runtimeType != other.runtimeType) {
      return false;
    }
    final l$services = services;
    final lOther$services = other.services;
    if (l$services != lOther$services) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$StartService on Mutation$StartService {
  CopyWith$Mutation$StartService<Mutation$StartService> get copyWith =>
      CopyWith$Mutation$StartService(this, (i) => i);
}

abstract class CopyWith$Mutation$StartService<TRes> {
  factory CopyWith$Mutation$StartService(
    Mutation$StartService instance,
    TRes Function(Mutation$StartService) then,
  ) = _CopyWithImpl$Mutation$StartService;

  factory CopyWith$Mutation$StartService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StartService;

  TRes call({Mutation$StartService$services? services, String? $__typename});
  CopyWith$Mutation$StartService$services<TRes> get services;
}

class _CopyWithImpl$Mutation$StartService<TRes>
    implements CopyWith$Mutation$StartService<TRes> {
  _CopyWithImpl$Mutation$StartService(this._instance, this._then);

  final Mutation$StartService _instance;

  final TRes Function(Mutation$StartService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? services = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$StartService(
      services:
          services == _undefined || services == null
              ? _instance.services
              : (services as Mutation$StartService$services),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$StartService$services<TRes> get services {
    final local$services = _instance.services;
    return CopyWith$Mutation$StartService$services(
      local$services,
      (e) => call(services: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$StartService<TRes>
    implements CopyWith$Mutation$StartService<TRes> {
  _CopyWithStubImpl$Mutation$StartService(this._res);

  TRes _res;

  call({Mutation$StartService$services? services, String? $__typename}) => _res;

  CopyWith$Mutation$StartService$services<TRes> get services =>
      CopyWith$Mutation$StartService$services.stub(_res);
}

const documentNodeMutationStartService = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'StartService'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'serviceId')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'services'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'startService'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'serviceId'),
                      value: VariableNode(name: NameNode(value: 'serviceId')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'basicMutationReturnFields'),
                        directives: [],
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionbasicMutationReturnFields,
  ],
);
Mutation$StartService _parserFn$Mutation$StartService(
  Map<String, dynamic> data,
) => Mutation$StartService.fromJson(data);
typedef OnMutationCompleted$Mutation$StartService =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$StartService?);

class Options$Mutation$StartService
    extends graphql.MutationOptions<Mutation$StartService> {
  Options$Mutation$StartService({
    String? operationName,
    required Variables$Mutation$StartService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$StartService? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$StartService? onCompleted,
    graphql.OnMutationUpdate<Mutation$StartService>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null ? null : _parserFn$Mutation$StartService(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationStartService,
         parserFn: _parserFn$Mutation$StartService,
       );

  final OnMutationCompleted$Mutation$StartService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$StartService
    extends graphql.WatchQueryOptions<Mutation$StartService> {
  WatchOptions$Mutation$StartService({
    String? operationName,
    required Variables$Mutation$StartService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$StartService? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationStartService,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$StartService,
       );
}

extension ClientExtension$Mutation$StartService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$StartService>> mutate$StartService(
    Options$Mutation$StartService options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$StartService> watchMutation$StartService(
    WatchOptions$Mutation$StartService options,
  ) => this.watchMutation(options);
}

class Mutation$StartService$services {
  Mutation$StartService$services({
    required this.startService,
    this.$__typename = 'ServicesMutations',
  });

  factory Mutation$StartService$services.fromJson(Map<String, dynamic> json) {
    final l$startService = json['startService'];
    final l$$__typename = json['__typename'];
    return Mutation$StartService$services(
      startService: Mutation$StartService$services$startService.fromJson(
        (l$startService as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$StartService$services$startService startService;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$startService = startService;
    _resultData['startService'] = l$startService.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$startService = startService;
    final l$$__typename = $__typename;
    return Object.hashAll([l$startService, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$StartService$services ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$startService = startService;
    final lOther$startService = other.startService;
    if (l$startService != lOther$startService) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$StartService$services
    on Mutation$StartService$services {
  CopyWith$Mutation$StartService$services<Mutation$StartService$services>
  get copyWith => CopyWith$Mutation$StartService$services(this, (i) => i);
}

abstract class CopyWith$Mutation$StartService$services<TRes> {
  factory CopyWith$Mutation$StartService$services(
    Mutation$StartService$services instance,
    TRes Function(Mutation$StartService$services) then,
  ) = _CopyWithImpl$Mutation$StartService$services;

  factory CopyWith$Mutation$StartService$services.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StartService$services;

  TRes call({
    Mutation$StartService$services$startService? startService,
    String? $__typename,
  });
  CopyWith$Mutation$StartService$services$startService<TRes> get startService;
}

class _CopyWithImpl$Mutation$StartService$services<TRes>
    implements CopyWith$Mutation$StartService$services<TRes> {
  _CopyWithImpl$Mutation$StartService$services(this._instance, this._then);

  final Mutation$StartService$services _instance;

  final TRes Function(Mutation$StartService$services) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? startService = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$StartService$services(
      startService:
          startService == _undefined || startService == null
              ? _instance.startService
              : (startService as Mutation$StartService$services$startService),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$StartService$services$startService<TRes> get startService {
    final local$startService = _instance.startService;
    return CopyWith$Mutation$StartService$services$startService(
      local$startService,
      (e) => call(startService: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$StartService$services<TRes>
    implements CopyWith$Mutation$StartService$services<TRes> {
  _CopyWithStubImpl$Mutation$StartService$services(this._res);

  TRes _res;

  call({
    Mutation$StartService$services$startService? startService,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$StartService$services$startService<TRes> get startService =>
      CopyWith$Mutation$StartService$services$startService.stub(_res);
}

class Mutation$StartService$services$startService
    implements Fragment$basicMutationReturnFields$$ServiceMutationReturn {
  Mutation$StartService$services$startService({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ServiceMutationReturn',
  });

  factory Mutation$StartService$services$startService.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$StartService$services$startService(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    return Object.hashAll([l$code, l$message, l$success, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$StartService$services$startService ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$StartService$services$startService
    on Mutation$StartService$services$startService {
  CopyWith$Mutation$StartService$services$startService<
    Mutation$StartService$services$startService
  >
  get copyWith =>
      CopyWith$Mutation$StartService$services$startService(this, (i) => i);
}

abstract class CopyWith$Mutation$StartService$services$startService<TRes> {
  factory CopyWith$Mutation$StartService$services$startService(
    Mutation$StartService$services$startService instance,
    TRes Function(Mutation$StartService$services$startService) then,
  ) = _CopyWithImpl$Mutation$StartService$services$startService;

  factory CopyWith$Mutation$StartService$services$startService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$StartService$services$startService;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$StartService$services$startService<TRes>
    implements CopyWith$Mutation$StartService$services$startService<TRes> {
  _CopyWithImpl$Mutation$StartService$services$startService(
    this._instance,
    this._then,
  );

  final Mutation$StartService$services$startService _instance;

  final TRes Function(Mutation$StartService$services$startService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$StartService$services$startService(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Mutation$StartService$services$startService<TRes>
    implements CopyWith$Mutation$StartService$services$startService<TRes> {
  _CopyWithStubImpl$Mutation$StartService$services$startService(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

class Variables$Mutation$RestartService {
  factory Variables$Mutation$RestartService({required String serviceId}) =>
      Variables$Mutation$RestartService._({r'serviceId': serviceId});

  Variables$Mutation$RestartService._(this._$data);

  factory Variables$Mutation$RestartService.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$serviceId = data['serviceId'];
    result$data['serviceId'] = (l$serviceId as String);
    return Variables$Mutation$RestartService._(result$data);
  }

  Map<String, dynamic> _$data;

  String get serviceId => (_$data['serviceId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$serviceId = serviceId;
    result$data['serviceId'] = l$serviceId;
    return result$data;
  }

  CopyWith$Variables$Mutation$RestartService<Variables$Mutation$RestartService>
  get copyWith => CopyWith$Variables$Mutation$RestartService(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$RestartService ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$serviceId = serviceId;
    final lOther$serviceId = other.serviceId;
    if (l$serviceId != lOther$serviceId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$serviceId = serviceId;
    return Object.hashAll([l$serviceId]);
  }
}

abstract class CopyWith$Variables$Mutation$RestartService<TRes> {
  factory CopyWith$Variables$Mutation$RestartService(
    Variables$Mutation$RestartService instance,
    TRes Function(Variables$Mutation$RestartService) then,
  ) = _CopyWithImpl$Variables$Mutation$RestartService;

  factory CopyWith$Variables$Mutation$RestartService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$RestartService;

  TRes call({String? serviceId});
}

class _CopyWithImpl$Variables$Mutation$RestartService<TRes>
    implements CopyWith$Variables$Mutation$RestartService<TRes> {
  _CopyWithImpl$Variables$Mutation$RestartService(this._instance, this._then);

  final Variables$Mutation$RestartService _instance;

  final TRes Function(Variables$Mutation$RestartService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? serviceId = _undefined}) => _then(
    Variables$Mutation$RestartService._({
      ..._instance._$data,
      if (serviceId != _undefined && serviceId != null)
        'serviceId': (serviceId as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$RestartService<TRes>
    implements CopyWith$Variables$Mutation$RestartService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$RestartService(this._res);

  TRes _res;

  call({String? serviceId}) => _res;
}

class Mutation$RestartService {
  Mutation$RestartService({
    required this.services,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RestartService.fromJson(Map<String, dynamic> json) {
    final l$services = json['services'];
    final l$$__typename = json['__typename'];
    return Mutation$RestartService(
      services: Mutation$RestartService$services.fromJson(
        (l$services as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$RestartService$services services;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$services = services;
    _resultData['services'] = l$services.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$services = services;
    final l$$__typename = $__typename;
    return Object.hashAll([l$services, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$RestartService || runtimeType != other.runtimeType) {
      return false;
    }
    final l$services = services;
    final lOther$services = other.services;
    if (l$services != lOther$services) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$RestartService on Mutation$RestartService {
  CopyWith$Mutation$RestartService<Mutation$RestartService> get copyWith =>
      CopyWith$Mutation$RestartService(this, (i) => i);
}

abstract class CopyWith$Mutation$RestartService<TRes> {
  factory CopyWith$Mutation$RestartService(
    Mutation$RestartService instance,
    TRes Function(Mutation$RestartService) then,
  ) = _CopyWithImpl$Mutation$RestartService;

  factory CopyWith$Mutation$RestartService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RestartService;

  TRes call({Mutation$RestartService$services? services, String? $__typename});
  CopyWith$Mutation$RestartService$services<TRes> get services;
}

class _CopyWithImpl$Mutation$RestartService<TRes>
    implements CopyWith$Mutation$RestartService<TRes> {
  _CopyWithImpl$Mutation$RestartService(this._instance, this._then);

  final Mutation$RestartService _instance;

  final TRes Function(Mutation$RestartService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? services = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$RestartService(
      services:
          services == _undefined || services == null
              ? _instance.services
              : (services as Mutation$RestartService$services),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$RestartService$services<TRes> get services {
    final local$services = _instance.services;
    return CopyWith$Mutation$RestartService$services(
      local$services,
      (e) => call(services: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$RestartService<TRes>
    implements CopyWith$Mutation$RestartService<TRes> {
  _CopyWithStubImpl$Mutation$RestartService(this._res);

  TRes _res;

  call({Mutation$RestartService$services? services, String? $__typename}) =>
      _res;

  CopyWith$Mutation$RestartService$services<TRes> get services =>
      CopyWith$Mutation$RestartService$services.stub(_res);
}

const documentNodeMutationRestartService = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RestartService'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'serviceId')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'services'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'restartService'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'serviceId'),
                      value: VariableNode(name: NameNode(value: 'serviceId')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'basicMutationReturnFields'),
                        directives: [],
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionbasicMutationReturnFields,
  ],
);
Mutation$RestartService _parserFn$Mutation$RestartService(
  Map<String, dynamic> data,
) => Mutation$RestartService.fromJson(data);
typedef OnMutationCompleted$Mutation$RestartService =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$RestartService?);

class Options$Mutation$RestartService
    extends graphql.MutationOptions<Mutation$RestartService> {
  Options$Mutation$RestartService({
    String? operationName,
    required Variables$Mutation$RestartService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RestartService? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$RestartService? onCompleted,
    graphql.OnMutationUpdate<Mutation$RestartService>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null
                       ? null
                       : _parserFn$Mutation$RestartService(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationRestartService,
         parserFn: _parserFn$Mutation$RestartService,
       );

  final OnMutationCompleted$Mutation$RestartService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$RestartService
    extends graphql.WatchQueryOptions<Mutation$RestartService> {
  WatchOptions$Mutation$RestartService({
    String? operationName,
    required Variables$Mutation$RestartService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$RestartService? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationRestartService,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$RestartService,
       );
}

extension ClientExtension$Mutation$RestartService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$RestartService>> mutate$RestartService(
    Options$Mutation$RestartService options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$RestartService> watchMutation$RestartService(
    WatchOptions$Mutation$RestartService options,
  ) => this.watchMutation(options);
}

class Mutation$RestartService$services {
  Mutation$RestartService$services({
    required this.restartService,
    this.$__typename = 'ServicesMutations',
  });

  factory Mutation$RestartService$services.fromJson(Map<String, dynamic> json) {
    final l$restartService = json['restartService'];
    final l$$__typename = json['__typename'];
    return Mutation$RestartService$services(
      restartService: Mutation$RestartService$services$restartService.fromJson(
        (l$restartService as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$RestartService$services$restartService restartService;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$restartService = restartService;
    _resultData['restartService'] = l$restartService.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$restartService = restartService;
    final l$$__typename = $__typename;
    return Object.hashAll([l$restartService, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$RestartService$services ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$restartService = restartService;
    final lOther$restartService = other.restartService;
    if (l$restartService != lOther$restartService) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$RestartService$services
    on Mutation$RestartService$services {
  CopyWith$Mutation$RestartService$services<Mutation$RestartService$services>
  get copyWith => CopyWith$Mutation$RestartService$services(this, (i) => i);
}

abstract class CopyWith$Mutation$RestartService$services<TRes> {
  factory CopyWith$Mutation$RestartService$services(
    Mutation$RestartService$services instance,
    TRes Function(Mutation$RestartService$services) then,
  ) = _CopyWithImpl$Mutation$RestartService$services;

  factory CopyWith$Mutation$RestartService$services.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RestartService$services;

  TRes call({
    Mutation$RestartService$services$restartService? restartService,
    String? $__typename,
  });
  CopyWith$Mutation$RestartService$services$restartService<TRes>
  get restartService;
}

class _CopyWithImpl$Mutation$RestartService$services<TRes>
    implements CopyWith$Mutation$RestartService$services<TRes> {
  _CopyWithImpl$Mutation$RestartService$services(this._instance, this._then);

  final Mutation$RestartService$services _instance;

  final TRes Function(Mutation$RestartService$services) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? restartService = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$RestartService$services(
      restartService:
          restartService == _undefined || restartService == null
              ? _instance.restartService
              : (restartService
                  as Mutation$RestartService$services$restartService),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$RestartService$services$restartService<TRes>
  get restartService {
    final local$restartService = _instance.restartService;
    return CopyWith$Mutation$RestartService$services$restartService(
      local$restartService,
      (e) => call(restartService: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$RestartService$services<TRes>
    implements CopyWith$Mutation$RestartService$services<TRes> {
  _CopyWithStubImpl$Mutation$RestartService$services(this._res);

  TRes _res;

  call({
    Mutation$RestartService$services$restartService? restartService,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$RestartService$services$restartService<TRes>
  get restartService =>
      CopyWith$Mutation$RestartService$services$restartService.stub(_res);
}

class Mutation$RestartService$services$restartService
    implements Fragment$basicMutationReturnFields$$ServiceMutationReturn {
  Mutation$RestartService$services$restartService({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ServiceMutationReturn',
  });

  factory Mutation$RestartService$services$restartService.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$RestartService$services$restartService(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    return Object.hashAll([l$code, l$message, l$success, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$RestartService$services$restartService ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$RestartService$services$restartService
    on Mutation$RestartService$services$restartService {
  CopyWith$Mutation$RestartService$services$restartService<
    Mutation$RestartService$services$restartService
  >
  get copyWith =>
      CopyWith$Mutation$RestartService$services$restartService(this, (i) => i);
}

abstract class CopyWith$Mutation$RestartService$services$restartService<TRes> {
  factory CopyWith$Mutation$RestartService$services$restartService(
    Mutation$RestartService$services$restartService instance,
    TRes Function(Mutation$RestartService$services$restartService) then,
  ) = _CopyWithImpl$Mutation$RestartService$services$restartService;

  factory CopyWith$Mutation$RestartService$services$restartService.stub(
    TRes res,
  ) = _CopyWithStubImpl$Mutation$RestartService$services$restartService;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$RestartService$services$restartService<TRes>
    implements CopyWith$Mutation$RestartService$services$restartService<TRes> {
  _CopyWithImpl$Mutation$RestartService$services$restartService(
    this._instance,
    this._then,
  );

  final Mutation$RestartService$services$restartService _instance;

  final TRes Function(Mutation$RestartService$services$restartService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$RestartService$services$restartService(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Mutation$RestartService$services$restartService<TRes>
    implements CopyWith$Mutation$RestartService$services$restartService<TRes> {
  _CopyWithStubImpl$Mutation$RestartService$services$restartService(this._res);

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}

class Variables$Mutation$MoveService {
  factory Variables$Mutation$MoveService({
    required Input$MoveServiceInput input,
  }) => Variables$Mutation$MoveService._({r'input': input});

  Variables$Mutation$MoveService._(this._$data);

  factory Variables$Mutation$MoveService.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$MoveServiceInput.fromJson(
      (l$input as Map<String, dynamic>),
    );
    return Variables$Mutation$MoveService._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$MoveServiceInput get input =>
      (_$data['input'] as Input$MoveServiceInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$MoveService<Variables$Mutation$MoveService>
  get copyWith => CopyWith$Variables$Mutation$MoveService(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$MoveService ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$MoveService<TRes> {
  factory CopyWith$Variables$Mutation$MoveService(
    Variables$Mutation$MoveService instance,
    TRes Function(Variables$Mutation$MoveService) then,
  ) = _CopyWithImpl$Variables$Mutation$MoveService;

  factory CopyWith$Variables$Mutation$MoveService.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$MoveService;

  TRes call({Input$MoveServiceInput? input});
}

class _CopyWithImpl$Variables$Mutation$MoveService<TRes>
    implements CopyWith$Variables$Mutation$MoveService<TRes> {
  _CopyWithImpl$Variables$Mutation$MoveService(this._instance, this._then);

  final Variables$Mutation$MoveService _instance;

  final TRes Function(Variables$Mutation$MoveService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) => _then(
    Variables$Mutation$MoveService._({
      ..._instance._$data,
      if (input != _undefined && input != null)
        'input': (input as Input$MoveServiceInput),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$MoveService<TRes>
    implements CopyWith$Variables$Mutation$MoveService<TRes> {
  _CopyWithStubImpl$Variables$Mutation$MoveService(this._res);

  TRes _res;

  call({Input$MoveServiceInput? input}) => _res;
}

class Mutation$MoveService {
  Mutation$MoveService({required this.services, this.$__typename = 'Mutation'});

  factory Mutation$MoveService.fromJson(Map<String, dynamic> json) {
    final l$services = json['services'];
    final l$$__typename = json['__typename'];
    return Mutation$MoveService(
      services: Mutation$MoveService$services.fromJson(
        (l$services as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$MoveService$services services;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$services = services;
    _resultData['services'] = l$services.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$services = services;
    final l$$__typename = $__typename;
    return Object.hashAll([l$services, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$MoveService || runtimeType != other.runtimeType) {
      return false;
    }
    final l$services = services;
    final lOther$services = other.services;
    if (l$services != lOther$services) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$MoveService on Mutation$MoveService {
  CopyWith$Mutation$MoveService<Mutation$MoveService> get copyWith =>
      CopyWith$Mutation$MoveService(this, (i) => i);
}

abstract class CopyWith$Mutation$MoveService<TRes> {
  factory CopyWith$Mutation$MoveService(
    Mutation$MoveService instance,
    TRes Function(Mutation$MoveService) then,
  ) = _CopyWithImpl$Mutation$MoveService;

  factory CopyWith$Mutation$MoveService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MoveService;

  TRes call({Mutation$MoveService$services? services, String? $__typename});
  CopyWith$Mutation$MoveService$services<TRes> get services;
}

class _CopyWithImpl$Mutation$MoveService<TRes>
    implements CopyWith$Mutation$MoveService<TRes> {
  _CopyWithImpl$Mutation$MoveService(this._instance, this._then);

  final Mutation$MoveService _instance;

  final TRes Function(Mutation$MoveService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? services = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$MoveService(
      services:
          services == _undefined || services == null
              ? _instance.services
              : (services as Mutation$MoveService$services),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$MoveService$services<TRes> get services {
    final local$services = _instance.services;
    return CopyWith$Mutation$MoveService$services(
      local$services,
      (e) => call(services: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$MoveService<TRes>
    implements CopyWith$Mutation$MoveService<TRes> {
  _CopyWithStubImpl$Mutation$MoveService(this._res);

  TRes _res;

  call({Mutation$MoveService$services? services, String? $__typename}) => _res;

  CopyWith$Mutation$MoveService$services<TRes> get services =>
      CopyWith$Mutation$MoveService$services.stub(_res);
}

const documentNodeMutationMoveService = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'MoveService'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'input')),
          type: NamedTypeNode(
            name: NameNode(value: 'MoveServiceInput'),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'services'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'moveService'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'input'),
                      value: VariableNode(name: NameNode(value: 'input')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'basicMutationReturnFields'),
                        directives: [],
                      ),
                      FieldNode(
                        name: NameNode(value: 'job'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FragmentSpreadNode(
                              name: NameNode(value: 'basicApiJobsFields'),
                              directives: [],
                            ),
                            FieldNode(
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionbasicMutationReturnFields,
    fragmentDefinitionbasicApiJobsFields,
  ],
);
Mutation$MoveService _parserFn$Mutation$MoveService(
  Map<String, dynamic> data,
) => Mutation$MoveService.fromJson(data);
typedef OnMutationCompleted$Mutation$MoveService =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$MoveService?);

class Options$Mutation$MoveService
    extends graphql.MutationOptions<Mutation$MoveService> {
  Options$Mutation$MoveService({
    String? operationName,
    required Variables$Mutation$MoveService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$MoveService? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$MoveService? onCompleted,
    graphql.OnMutationUpdate<Mutation$MoveService>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null ? null : _parserFn$Mutation$MoveService(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationMoveService,
         parserFn: _parserFn$Mutation$MoveService,
       );

  final OnMutationCompleted$Mutation$MoveService? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$MoveService
    extends graphql.WatchQueryOptions<Mutation$MoveService> {
  WatchOptions$Mutation$MoveService({
    String? operationName,
    required Variables$Mutation$MoveService variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$MoveService? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationMoveService,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$MoveService,
       );
}

extension ClientExtension$Mutation$MoveService on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$MoveService>> mutate$MoveService(
    Options$Mutation$MoveService options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$MoveService> watchMutation$MoveService(
    WatchOptions$Mutation$MoveService options,
  ) => this.watchMutation(options);
}

class Mutation$MoveService$services {
  Mutation$MoveService$services({
    required this.moveService,
    this.$__typename = 'ServicesMutations',
  });

  factory Mutation$MoveService$services.fromJson(Map<String, dynamic> json) {
    final l$moveService = json['moveService'];
    final l$$__typename = json['__typename'];
    return Mutation$MoveService$services(
      moveService: Mutation$MoveService$services$moveService.fromJson(
        (l$moveService as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$MoveService$services$moveService moveService;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$moveService = moveService;
    _resultData['moveService'] = l$moveService.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$moveService = moveService;
    final l$$__typename = $__typename;
    return Object.hashAll([l$moveService, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$MoveService$services ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$moveService = moveService;
    final lOther$moveService = other.moveService;
    if (l$moveService != lOther$moveService) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$MoveService$services
    on Mutation$MoveService$services {
  CopyWith$Mutation$MoveService$services<Mutation$MoveService$services>
  get copyWith => CopyWith$Mutation$MoveService$services(this, (i) => i);
}

abstract class CopyWith$Mutation$MoveService$services<TRes> {
  factory CopyWith$Mutation$MoveService$services(
    Mutation$MoveService$services instance,
    TRes Function(Mutation$MoveService$services) then,
  ) = _CopyWithImpl$Mutation$MoveService$services;

  factory CopyWith$Mutation$MoveService$services.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MoveService$services;

  TRes call({
    Mutation$MoveService$services$moveService? moveService,
    String? $__typename,
  });
  CopyWith$Mutation$MoveService$services$moveService<TRes> get moveService;
}

class _CopyWithImpl$Mutation$MoveService$services<TRes>
    implements CopyWith$Mutation$MoveService$services<TRes> {
  _CopyWithImpl$Mutation$MoveService$services(this._instance, this._then);

  final Mutation$MoveService$services _instance;

  final TRes Function(Mutation$MoveService$services) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? moveService = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$MoveService$services(
      moveService:
          moveService == _undefined || moveService == null
              ? _instance.moveService
              : (moveService as Mutation$MoveService$services$moveService),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$MoveService$services$moveService<TRes> get moveService {
    final local$moveService = _instance.moveService;
    return CopyWith$Mutation$MoveService$services$moveService(
      local$moveService,
      (e) => call(moveService: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$MoveService$services<TRes>
    implements CopyWith$Mutation$MoveService$services<TRes> {
  _CopyWithStubImpl$Mutation$MoveService$services(this._res);

  TRes _res;

  call({
    Mutation$MoveService$services$moveService? moveService,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$MoveService$services$moveService<TRes> get moveService =>
      CopyWith$Mutation$MoveService$services$moveService.stub(_res);
}

class Mutation$MoveService$services$moveService
    implements Fragment$basicMutationReturnFields$$ServiceJobMutationReturn {
  Mutation$MoveService$services$moveService({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ServiceJobMutationReturn',
    this.job,
  });

  factory Mutation$MoveService$services$moveService.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    final l$job = json['job'];
    return Mutation$MoveService$services$moveService(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
      job:
          l$job == null
              ? null
              : Fragment$basicApiJobsFields.fromJson(
                (l$job as Map<String, dynamic>),
              ),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  final Fragment$basicApiJobsFields? job;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    final l$job = job;
    _resultData['job'] = l$job?.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    final l$job = job;
    return Object.hashAll([l$code, l$message, l$success, l$$__typename, l$job]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$MoveService$services$moveService ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    final l$job = job;
    final lOther$job = other.job;
    if (l$job != lOther$job) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$MoveService$services$moveService
    on Mutation$MoveService$services$moveService {
  CopyWith$Mutation$MoveService$services$moveService<
    Mutation$MoveService$services$moveService
  >
  get copyWith =>
      CopyWith$Mutation$MoveService$services$moveService(this, (i) => i);
}

abstract class CopyWith$Mutation$MoveService$services$moveService<TRes> {
  factory CopyWith$Mutation$MoveService$services$moveService(
    Mutation$MoveService$services$moveService instance,
    TRes Function(Mutation$MoveService$services$moveService) then,
  ) = _CopyWithImpl$Mutation$MoveService$services$moveService;

  factory CopyWith$Mutation$MoveService$services$moveService.stub(TRes res) =
      _CopyWithStubImpl$Mutation$MoveService$services$moveService;

  TRes call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$basicApiJobsFields? job,
  });
  CopyWith$Fragment$basicApiJobsFields<TRes> get job;
}

class _CopyWithImpl$Mutation$MoveService$services$moveService<TRes>
    implements CopyWith$Mutation$MoveService$services$moveService<TRes> {
  _CopyWithImpl$Mutation$MoveService$services$moveService(
    this._instance,
    this._then,
  );

  final Mutation$MoveService$services$moveService _instance;

  final TRes Function(Mutation$MoveService$services$moveService) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
    Object? job = _undefined,
  }) => _then(
    Mutation$MoveService$services$moveService(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
      job:
          job == _undefined
              ? _instance.job
              : (job as Fragment$basicApiJobsFields?),
    ),
  );

  CopyWith$Fragment$basicApiJobsFields<TRes> get job {
    final local$job = _instance.job;
    return local$job == null
        ? CopyWith$Fragment$basicApiJobsFields.stub(_then(_instance))
        : CopyWith$Fragment$basicApiJobsFields(local$job, (e) => call(job: e));
  }
}

class _CopyWithStubImpl$Mutation$MoveService$services$moveService<TRes>
    implements CopyWith$Mutation$MoveService$services$moveService<TRes> {
  _CopyWithStubImpl$Mutation$MoveService$services$moveService(this._res);

  TRes _res;

  call({
    int? code,
    String? message,
    bool? success,
    String? $__typename,
    Fragment$basicApiJobsFields? job,
  }) => _res;

  CopyWith$Fragment$basicApiJobsFields<TRes> get job =>
      CopyWith$Fragment$basicApiJobsFields.stub(_res);
}

class Variables$Mutation$SetServiceConfiguration {
  factory Variables$Mutation$SetServiceConfiguration({
    required Input$SetServiceConfigurationInput input,
  }) => Variables$Mutation$SetServiceConfiguration._({r'input': input});

  Variables$Mutation$SetServiceConfiguration._(this._$data);

  factory Variables$Mutation$SetServiceConfiguration.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$SetServiceConfigurationInput.fromJson(
      (l$input as Map<String, dynamic>),
    );
    return Variables$Mutation$SetServiceConfiguration._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$SetServiceConfigurationInput get input =>
      (_$data['input'] as Input$SetServiceConfigurationInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$SetServiceConfiguration<
    Variables$Mutation$SetServiceConfiguration
  >
  get copyWith =>
      CopyWith$Variables$Mutation$SetServiceConfiguration(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$SetServiceConfiguration ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$SetServiceConfiguration<TRes> {
  factory CopyWith$Variables$Mutation$SetServiceConfiguration(
    Variables$Mutation$SetServiceConfiguration instance,
    TRes Function(Variables$Mutation$SetServiceConfiguration) then,
  ) = _CopyWithImpl$Variables$Mutation$SetServiceConfiguration;

  factory CopyWith$Variables$Mutation$SetServiceConfiguration.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$SetServiceConfiguration;

  TRes call({Input$SetServiceConfigurationInput? input});
}

class _CopyWithImpl$Variables$Mutation$SetServiceConfiguration<TRes>
    implements CopyWith$Variables$Mutation$SetServiceConfiguration<TRes> {
  _CopyWithImpl$Variables$Mutation$SetServiceConfiguration(
    this._instance,
    this._then,
  );

  final Variables$Mutation$SetServiceConfiguration _instance;

  final TRes Function(Variables$Mutation$SetServiceConfiguration) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) => _then(
    Variables$Mutation$SetServiceConfiguration._({
      ..._instance._$data,
      if (input != _undefined && input != null)
        'input': (input as Input$SetServiceConfigurationInput),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$SetServiceConfiguration<TRes>
    implements CopyWith$Variables$Mutation$SetServiceConfiguration<TRes> {
  _CopyWithStubImpl$Variables$Mutation$SetServiceConfiguration(this._res);

  TRes _res;

  call({Input$SetServiceConfigurationInput? input}) => _res;
}

class Mutation$SetServiceConfiguration {
  Mutation$SetServiceConfiguration({
    required this.services,
    this.$__typename = 'Mutation',
  });

  factory Mutation$SetServiceConfiguration.fromJson(Map<String, dynamic> json) {
    final l$services = json['services'];
    final l$$__typename = json['__typename'];
    return Mutation$SetServiceConfiguration(
      services: Mutation$SetServiceConfiguration$services.fromJson(
        (l$services as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$SetServiceConfiguration$services services;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$services = services;
    _resultData['services'] = l$services.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$services = services;
    final l$$__typename = $__typename;
    return Object.hashAll([l$services, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$SetServiceConfiguration ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$services = services;
    final lOther$services = other.services;
    if (l$services != lOther$services) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$SetServiceConfiguration
    on Mutation$SetServiceConfiguration {
  CopyWith$Mutation$SetServiceConfiguration<Mutation$SetServiceConfiguration>
  get copyWith => CopyWith$Mutation$SetServiceConfiguration(this, (i) => i);
}

abstract class CopyWith$Mutation$SetServiceConfiguration<TRes> {
  factory CopyWith$Mutation$SetServiceConfiguration(
    Mutation$SetServiceConfiguration instance,
    TRes Function(Mutation$SetServiceConfiguration) then,
  ) = _CopyWithImpl$Mutation$SetServiceConfiguration;

  factory CopyWith$Mutation$SetServiceConfiguration.stub(TRes res) =
      _CopyWithStubImpl$Mutation$SetServiceConfiguration;

  TRes call({
    Mutation$SetServiceConfiguration$services? services,
    String? $__typename,
  });
  CopyWith$Mutation$SetServiceConfiguration$services<TRes> get services;
}

class _CopyWithImpl$Mutation$SetServiceConfiguration<TRes>
    implements CopyWith$Mutation$SetServiceConfiguration<TRes> {
  _CopyWithImpl$Mutation$SetServiceConfiguration(this._instance, this._then);

  final Mutation$SetServiceConfiguration _instance;

  final TRes Function(Mutation$SetServiceConfiguration) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? services = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$SetServiceConfiguration(
      services:
          services == _undefined || services == null
              ? _instance.services
              : (services as Mutation$SetServiceConfiguration$services),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$SetServiceConfiguration$services<TRes> get services {
    final local$services = _instance.services;
    return CopyWith$Mutation$SetServiceConfiguration$services(
      local$services,
      (e) => call(services: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$SetServiceConfiguration<TRes>
    implements CopyWith$Mutation$SetServiceConfiguration<TRes> {
  _CopyWithStubImpl$Mutation$SetServiceConfiguration(this._res);

  TRes _res;

  call({
    Mutation$SetServiceConfiguration$services? services,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$SetServiceConfiguration$services<TRes> get services =>
      CopyWith$Mutation$SetServiceConfiguration$services.stub(_res);
}

const documentNodeMutationSetServiceConfiguration = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SetServiceConfiguration'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'input')),
          type: NamedTypeNode(
            name: NameNode(value: 'SetServiceConfigurationInput'),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'services'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'setServiceConfiguration'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'input'),
                      value: VariableNode(name: NameNode(value: 'input')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'basicMutationReturnFields'),
                        directives: [],
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionbasicMutationReturnFields,
  ],
);
Mutation$SetServiceConfiguration _parserFn$Mutation$SetServiceConfiguration(
  Map<String, dynamic> data,
) => Mutation$SetServiceConfiguration.fromJson(data);
typedef OnMutationCompleted$Mutation$SetServiceConfiguration =
    FutureOr<void> Function(
      Map<String, dynamic>?,
      Mutation$SetServiceConfiguration?,
    );

class Options$Mutation$SetServiceConfiguration
    extends graphql.MutationOptions<Mutation$SetServiceConfiguration> {
  Options$Mutation$SetServiceConfiguration({
    String? operationName,
    required Variables$Mutation$SetServiceConfiguration variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$SetServiceConfiguration? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$SetServiceConfiguration? onCompleted,
    graphql.OnMutationUpdate<Mutation$SetServiceConfiguration>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted:
             onCompleted == null
                 ? null
                 : (data) => onCompleted(
                   data,
                   data == null
                       ? null
                       : _parserFn$Mutation$SetServiceConfiguration(data),
                 ),
         update: update,
         onError: onError,
         document: documentNodeMutationSetServiceConfiguration,
         parserFn: _parserFn$Mutation$SetServiceConfiguration,
       );

  final OnMutationCompleted$Mutation$SetServiceConfiguration?
  onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$SetServiceConfiguration
    extends graphql.WatchQueryOptions<Mutation$SetServiceConfiguration> {
  WatchOptions$Mutation$SetServiceConfiguration({
    String? operationName,
    required Variables$Mutation$SetServiceConfiguration variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$SetServiceConfiguration? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSetServiceConfiguration,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$SetServiceConfiguration,
       );
}

extension ClientExtension$Mutation$SetServiceConfiguration
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$SetServiceConfiguration>>
  mutate$SetServiceConfiguration(
    Options$Mutation$SetServiceConfiguration options,
  ) async => await this.mutate(options);
  graphql.ObservableQuery<Mutation$SetServiceConfiguration>
  watchMutation$SetServiceConfiguration(
    WatchOptions$Mutation$SetServiceConfiguration options,
  ) => this.watchMutation(options);
}

class Mutation$SetServiceConfiguration$services {
  Mutation$SetServiceConfiguration$services({
    required this.setServiceConfiguration,
    this.$__typename = 'ServicesMutations',
  });

  factory Mutation$SetServiceConfiguration$services.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$setServiceConfiguration = json['setServiceConfiguration'];
    final l$$__typename = json['__typename'];
    return Mutation$SetServiceConfiguration$services(
      setServiceConfiguration:
          Mutation$SetServiceConfiguration$services$setServiceConfiguration.fromJson(
            (l$setServiceConfiguration as Map<String, dynamic>),
          ),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$SetServiceConfiguration$services$setServiceConfiguration
  setServiceConfiguration;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$setServiceConfiguration = setServiceConfiguration;
    _resultData['setServiceConfiguration'] = l$setServiceConfiguration.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$setServiceConfiguration = setServiceConfiguration;
    final l$$__typename = $__typename;
    return Object.hashAll([l$setServiceConfiguration, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$SetServiceConfiguration$services ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$setServiceConfiguration = setServiceConfiguration;
    final lOther$setServiceConfiguration = other.setServiceConfiguration;
    if (l$setServiceConfiguration != lOther$setServiceConfiguration) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$SetServiceConfiguration$services
    on Mutation$SetServiceConfiguration$services {
  CopyWith$Mutation$SetServiceConfiguration$services<
    Mutation$SetServiceConfiguration$services
  >
  get copyWith =>
      CopyWith$Mutation$SetServiceConfiguration$services(this, (i) => i);
}

abstract class CopyWith$Mutation$SetServiceConfiguration$services<TRes> {
  factory CopyWith$Mutation$SetServiceConfiguration$services(
    Mutation$SetServiceConfiguration$services instance,
    TRes Function(Mutation$SetServiceConfiguration$services) then,
  ) = _CopyWithImpl$Mutation$SetServiceConfiguration$services;

  factory CopyWith$Mutation$SetServiceConfiguration$services.stub(TRes res) =
      _CopyWithStubImpl$Mutation$SetServiceConfiguration$services;

  TRes call({
    Mutation$SetServiceConfiguration$services$setServiceConfiguration?
    setServiceConfiguration,
    String? $__typename,
  });
  CopyWith$Mutation$SetServiceConfiguration$services$setServiceConfiguration<
    TRes
  >
  get setServiceConfiguration;
}

class _CopyWithImpl$Mutation$SetServiceConfiguration$services<TRes>
    implements CopyWith$Mutation$SetServiceConfiguration$services<TRes> {
  _CopyWithImpl$Mutation$SetServiceConfiguration$services(
    this._instance,
    this._then,
  );

  final Mutation$SetServiceConfiguration$services _instance;

  final TRes Function(Mutation$SetServiceConfiguration$services) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? setServiceConfiguration = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$SetServiceConfiguration$services(
      setServiceConfiguration:
          setServiceConfiguration == _undefined ||
                  setServiceConfiguration == null
              ? _instance.setServiceConfiguration
              : (setServiceConfiguration
                  as Mutation$SetServiceConfiguration$services$setServiceConfiguration),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );

  CopyWith$Mutation$SetServiceConfiguration$services$setServiceConfiguration<
    TRes
  >
  get setServiceConfiguration {
    final local$setServiceConfiguration = _instance.setServiceConfiguration;
    return CopyWith$Mutation$SetServiceConfiguration$services$setServiceConfiguration(
      local$setServiceConfiguration,
      (e) => call(setServiceConfiguration: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$SetServiceConfiguration$services<TRes>
    implements CopyWith$Mutation$SetServiceConfiguration$services<TRes> {
  _CopyWithStubImpl$Mutation$SetServiceConfiguration$services(this._res);

  TRes _res;

  call({
    Mutation$SetServiceConfiguration$services$setServiceConfiguration?
    setServiceConfiguration,
    String? $__typename,
  }) => _res;

  CopyWith$Mutation$SetServiceConfiguration$services$setServiceConfiguration<
    TRes
  >
  get setServiceConfiguration =>
      CopyWith$Mutation$SetServiceConfiguration$services$setServiceConfiguration.stub(
        _res,
      );
}

class Mutation$SetServiceConfiguration$services$setServiceConfiguration
    implements Fragment$basicMutationReturnFields$$ServiceMutationReturn {
  Mutation$SetServiceConfiguration$services$setServiceConfiguration({
    required this.code,
    required this.message,
    required this.success,
    this.$__typename = 'ServiceMutationReturn',
  });

  factory Mutation$SetServiceConfiguration$services$setServiceConfiguration.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$code = json['code'];
    final l$message = json['message'];
    final l$success = json['success'];
    final l$$__typename = json['__typename'];
    return Mutation$SetServiceConfiguration$services$setServiceConfiguration(
      code: (l$code as int),
      message: (l$message as String),
      success: (l$success as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final int code;

  final String message;

  final bool success;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$code = code;
    _resultData['code'] = l$code;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$success = success;
    _resultData['success'] = l$success;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$code = code;
    final l$message = message;
    final l$success = success;
    final l$$__typename = $__typename;
    return Object.hashAll([l$code, l$message, l$success, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other
            is! Mutation$SetServiceConfiguration$services$setServiceConfiguration ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$success = success;
    final lOther$success = other.success;
    if (l$success != lOther$success) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$SetServiceConfiguration$services$setServiceConfiguration
    on Mutation$SetServiceConfiguration$services$setServiceConfiguration {
  CopyWith$Mutation$SetServiceConfiguration$services$setServiceConfiguration<
    Mutation$SetServiceConfiguration$services$setServiceConfiguration
  >
  get copyWith =>
      CopyWith$Mutation$SetServiceConfiguration$services$setServiceConfiguration(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$SetServiceConfiguration$services$setServiceConfiguration<
  TRes
> {
  factory CopyWith$Mutation$SetServiceConfiguration$services$setServiceConfiguration(
    Mutation$SetServiceConfiguration$services$setServiceConfiguration instance,
    TRes Function(
      Mutation$SetServiceConfiguration$services$setServiceConfiguration,
    )
    then,
  ) =
      _CopyWithImpl$Mutation$SetServiceConfiguration$services$setServiceConfiguration;

  factory CopyWith$Mutation$SetServiceConfiguration$services$setServiceConfiguration.stub(
    TRes res,
  ) =
      _CopyWithStubImpl$Mutation$SetServiceConfiguration$services$setServiceConfiguration;

  TRes call({int? code, String? message, bool? success, String? $__typename});
}

class _CopyWithImpl$Mutation$SetServiceConfiguration$services$setServiceConfiguration<
  TRes
>
    implements
        CopyWith$Mutation$SetServiceConfiguration$services$setServiceConfiguration<
          TRes
        > {
  _CopyWithImpl$Mutation$SetServiceConfiguration$services$setServiceConfiguration(
    this._instance,
    this._then,
  );

  final Mutation$SetServiceConfiguration$services$setServiceConfiguration
  _instance;

  final TRes Function(
    Mutation$SetServiceConfiguration$services$setServiceConfiguration,
  )
  _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? code = _undefined,
    Object? message = _undefined,
    Object? success = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$SetServiceConfiguration$services$setServiceConfiguration(
      code: code == _undefined || code == null ? _instance.code : (code as int),
      message:
          message == _undefined || message == null
              ? _instance.message
              : (message as String),
      success:
          success == _undefined || success == null
              ? _instance.success
              : (success as bool),
      $__typename:
          $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Mutation$SetServiceConfiguration$services$setServiceConfiguration<
  TRes
>
    implements
        CopyWith$Mutation$SetServiceConfiguration$services$setServiceConfiguration<
          TRes
        > {
  _CopyWithStubImpl$Mutation$SetServiceConfiguration$services$setServiceConfiguration(
    this._res,
  );

  TRes _res;

  call({int? code, String? message, bool? success, String? $__typename}) =>
      _res;
}
