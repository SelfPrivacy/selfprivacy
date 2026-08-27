import 'package:sp_vcr/sp_vcr.dart';

const CensorPolicy backblazeCensorPolicy = CensorPolicy(
  headerKeys: <String>['Authorization'],
  jsonBodyKeys: <String>['authorizationToken', 'applicationKey'],
);
