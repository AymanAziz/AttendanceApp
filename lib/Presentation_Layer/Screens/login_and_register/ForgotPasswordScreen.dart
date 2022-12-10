import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../BusinessLogic_Layer/AuthBloc/auth_bloc.dart';
import '../../Widget/curve_widget.dart';
import 'SignInScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color colorMainTheme = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false, //new line
            appBar: AppBar(
              elevation: 0,
              backgroundColor: colorMainTheme,
            ),
            body: Container(
              height: double.infinity,
              color: Colors.white,
              child: ListView(children: [
                Stack(
                  children: [
                     CurveWidget(
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Forgot Password',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 4, 52, 84)),
                    ),
                  ],
                ),
                const SizedBox(height: 60,),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          //email
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return value != null &&
                                  !EmailValidator.validate(value)
                                  ? 'Enter Valid Email'
                                  : null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 25.0, horizontal: 10.0),
                                hintText: 'email',
                                prefixIcon: const IconTheme(
                                    data: IconThemeData(
                                        color: Color.fromARGB(255, 4, 52, 84)),
                                    child: Icon(Icons.email))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //button sign in
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                              onPressed: ()  {
                                BlocProvider.of<AuthBloc>(context).add(
                                  ForgotPasswordRequested(
                                      _emailController.text.trim()
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                    Text('Password Reset Email Sent'),
                                  ),
                                );
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                        const SignInScreen()),
                                        (Route<dynamic> route) => false);
                              },
                              child: const Text('Forgot Password'),
                            ),
                          ),
                        ],
                      ),
                    )),
              ]),
            ),
          )),
    );
  }
}

Future VerifyEmail(emailController) async
{
  await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.trim());
}