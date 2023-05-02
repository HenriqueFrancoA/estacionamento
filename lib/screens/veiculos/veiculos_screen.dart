import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:estacionamento_app/models/gruposepapp.dart';
import 'package:estacionamento_app/screens/home/components/drawer_home.dart';
import 'package:estacionamento_app/screens/veiculos/veiculos_card.dart';

class VeiculosScreen extends StatefulWidget {
  const VeiculosScreen({Key? key}) : super(key: key);

  @override
  VeiculosScreenState createState() => VeiculosScreenState();
}

class VeiculosScreenState extends State<VeiculosScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  bool barraPesquisa = false;
  List<GrupoSepApp> lista = [];
  List<GrupoSepApp> listaPesquisa = [];
  TextEditingController pesquisaController = TextEditingController();

  onSearch(String text) async {
    listaPesquisa.clear();
    if (text.isEmpty || text == "") {
      return;
    }

    setState(() {
      for (var e in lista) {
        if (e.preoc.toString().contains(text)) {
          listaPesquisa.add(e);
        }
      }
    });
  }

  nada() {
    print("teste");
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
              "Veículos",
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
            color: Theme.of(context).backgroundColor,
            padding: const EdgeInsets.only(right: 15.0, left: 15),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: barraPesquisa
                      ? Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: TextField(
                                      autofocus: true,
                                      keyboardType: TextInputType.number,
                                      onChanged: (text) {
                                        onSearch(text);
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Pesquisar por placa",
                                      ),
                                      controller: pesquisaController,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        setState(() {
                                          barraPesquisa = false;
                                          listaPesquisa.clear();
                                          pesquisaController.text = "";
                                        });
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  barraPesquisa = !barraPesquisa;
                                });
                              },
                              icon: const Icon(Icons.search),
                            ),
                          ],
                        ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  child: listaPesquisa.isNotEmpty ||
                          pesquisaController.text != ""
                      ? Expanded(
                          child: Scrollbar(
                            child: ListView.builder(
                              itemCount: listaPesquisa.length,
                              padding: const EdgeInsets.all(20),
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) {
                                return const VeiculosCard();
                              },
                            ),
                          ),
                        )
                      : Expanded(
                          child: FutureBuilder(
                            future: nada(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Carregando...',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );

                                case ConnectionState.done:
                                  if (lista.isEmpty) {
                                    return Center(
                                      child: Text(
                                        "Nenhum veículo",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    );
                                  } else {
                                    return Scrollbar(
                                      child: ListView.separated(
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const Divider(
                                            color: Colors.white,
                                          );
                                        },
                                        itemCount: lista.length,
                                        padding: const EdgeInsets.all(10),
                                        shrinkWrap: true,
                                        itemBuilder: (ctx, index) {
                                          return const VeiculosCard();
                                        },
                                      ),
                                    );
                                  }

                                case ConnectionState.none:
                                  break;
                                case ConnectionState.active:
                                  break;
                              }
                              return Center(
                                child: Text(
                                  "Unknown Error",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}
