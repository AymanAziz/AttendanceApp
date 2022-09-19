import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../BusinessLogic_Layer/AuthBloc/auth_bloc.dart';
import '../../../BusinessLogic_Layer/UserBloc/user_bloc.dart';
import '../../../Data_Layer/Model/UserModel/userModel.dart';
import '../../Widget/curve_widget.dart';
import '../HomeScreen/HomeScreen.dart';
import 'SignInScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _telNumberController = TextEditingController();
  final _userNumberController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final UserBloc userBloc = UserBloc();

  @override
  void dispose() {
    _telNumberController.dispose();
    _userNumberController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Initially password is obscure
  bool _obscureText = true;
  bool _obscureComfirmText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      _obscureComfirmText = !_obscureComfirmText;
    });
  }

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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: colorMainTheme,
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              // Navigating to the dashboard screen if the user is authenticated
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            }
            if (state is AuthError) {
              // Displaying the error message if the user is not authenticated
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
            if (state is UnAuthenticated) //after login
            {
              //remove previous queue screen after enter the sign up button
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const SignInScreen(),
                ),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is Loading) {
              // Displaying the loading indicator while the user is signing up
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UnAuthenticated) {
              // Displaying the sign up form if the user is not authenticated
              return Container(
                height: double.infinity,
                color: Colors.white,
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        Stack(
                          children: const [
                            CurveWidget(),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 4, 52, 84)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.20,
                    ),
                    Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              //email
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null &&
                                          !EmailValidator.validate(value)
                                      ? 'Enter Valid Email'
                                      : null;
                                },
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    hintText: 'Email',
                                    prefixIcon: const IconTheme(
                                        data: IconThemeData(
                                            color:
                                                Color.fromARGB(255, 4, 52, 84)),
                                        child: Icon(Icons.email))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //name
                              TextFormField(
                                controller: _nameController,
                                keyboardType: TextInputType.name,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    hintText: 'Full Name',
                                    prefixIcon: const IconTheme(
                                        data: IconThemeData(
                                            color:
                                                Color.fromARGB(255, 4, 52, 84)),
                                        child: Icon(Icons.person))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //staff or student no
                              TextFormField(
                                controller: _userNumberController,
                                keyboardType: TextInputType.name,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter staff/student number';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    hintText: 'Student or Staff number',
                                    prefixIcon: const IconTheme(
                                        data: IconThemeData(
                                            color:
                                                Color.fromARGB(255, 4, 52, 84)),
                                        child: Icon(Icons.person))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //tel number
                              TextFormField(
                                controller: _telNumberController,
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter staff/student number';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    hintText: 'Phone number',
                                    prefixIcon: const IconTheme(
                                        data: IconThemeData(
                                            color:
                                                Color.fromARGB(255, 4, 52, 84)),
                                        child: Icon(Icons.phone))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //password
                              TextFormField(
                                controller: _passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: _obscureText,
                                //hide password
                                validator: (value) {
                                  return value != null && value.length < 6
                                      ? "Enter min. 6 characters"
                                      : null;
                                },

                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0),
                                    hintText: 'Password',
                                    suffix: InkWell(
                                      onTap: _toggle,
                                      child: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          size: 16),
                                    ),
                                    prefixIcon: const IconTheme(
                                        data: IconThemeData(
                                            color:
                                                Color.fromARGB(255, 4, 52, 84)),
                                        child: Icon(Icons.lock))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //confirm password
                              TextFormField(
                                controller: _confirmPasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: _obscureComfirmText,
                                //hide password
                                validator: (value) {
                                  if (_passwordController.text !=
                                      _confirmPasswordController.text) {
                                    if (value != null && value.length < 6) {
                                      return "Enter min. 6 characters";
                                    }
                                    return "password is not same";
                                  } else {
                                    return null;
                                  }
                                },

                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0),
                                    hintText: 'Confirm Password',
                                    suffix: InkWell(
                                      onTap: _toggle,
                                      child: Icon(
                                          _obscureComfirmText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          size: 16),
                                    ),
                                    prefixIcon: const IconTheme(
                                        data: IconThemeData(
                                            color:
                                                Color.fromARGB(255, 4, 52, 84)),
                                        child: Icon(Icons.lock))),
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
                                      borderRadius: BorderRadius.circular(
                                          12), // <-- Radius
                                    ),
                                  ),
                                  onPressed: () {
                                    _createUserData(context);
                                    _createAccountWithEmailAndPassword(context);
                                  },
                                  child: const Text('Sign Up'),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      )),
    );
  }

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      //save to auth
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
          _emailController.text,
          _passwordController.text,
        ),
      );
    }
  }

  void _createUserData(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      UserModel usermodel = UserModel(
          name: _nameController.text,
          email: _emailController.text,
          userID: _userNumberController.text,
          telNumber: _telNumberController.text,
          isStudent: "Student"
      );

      userModelSQLite userModelSqlite = userModelSQLite(
          username: _nameController.text,
          email: _emailController.text,
          userID: _userNumberController.text,
          telNumber: _telNumberController.text,
          isStudent: "Student"
      );

      //save to firestore
      userBloc.add(GetUserData(usermodel,userModelSqlite));
    }
  }
}
