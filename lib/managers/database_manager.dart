import 'dart:collection';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

class DatabaseManager {
  static final DatabaseManager _instance = DatabaseManager._();

  factory DatabaseManager() => _instance;

  DatabaseManager._();

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  var paginateKeys = HashMap<String, String?>();

  /// Get an object from the given location
  Future<Map<String, dynamic>> get(String path) async => jsonDecode(
      jsonEncode((await _database.ref(path).once()).snapshot.value as Map));

  /// Get a list of object and paginate it
  Future<List<Map<String, dynamic>>?> getList(String path,
      {pageSize = 30}) async {
    final lastKey = paginateKeys[path];
    if (paginateKeys.containsKey(path) && lastKey == null) return null;

    var query = _database.ref(path).orderByKey();
    if (lastKey != null) query = query.endAt(lastKey);
    final dataSnapshot = await query.limitToLast(pageSize).get();

    paginateKeys[path] = dataSnapshot.children.firstOrNull?.key;

    Map<String, dynamic> json =
        jsonDecode(jsonEncode(dataSnapshot.value as Map));
    for (var el in json.keys) {
      json[el]["uid"] = el;
    }

    return json.values.toList().cast<Map<String, dynamic>>();
  }

  /// Put an object to a given location
  Future<void> put(String path, dynamic object) async =>
      _database.ref(path).set(object);

  /// Push given object in a new child on the giving location. Returns the created key
  Future<String?> post(String path, dynamic object) async {
    final node = _database.ref(path).push();
    await node.set(object);
    return node.key;
  }
}
