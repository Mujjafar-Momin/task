import 'package:demo/model/product_model.dart';
import 'package:demo/view_model/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  static const String TAG = "/ProductDetailPage";

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProductElement productElement =
          ModalRoute.of(context)!.settings.arguments as ProductElement;
      context
          .read<ProductDetailViewModel>()
          .getProductDetailsData(context, productElement.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductElement productElement =
        ModalRoute.of(context)!.settings.arguments as ProductElement;
    ProductDetailViewModel productDetailViewModel =
        context.watch<ProductDetailViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              title: Text(
                productElement.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              iconTheme: const IconThemeData(),
              backgroundColor: Colors.grey.shade200,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Ink(
                  decoration: const ShapeDecoration(
                      shape: CircleBorder(), color: Colors.white),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context, productElement);
                      },
                      icon: const Icon(Icons.arrow_back)),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Ink(
                    decoration: const ShapeDecoration(
                        shape: CircleBorder(), color: Colors.white),
                    child: IconButton(
                        onPressed: () => productDetailViewModel.isSelected(productElement),
                        icon: Icon(Icons.favorite,
                            color: productElement.isFavorite 
                                ? (Colors.red)
                                : Colors.black)),
                  ),
                ),
              ],
            ),
            body: productDetailViewModel.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                      strokeWidth: 2,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                          items: [
                            ...productElement.images
                                .map((url) => Image.network(
                                      url,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.fill,
                                    ))
                          ],
                          options: CarouselOptions(
                              enlargeCenterPage: true, autoPlay: true),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              productElement.brand,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "1 Kg",
                              style: TextStyle(),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          productElement.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: productElement.rating,
                              itemCount: 5,
                              itemSize: 30.0,
                              itemBuilder: (context, _) =>
                                  const Icon(Icons.star, color: Colors.amber),
                            ),
                            Text(
                                "(${productElement.rating.toStringAsFixed(1)})")
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Product Details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(productElement.description)
                      ],
                    ),
                  )),
      ),
    );
  }
}
