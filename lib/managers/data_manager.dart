import 'package:collection/collection.dart';
import 'package:elder_care/interfaces/json_serializable.dart';
import 'package:elder_care/managers/account_manager.dart';
import 'package:elder_care/managers/database_manager.dart';
import 'package:elder_care/model/post.dart';
import 'package:elder_care/model/user.dart';

enum SaveMode { POST, PUT }

class DataManager {
  static final DataManager _instance = DataManager._();
  List<Post> posts = [];

  factory DataManager() => _instance;

  DataManager._();

  static const pageSize = 100;

  final anonymous = User();

  // Request a new page for paginated data
  loadMore() async {
    posts.addAll((await DatabaseManager().getList("posts"))
            ?.map((e) => Post.fromJson(e))
            .sorted((a, b) => a.timestamp.compareTo(b.timestamp))
            .reversed ??
        []);
  }

  // Remove the last page pointer of paginated data
  reloadPaginatedData() {
    posts = [];
    DatabaseManager().paginateKeys.clear();
  }

  /// Load a single User object from a given uid
  Future<User> loadUser(String? uid, {bool force = false}) async {
    if (!force) {
      // Is anonymous?
      if (uid == null) {
        return anonymous;
      }

      // Already cached?
      // User? cachedUser =
      //     cachedUsers.firstWhereOrNull((user) => user.uid == uid);
      // if (cachedUser != null) return cachedUser;

      // Is current User?
      if (AccountManager().user.uid == uid) return AccountManager().user;
    }

    // Ask the database for the user and caching it
    User? user = User.fromJson(await DatabaseManager().get("users/$uid"));
    user.uid = uid;
    loadUserPosts(user);
    // cachedUsers.add(user);
    return user;
  }

  /// Load the first 30 posts of a given User
  loadUserPosts(User user) async {
    user.posts.clear();
    for (String postUID in user.postsUIDs.reversed.take(30)) {
      if (user.posts.firstWhereOrNull((post) => post.uid == postUID) == null) {
        Post post = Post.fromJson(
            (await DatabaseManager().get('posts/$postUID'))
              ..addAll({'uid': postUID}));
        user.posts.add(post);
      }
    }
  }

  // Save Model objects
  save(Object model, [SaveMode mode = SaveMode.PUT]) async {
    String path = model is User
        ? "users/${mode == SaveMode.PUT ? model.uid : ''}"
        : model is Post
            ? "posts/${mode == SaveMode.PUT ? model.uid : ''}"
            : '';
    if (path == '') return;

    // Query the FirebaseRD
    if (model is JSONSerializable) {
      if (mode == SaveMode.PUT) {
        DatabaseManager().put(path, model.toJSON());
      } else {
        String? uid = await DatabaseManager().post(path, model.toJSON());
        if (uid != null) {
          // Any operations to be performed with the retrieved uid
          if (model is Post) {
            // Add the newly created post to current user's posts list
            posts.add(model);
            AccountManager().user.postsUIDs.add(uid);
            AccountManager().user.posts.add(model);
            save(AccountManager().user);
          }
        }
      }
    }
  }
}
