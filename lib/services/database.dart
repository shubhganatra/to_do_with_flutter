import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:intl/intl.dart';

class Database {
  final FirebaseFirestore firestore;

  Database({this.firestore});
  Stream<List<TodoModel>> streamIncompleteTodos({String uid}) {
    try {
      return firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .where("done", isEqualTo: false)
          .snapshots()
          .map((query) {
        final List<TodoModel> retVal = <TodoModel>[];
        for (final DocumentSnapshot doc in query.docs) {
          retVal.add(TodoModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<TodoModel>> streamCompleteTodos({String uid}) {
    try {
      return firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .where("done", isEqualTo: true)
          .snapshots()
          .map((query) {
        final List<TodoModel> retVal = <TodoModel>[];
        for (final DocumentSnapshot doc in query.docs) {
          retVal.add(TodoModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTodo(
      {String uid, String content, String formattedDate}) async {
    try {
      firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(formattedDate)
          .set({"content": content, "done": false});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTodo({String uid, String todoId, bool newValue}) async {
    try {
      firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .update({
        "done": newValue,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editTodo({String uid, String todoId, String content}) async {
    try {
      firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .update({
        "content": content,
      });
    } catch (e) {
      rethrow;
    }
  }
}
