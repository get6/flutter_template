import 'package:template/pages/loading_page.dart';
import 'package:template/pages/sign_in_page.dart';
import 'package:template/pages/something_went_wrong.dart';
import 'package:template/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookWidget {
  Widget _buildBody(BuildContext context) {
    return Row(
      children: [
        Text('Body'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return useProvider(authStateChangesProvider).when(
      data: (user) =>
          user != null ? _buildBody(context) : SignInPage(isLoading: false),
      loading: () => LoadingPage(),
      error: (_, __) => SomethingWentWrong(),
    );
  }
}
