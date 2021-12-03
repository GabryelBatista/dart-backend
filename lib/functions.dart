import 'package:functions_framework/functions_framework.dart';
import 'package:shelf/shelf.dart';
import 'package:mongo_dart/mongo_dart.dart';

@CloudFunction()
Future<Response> function(Request request) async {
  var db = Db('mongodb://127.0.0.1:28017/teste/');
  await db.open();

  return Response.ok(db.databaseName);
}
