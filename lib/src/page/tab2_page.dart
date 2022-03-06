import 'package:flutter/material.dart';
import 'package:newapp/src/model/category_model.dart';
import 'package:newapp/src/services/news_services.dart';
import 'package:newapp/src/theme/tema.dart';
import 'package:newapp/src/widget/listas_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _ListaCategorias(),
            Expanded(
                child:
                    ListaNoticias(newService.getArticuleCategoriaSeleccionada)),
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewService>(context).categories;
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final cName = categories[index].name;
          return Container(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  _CategoryButton(categories[index]),
                  SizedBox(
                    height: 5,
                  ),
                  Text('${cName[0].toUpperCase()}${cName.substring(1)}')
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewService>(context);

    return GestureDetector(
      onTap: () {
        final newService = Provider.of<NewService>(context, listen: false);
        newService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(categoria.icon,
            color: (newService.selectedCategory == this.categoria.name)
                ? miTema.accentColor
                : Colors.black54),
      ),
    );
  }
}
