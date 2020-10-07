import 'package:template/constants/strings.dart';
import 'package:template/model/sign_in_view_model.dart';
import 'package:template/providers/user_provider.dart';
import 'package:template/services/firebase_auth_service.dart';
import 'package:template/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInPage extends HookWidget {
  SignInPage({Key key, @required this.isLoading}) : super(key: key);

  final bool isLoading;

  Future<void> _showSignInError(
      BuildContext context, Exception exception) async {
    final SnackBar snackBar = Utils.getSnackBar(content: exception.toString());

    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      Strings.signIn,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildSignIn() {
    final _key = GlobalKey<FormState>();
    final _firebaseAuthService = FirebaseAuthService();

    return SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 50.0, child: _buildHeader()),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildForm(key: _key, authService: _firebaseAuthService),
                ..._buildSocialButtons(authService: _firebaseAuthService),
              ],
            ),
          )

          // TODO: 애플개발자 등록하고 테스트해보기
          // _signInWithAppleProvider.when(
          //   data: (value) {
          //     if (value) {
          //       return SignInWithAppleButton(
          //         onPressed: isLoading
          //             ? null
          //             : () async => await _firebaseAuthService.signInWithApple(),
          //       );
          //     } else {
          //       return EmptyWidget();
          //     }
          //   },
          //   loading: () => EmptyWidget(),
          //   error: (_, __) => SignInWithAppleButton(onPressed: null),
          // ),
        ],
      ),
    );
  }

  Widget _buildForm(
      {@required GlobalKey<FormState> key,
      @required FirebaseAuthService authService}) {
    FormData _formData = FormData();
    return Form(
      key: key,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (newValue) {
              _formData.email = newValue;
            },
            decoration: InputDecoration(
              hintText: "Email",
              labelText: "Email",
            ),
          ),
          TextFormField(
            obscureText: true,
            validator: (value) {
              if (value.length < 10) {
                return "Password must be over 10 in length";
              }
              return null;
            },
            onSaved: (newValue) {
              _formData.password = newValue;
            },
            decoration: InputDecoration(
              hintText: "Password",
              labelText: "Password",
            ),
          ),
          RaisedButton(
            child: Text("Log In"),
            onPressed: () {
              if (key.currentState.validate()) {
                key.currentState.save();
                authService.signInWithEmailAndPassword(
                  _formData.email,
                  _formData.password,
                );
              }
            },
          )
        ],
      ),
    );
  }

  List<Widget> _buildSocialButtons(
      {@required FirebaseAuthService authService}) {
    return [
      RaisedButton(
        child: Text("Google"),
        onPressed: () => authService.signInWithGoogle(),
      ),
      RaisedButton(
        child: Text("Facebook"),
        onPressed: () => authService.signInWithFacebook(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final signInViewModel = useProvider(signInViewModelProvider);
    return ProviderListener(
      onChange: (context, value) async {},
      provider: null,
      child: SignInPageContents(
        viewModel: signInViewModel,
      ),
    );
    // return _buildSignIn();
  }

  Widget SignInPageContents({SignInViewModel viewModel}) {
    return Center(
      child: Text("Here"),
    );
  }
}

class FormData {
  String email = "";
  String password = "";
}
