import 'package:template/model/sign_in_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// Root FirebaseAuth
final firebaseAuthProvider =
    Provider<FirebaseAuth>((_) => FirebaseAuth.instance);

// FirebaseAuth User state
final authStateChangesProvider = StreamProvider<User>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

// FirebaseAuth View Model
final signInViewModelProvider = ChangeNotifierProvider<SignInViewModel>(
  (ref) => SignInViewModel(auth: ref.watch(firebaseAuthProvider)),
);

final signInWithAppleProvider = FutureProvider.autoDispose<bool>(
    (_) async => await SignInWithApple.isAvailable());
