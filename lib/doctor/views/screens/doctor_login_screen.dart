import 'package:aarogyam/doctor/logic/bloc/login_bloc.dart';
import 'package:aarogyam/doctor/views/screens/doctor_HomeScreen.dart';
import 'package:aarogyam/doctor/views/screens/doctor_ragistration_screen.dart';
import 'package:aarogyam/patient/views/screens/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocterLoginScreen extends StatefulWidget {
  const DocterLoginScreen({super.key});

  @override
  State<DocterLoginScreen> createState() => _DocterLoginScreenState();
}

class _DocterLoginScreenState extends State<DocterLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        ],
        child: const LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xfffdfefd),
      appBar: AppBar(
        backgroundColor: const Color(0xfffdfefd),
        surfaceTintColor: const Color(0xfffdfefd),
        toolbarHeight: 40,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const PatientLoginScreen(),
                ));
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Image.asset(
                  "assets/img/vector/docterlogin.png",
                  width: MediaQuery.of(context).size.width,
                  height: 320,
                ),
                const Text(
                  "Your expertise matter on our digital  \n   "
                      "                    platform...",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Doctor Login",
                  style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w500,
                      fontSize: 28),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: Column(
                      children: [
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            String? error;
                            if (state is LoginEmailInvalidState) {
                              error = state.error;
                            }
                            return TextFormField(
                              controller: _email,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelText: "Enter Email",
                                errorText: error,
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: Color(0xff117790),
                                ),
                                labelStyle: const TextStyle(
                                    color: Color(0xff117790),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            String? error;
                            bool visibility = true;
                            if (state is LoginPasswordInvalidState) {
                              error = state.error;
                            }
                            if (state is PassVisibilityState) {
                              visibility = state.isOn;
                            }
                            return TextFormField(
                              obscureText: visibility,
                              controller: _password,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelText: "Enter Password",
                                errorText: error,
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Color(0xff117790),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(visibility
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    visibility
                                        ? BlocProvider.of<LoginBloc>(context)
                                        .add(PassVisibilityFalseEvent())
                                        : BlocProvider.of<LoginBloc>(context)
                                        .add(PassVisibilityTrueEvent());
                                  },
                                ),
                                labelStyle: const TextStyle(
                                    color: Color(0xff117790),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: BlocConsumer<LoginBloc, LoginState>(
                            listener: (context, state) {
                              if (state is LoginAcceptState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                        Text("Login Successfully...!")));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      const DoctorHomePage(),
                                    ));
                              } else if (state is ErrorState) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      content: Text(state.error),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Okay"),
                                        )
                                      ],
                                    );
                                  },
                                );
                              } else if (state is LoginPendingState) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Pending Request',style: TextStyle(color: Colors.black),),
                                    content: const Text(
                                        'Thank you for signing up! Your request is currently being processed. Please remain patient while we review and approve your request. We will notify you as soon as your account is ready for login. Thank you for your understanding.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStatePropertyAll(
                                                MaterialStateColor
                                                    .resolveWith((states) =>
                                                Colors.teal))),
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (state is LoginRejectState) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      'Request Rejected',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    content: const Text(
                                      'We regret to inform you that your request has been rejected due to some reasons. For further details or if you have any questions, please feel free to reach out to us at pyajfoundation0211@gmail.com. Thank you for your understanding and cooperation.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStatePropertyAll(
                                                MaterialStateColor
                                                    .resolveWith((states) =>
                                                Colors.teal))),
                                        child: const Text(
                                          'OK',style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              return TextButton(
                                onPressed: () async {
                                  BlocProvider.of<LoginBloc>(context).add(
                                    LoginFieldChangedEvent(
                                      email: _email.text,
                                      password: _password.text,
                                    ),
                                  );

                                  if (state is LoginValidState) {
                                    BlocProvider.of<LoginBloc>(context).add(
                                      LoginSubmitEvent(
                                        email: _email.text,
                                        password: _password.text,
                                      ),
                                    );
                                  }
                                },
                                child: BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, state) {
                                    if (state is LoginLoadingState) {
                                      FocusScope.of(context).unfocus();
                                      return const CircularProgressIndicator();
                                    }
                                    return const Center(
                                      child: Text(
                                        "Sign in ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have a Account ?",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff117790)),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const DocterRagistrationScreen();
                                  },
                                ));
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Color(0xfff89520),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}