import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/app/navigation/routes.dart';
import 'package:google_docs_clone/app/utils.dart';
import 'package:google_docs_clone/components/auth/register/register_controller.dart';
import 'package:google_docs_clone/components/auth/widgets/widgets.dart';
import 'package:routemaster/routemaster.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _RegisterForm(),
      ),
    );
  }
}

class _RegisterForm extends ConsumerStatefulWidget {
  const _RegisterForm({Key? key}) : super(key: key);

  @override
  ConsumerState<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameTextEditingController = TextEditingController();
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  Future<void> createAccount() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(RegisterController.notifier).create(
            email: _emailTextEditingController.text,
            password: _passwordTextEditingController.text,
            name: _nameTextEditingController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.errorControllerStateListener(context, RegisterController.provider);
    return ConstrainedBox(
      constraints: BoxConstraints.loose(const Size.fromWidth(320)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Create an account 🚀',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Unlock the power of Flutter and Appwrite.',
                  ),
                ),
              ),
              NameTextField(controller: _nameTextEditingController),
              EmailTextField(controller: _emailTextEditingController),
              PasswordTextField(controller: _passwordTextEditingController),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: createAccount,
                  child: const Text('Create'),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  children: [
                    TextSpan(
                      text: 'Sign in',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap =
                            () => Routemaster.of(context).push(AppRoutes.login),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
