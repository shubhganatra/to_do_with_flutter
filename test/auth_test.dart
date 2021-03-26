import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:to_do_app/services/auth.dart';

class MockUser extends Mock implements User {}

final MockUser _mockUser = MockUser();

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable([_mockUser]);
  }
}

void main() {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final Auth auth = Auth(auth: mockFirebaseAuth);
  setUp(() {});
  tearDown(() {});
  test("emit occurs", () async {
    expectLater(auth.user, emitsInOrder([_mockUser]));
  });
  test("create account", () async {
    when(mockFirebaseAuth.createUserWithEmailAndPassword(
            email: "abc@def.com", password: "12345678"))
        .thenAnswer((realInvocation) => null);
    expect(await auth.createAccount(email: "abc@def.com", password: "12345678"),
        "Account Successfully Created!!");
  });
}
