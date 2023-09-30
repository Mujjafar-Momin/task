import 'package:demo/model/product_model.dart';
import 'package:flutter/material.dart';

Widget imageStack(
  BuildContext context,
  ProductElement productElement,
) {
  return Stack(
    children: [
      ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          productElement.thumbnail,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width * .4,
          // height:
          //     MediaQuery.of(context).size.height * .,
        ),
      ),
      Positioned(
        left: 120,
        child: IconButton(
           onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: productElement.isFavorite ? Colors.red : Colors.white,
            )),
      )
    ],
  );
}

Widget nameColumn(List<dynamic> list, int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     
    ],
  );
}
