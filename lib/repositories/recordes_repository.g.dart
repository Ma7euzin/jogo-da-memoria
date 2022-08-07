// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recordes_repository.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecordesRepository on RecordesRepositoryBase, Store {
  late final _$recordesRound6Atom =
      Atom(name: 'RecordesRepositoryBase.recordesRound6', context: context);

  @override
  Map<dynamic, dynamic> get recordesRound6 {
    _$recordesRound6Atom.reportRead();
    return super.recordesRound6;
  }

  @override
  set recordesRound6(Map<dynamic, dynamic> value) {
    _$recordesRound6Atom.reportWrite(value, super.recordesRound6, () {
      super.recordesRound6 = value;
    });
  }

  late final _$recordesNormalAtom =
      Atom(name: 'RecordesRepositoryBase.recordesNormal', context: context);

  @override
  Map<dynamic, dynamic> get recordesNormal {
    _$recordesNormalAtom.reportRead();
    return super.recordesNormal;
  }

  @override
  set recordesNormal(Map<dynamic, dynamic> value) {
    _$recordesNormalAtom.reportWrite(value, super.recordesNormal, () {
      super.recordesNormal = value;
    });
  }

  late final _$RecordesRepositoryBaseActionController =
      ActionController(name: 'RecordesRepositoryBase', context: context);

  @override
  dynamic loadRecordes() {
    final _$actionInfo = _$RecordesRepositoryBaseActionController.startAction(
        name: 'RecordesRepositoryBase.loadRecordes');
    try {
      return super.loadRecordes();
    } finally {
      _$RecordesRepositoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
recordesRound6: ${recordesRound6},
recordesNormal: ${recordesNormal}
    ''';
  }
}
