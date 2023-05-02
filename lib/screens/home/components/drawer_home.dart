import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'package:estacionamento_app/screens/estacionamento/estacionamento_screen.dart';
import 'package:estacionamento_app/screens/home/home_screen.dart';
import 'package:estacionamento_app/screens/login/login_screen.dart';

class DrawerHomeConferente extends StatefulWidget {
  const DrawerHomeConferente({
    Key? key,
  }) : super(key: key);

  @override
  DrawerHomeConferenteState createState() => DrawerHomeConferenteState();
}

class DrawerHomeConferenteState extends State<DrawerHomeConferente> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  @override
  void initState() {
    _initPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 36, 36, 36),
              ),
              child: Text(
                "Lava-Rápido Seu Zé",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Ionicons.home,
              color: Colors.black,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Get.offAll(const HomeScreen());
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Ionicons.people,
              color: Colors.black,
            ),
            title: Text(
              "Clientes",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Ionicons.car,
              color: Colors.black,
            ),
            title: Text(
              "Meu Estacionamento",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Get.offAll(const EstacionamentoScreen());
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Ionicons.exit_outline,
              color: Colors.black,
            ),
            title: Text(
              "Sair",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Get.defaultDialog(
                title: "Atenção",
                content: Text(
                  "Deseja sair do App?",
                  style: TextStyle(fontSize: 12.sp),
                ),
                onCancel: () {},
                textCancel: "Não",
                onConfirm: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString("email", "");
                  prefs.setString("senha", "");
                  prefs.setBool("salvarSenha", false);

                  Get.offAll(const LoginScreen());
                },
                textConfirm: "Sim",
                confirmTextColor: Colors.white,
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
