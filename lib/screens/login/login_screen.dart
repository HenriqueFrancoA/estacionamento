import 'dart:io';
import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'package:estacionamento_app/screens/home/home_screen.dart';
import 'package:estacionamento_app/screens/login/form_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

Future<SharedPreferences> prefs = SharedPreferences.getInstance();

class LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  bool salvarSenha = false;
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _senhaController = TextEditingController();
  late Widget botaoEntrar;

  @override
  void initState() {
    super.initState();
    getLogin();
  }

  void getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _nomeController.text = prefs.getString("email") ?? "";
    _senhaController.text = prefs.getString("senha") ?? "";
    salvarSenha = prefs.getBool("salvarSenha") ?? false;
    _salvarSenha(salvarSenha);

    if (salvarSenha) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        Get.snackbar(
          "Sem conexão com a internet!",
          "Verifique sua conexão e tente novamente!",
          icon: const Icon(
            Icons.signal_cellular_connected_no_internet_4_bar,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (connectivityResult == ConnectivityResult.wifi) {
        _onLoading();
        if (salvarSenha) {
          saveLogin(
            _nomeController.text.toString(),
            _senhaController.text.toString(),
            true,
          );
        } else {
          saveLogin(
            "",
            "",
            false,
          );
        }
        Get.offAll(const HomeScreen());
      }
    }
  }

  void saveLogin(String email, String senha, bool salvar) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    prefs.setString("senha", senha);
    prefs.setBool("salvarSenha", salvar);
  }

  void _onLoading() {
    setState(() {
      loading = !loading;
    });
  }

  void _salvarSenha(bool? value) {
    setState(() {
      salvarSenha = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    final isKeyboard = queryData.viewInsets.bottom != 0;
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Center(
              child: SizedBox(
                height: queryData.size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      !isKeyboard
                          ? Stack(
                              children: [
                                SizedBox(
                                  width: queryData.size.width,
                                  child: Positioned(
                                    child: Image.asset(
                                      "assets/images/img-login.jpg",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Center(
                                        child: Text(
                                          "True Parking",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 45,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          margin: isKeyboard
                              ? const EdgeInsets.only(
                                  top: 80,
                                )
                              : null,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FormLoginComponent(
                                keyForm: _formKey,
                                nomeController: _nomeController,
                                senhaController: _senhaController,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: salvarSenha,
                                    onChanged: _salvarSenha,
                                  ),
                                  GestureDetector(
                                    child: const Text(
                                      "Salvar senha",
                                    ),
                                    onTap: () {
                                      _salvarSenha(!salvarSenha);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 200,
                                height: 50,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    backgroundColor:
                                        const Color.fromRGBO(10, 52, 94, 1),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      var connectivityResult =
                                          await (Connectivity()
                                              .checkConnectivity());
                                      if (connectivityResult ==
                                          ConnectivityResult.mobile) {
                                        Get.snackbar(
                                          "Sem conexão com a internet!",
                                          "Verifique sua conexão e tente novamente!",
                                          icon: const Icon(
                                            Icons
                                                .signal_cellular_connected_no_internet_4_bar,
                                            color: Colors.white,
                                          ),
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
                                      } else if (connectivityResult ==
                                          ConnectivityResult.wifi) {
                                        _onLoading();
                                        if (salvarSenha) {
                                          saveLogin(
                                            _nomeController.text.toString(),
                                            _senhaController.text.toString(),
                                            true,
                                          );
                                        } else {
                                          saveLogin(
                                            "",
                                            "",
                                            false,
                                          );
                                        }
                                        Get.offAll(const HomeScreen());
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Entrar",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                child: GestureDetector(
                                    child: Text(
                                      "Cadastre-se",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    onTap: () async {}),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              loading
                                  ? Lottie.asset(
                                      "./assets/images/loading1.json",
                                      width: 100,
                                      height: 100,
                                    )
                                  : const SizedBox(
                                      height: 0,
                                      width: 0,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
