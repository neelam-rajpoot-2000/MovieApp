import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_book_app/ui/auth/signup_screen.dart';
import 'package:movie_book_app/view/home/movie_list.dart';
import 'package:movie_book_app/ui/utils/utils.dart';
import 'package:movie_book_app/widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formField = GlobalKey<FormState>();
  final _auth=FirebaseAuth.instance;
  bool loading=false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login(){
    setState(() {
      loading=true;
    });
    _auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) {
      Utils().toastMessage(value.user!.email.toString());
         Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MoviesList()));
                                  setState(() {
      loading=false;
    });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
       setState(() {
      loading=false;
    });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
               backgroundColor:const Color(0xFF260032),

           automaticallyImplyLeading: false,
          title: const Center(
            child: Text('Login'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formField,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Password', prefixIcon: Icon(Icons.lock)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              RoundButton(
                title: 'Login',
                loading: loading,
                onTap: () {
                  if (_formField.currentState!.validate()) {
                    login();
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScren()));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.deepPurple),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
