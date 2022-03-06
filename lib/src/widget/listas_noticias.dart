import 'package:flutter/material.dart';
import 'package:newapp/src/model/newmodel.dart';
import 'package:newapp/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;

  const ListaNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticias(
          noticias: this.noticias[index],
          index: index,
        );
      },
    );
  }
}

class _Noticias extends StatelessWidget {
  final Article noticias;
  final int index;

  const _Noticias({
    @required this.noticias,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(noticias, index),
        _TarjetaTitulo(noticias),
        _TarjetaImage(noticias),
        _TarjetaBody(noticias),
        _TarjetaBotones(),
        SizedBox(
          height: 10,
        ),
        Divider(),
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.star_border),
        ),
        SizedBox(
          width: 20,
        ),
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.more_rounded),
        ),
      ],
    ));
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticias;

  const _TarjetaBody(this.noticias);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text((noticias.description != null) ? noticias.description : ''),
    );
  }
}

class _TarjetaImage extends StatelessWidget {
  final Article noticias;

  const _TarjetaImage(this.noticias);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
            child: (noticias.urlToImage != null)
                ? FadeInImage(
                    placeholder: AssetImage('assets/img/giphy.gif'),
                    image: NetworkImage(noticias.urlToImage),
                  )
                : Image(
                    image: AssetImage('assets/img/no-image.png'),
                  )),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticias;

  const _TarjetaTitulo(this.noticias);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        noticias.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticias;
  final int index;

  const _TarjetaTopBar(this.noticias, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${index + 1}. ',
            style: TextStyle(
              color: miTema.accentColor,
            ),
          ),
          Text(
            '${noticias.source.name}. ',
            style: TextStyle(
              color: miTema.accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
