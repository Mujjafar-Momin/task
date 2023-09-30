import 'package:demo/view/product/home_page.dart';
import 'package:demo/view/product/product_details_page.dart';
import 'package:demo/view_model/home_view_model.dart';
import 'package:demo/view_model/product_detail_view_model.dart';
import 'package:provider/provider.dart';

class NavigationHelper {
  static getMyHomePageViewWithProvider() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider.value(
          value: ProductDetailViewModel(),
        )
      ],
      child: const MyHomePage(),
    );
  }

  static getProductDetailsPageViewWithProvider() {
  return MultiProvider(
      providers: [
       ChangeNotifierProvider(
          create: (_) => ProductDetailViewModel(),
        ),
      ],
      child: const ProductDetailPage(),
    );
  }
}
