// ignore_for_file: unnecessary_string_interpolations

import 'package:demo/view/product/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/home_view_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  static const String TAG = "/MyHomePage";
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HomeViewModel homeViewModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
      homeViewModel.getProductData();
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = context.watch<HomeViewModel>();
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(

          centerTitle: true,
          title: const Text(
            'Products',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
          ),
        ),
        body: Consumer<HomeViewModel>(builder: (context, val, child) {
          return val.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.8,
                            crossAxisCount: 2),
                    itemCount: val.productElementList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ProductDetailPage.TAG,
                                  arguments: val.productElementList[index])
                              .then((value) =>
                                  homeViewModel.updateFavorite(value));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    clipBehavior: Clip.antiAlias,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      val.productElementList[index].thumbnail,
                                      fit: BoxFit.fill,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                  Positioned(
                                    left:
                                        MediaQuery.of(context).size.width * .1 +
                                            100,
                                    child: IconButton(
                                        onPressed: () {
                                          val.selecteFavorite(
                                              val.productElementList[index]);
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: val.productElementList[index]
                                                  .isFavorite
                                              ? Colors.red
                                              : Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${val.productElementList[index].title}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  "\$${val.productElementList[index].price.toString()}",
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "\$${val.productElementList[index].discountPercentage.toString()}",
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.amber,
                                ),
                                Text(
                                    "${val.productElementList[index].rating.toStringAsFixed(1)}",
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
        }));
  }
}

/*

 homeViewModel.product == null
            ? const Center(
                child: Text("Loading.."),
              )
            :
      ListView.builder(
          itemCount: homeViewModel.product!.products.length,
          itemBuilder: (context, i) {
            final model = homeViewModel.product!.products[i];
            log(model.id);
            return Card(
              child: Text(model.brand),
            );
          }),
    );


FutureBuilder(
          future: homeViewModel.getProductData(),
          builder: (context, snapdata) {
            if (snapdata.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          // color: Colors.amber.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        height: MediaQuery.of(context).size.height * .05,
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          autofocus: true,
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              suffixIcon: Icon(Icons.search),
                              // label: Text("Search"),
                              hintText: "Search products here"),
                        )),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapdata.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Image.network(
                                    snapdata.data![index].thumbnail,
                                    fit: BoxFit.fill),
                              ),
                              subtitle: Text(snapdata.data![index].description),
                              title:
                                  Text(snapdata.data![index].brand.toString()),
                            ),
                          );
                        }),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Loading..'),
              );
            }
          }),
     
*/