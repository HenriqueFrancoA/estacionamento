import 'package:estacionamento_app/models/transaction.dart';
import 'package:estacionamento_app/screens/entrada/entrada_screen.dart';
import 'package:estacionamento_app/screens/home/components/drawer_home.dart';
import 'package:estacionamento_app/screens/veiculos/veiculos_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  final List<Transaction> _transactions = [];

  List<Transaction> get recentTransactions {
    return _transactions
        .where((tr) => (tr.date.isAfter(DateTime.now().subtract(
              const Duration(days: 7),
            ))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawerEnableOpenDragGesture: false,
        drawer: const DrawerHomeConferente(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          centerTitle: true,
          title: Text(
            "Pátio",
            style: Theme.of(context).textTheme.headline1,
          ),
          leading: IconButton(
            icon: const Icon(
              Ionicons.menu,
            ),
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              Expanded(
                child: GridView.count(
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          border: Border.all(
                            width: 3,
                            color: Colors.transparent,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                        ),
                        child: const Center(
                          child: Text(
                            "Entrada",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.offAll(const EntradaScreen());
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(
                            width: 3,
                            color: Colors.transparent,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Veículos",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                "12/30",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 61, 61, 61),
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.offAll(const VeiculosScreen());
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              //Container(
              //  width: queryData.size.width,
              //  color: Colors.black,
              //  padding: const EdgeInsets.all(10),
              //  margin: const EdgeInsets.all(10),
              //  child: const Center(
              //    child: Text(
              //      "Faturamento Semanal",
              //      style: TextStyle(
              //        fontWeight: FontWeight.bold,
              //        color: Colors.white,
              //        fontSize: 20,
              //      ),
              //    ),
              //  ),
              //),
              //SizedBox(
              //  width: queryData.size.width,
              //  child: Chart(
              //    _recentTransactions,
              //  ),
              //),
            ],
          ),
        ),
      ),
    );
  }
}
