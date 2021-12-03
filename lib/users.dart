import 'dart:convert';
import 'package:functions_framework/functions_framework.dart';
import 'package:shelf/shelf.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf_router/shelf_router.dart';

@CloudFunction()
Future<Response> users(Request request) async {
  final router = Router();

  var db = Db('mongodb://127.0.0.1:28017/teste/');
  await db.open();
  var users = db.collection('users');

  router.get('/login/<login>', (Request request, String login) async {
    List user = await users.find({'login': login}).toList();

    return Response.ok(json.encode(user));
  });

  router.post('/create', (Request request) async {
    final payload = await request.readAsString();
    Map<String, dynamic> user = json.decode(payload);
    await users.insert(user);

    return Response.ok(json.encode(user));
  });

  return router(request);
}
