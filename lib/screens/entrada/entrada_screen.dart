import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:estacionamento_app/screens/home/components/drawer_home.dart';

class EntradaScreen extends StatefulWidget {
  const EntradaScreen({Key? key}) : super(key: key);

  @override
  EntradaScreenState createState() => EntradaScreenState();
}

class EntradaScreenState extends State<EntradaScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  String _selectedValue = "rotativo";
  late PageController? pc = PageController(initialPage: 0);
  int paginaAtual = 0;

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
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
              "Entrada",
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
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: Text(
                          "Veículos",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        onTap: () {
                          pc!.animateToPage(
                            paginaAtual = 0,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.linear,
                          );
                        },
                      ),
                      Text(
                        "|",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      GestureDetector(
                        child: Text(
                          "Clientes",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        onTap: () {
                          pc!.animateToPage(
                            paginaAtual = 1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.linear,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: pc,
                    onPageChanged: setPaginaAtual,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return paginaAtual == 0
                          ? SingleChildScrollView(
                              child: Container(
                                color: Theme.of(context).backgroundColor,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: queryData.size.width * 0.3,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            onEditingComplete: () =>
                                                FocusScope.of(context)
                                                    .nextFocus(),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              labelText: "Placa",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            validator: (value) {},
                                          ),
                                        ),
                                        SizedBox(
                                          width: queryData.size.width * 0.3,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            onEditingComplete: () =>
                                                FocusScope.of(context)
                                                    .nextFocus(),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              labelText: "Modelo",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            validator: (value) {},
                                          ),
                                        ),
                                        SizedBox(
                                          width: queryData.size.width * 0.3,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            onEditingComplete: () =>
                                                FocusScope.of(context)
                                                    .nextFocus(),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              labelText: "Cor",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            validator: (value) {},
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      width: queryData.size.width,
                                      padding: const EdgeInsets.all(5),
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: DropdownButton<String>(
                                        value: _selectedValue,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        underline: Container(
                                          height: 0,
                                        ),
                                        icon: const Icon(
                                          Ionicons.filter,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedValue =
                                                newValue.toString();
                                          });
                                        },
                                        items: const [
                                          DropdownMenuItem(
                                            value: "rotativo",
                                            child: Text(
                                              "Rotativo ",
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: "convenio",
                                            child: Text(
                                              "Convenio ",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      maxLines: 5,
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Observação",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      validator: (value) {},
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: queryData.size.width,
                                      height: 50,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                        onPressed: (() {}),
                                        child: const Text(
                                          "Dar entrada",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Container(
                                color: Theme.of(context).backgroundColor,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: queryData.size.width,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () =>
                                            FocusScope.of(context).nextFocus(),
                                        decoration: InputDecoration(
                                          suffixIcon: const Icon(
                                            Ionicons.person,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: "Nome",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        validator: (value) {},
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: queryData.size.width,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () =>
                                            FocusScope.of(context).nextFocus(),
                                        decoration: InputDecoration(
                                          suffixIcon: const Icon(
                                            Ionicons.call,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: "Telefone",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        validator: (value) {},
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: queryData.size.width,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () =>
                                            FocusScope.of(context).nextFocus(),
                                        decoration: InputDecoration(
                                          suffixIcon: const Icon(
                                            Ionicons.mail,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: "Email",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        validator: (value) {},
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      maxLines: 5,
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Observação",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      validator: (value) {},
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: queryData.size.width,
                                      height: 50,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                        onPressed: (() {}),
                                        child: const Text(
                                          "Dar entrada",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
