import 'package:flutter/material.dart';
import 'package:newapp/src/model/newmodel.dart';
import 'package:newapp/src/page/tab1_page.dart';
import 'package:newapp/src/page/tab2_page.dart';
import 'package:newapp/src/services/news_services.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    // final newService = Provider.of<NewService>(context);
    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: ('Para ti'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: ('Encabezados'),
        ),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  PageController _pageController = new PageController();
  int _paginaActual = 0;
  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    this._paginaActual = valor;
    _pageController.animateToPage(
      valor,
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
