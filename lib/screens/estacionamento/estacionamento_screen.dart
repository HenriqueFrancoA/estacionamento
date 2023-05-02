import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:estacionamento_app/screens/home/components/drawer_home.dart';

class EstacionamentoScreen extends StatefulWidget {
  const EstacionamentoScreen({Key? key}) : super(key: key);

  @override
  EstacionamentoScreenState createState() => EstacionamentoScreenState();
}

class EstacionamentoScreenState extends State<EstacionamentoScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
            "Meu estacionamento",
            style: Theme.of(context).textTheme.headline2,
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
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: queryData.size.width,
                  height: 50,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Cor",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    validator: (value) {},
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: queryData.size.width,
                  height: 50,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Cor",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    validator: (value) {},
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
