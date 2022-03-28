// TODO 2: Create MockAPI Class
import 'package:flutter_test/flutter_test.dart';
import 'package:shopnbuy/core/models/product.dart';
import 'package:shopnbuy/core/services/api.dart';
import 'package:shopnbuy/core/viewmodels/cart_model.dart';
import 'package:shopnbuy/core/viewmodels/product_list_model.dart';
import 'package:shopnbuy/helpers/dependency_assembly.dart';

class MockAPI extends API {
  @override
  Future<List<Product>> getProducts() {
    return Future.value([
      Product(
          id: 1,
          name: "MacBook Pro 16-inch model",
          price: 2399,
          imageUrl: "imageUrl"),
      Product(id: 2, name: "AirPods Pro", price: 249, imageUrl: "imageUrl"),
    ]);
  }
}

// TODO 5: Declare a Mock Product
final Product mockProduct =
    Product(id: 1, name: "Product1", price: 111, imageUrl: "imageUrl");

void main() {
  // TODO 3: Call Dependency Injector
  //1
  setupDependencyAssembler();
  //2
  var productListViewModel = dependencyAssembler<
      ProductListModel>(); //variable for the previously created dependency
  //3
  productListViewModel.api = MockAPI(); //we inject the dependency

  // TODO 6: Inject Cart View Model
  var cartViewModel = dependencyAssembler<CartModel>();

  // TODO 4: Write Product List Page Test Cases
  group('Given Product List Page Loads', () {
    test('Page should load a list of products from firebase', () async {
      //1
      await productListViewModel.getProducts();
      //2
      expect(productListViewModel.products.length, 2);
      //3
      expect(
          productListViewModel.products[0].name, 'MacBook Pro 16-inch model');
      expect(productListViewModel.products[0].price, 2399);
      expect(productListViewModel.products[1].name, 'AirPods Pro');
      expect(productListViewModel.products[1].price, 249);
    });
  });

  // TODO 7: Write Add to Cart Logic Test Case
  test('when user adds a product to cart, badge counter should increment by 1',
      () {
    cartViewModel.addToCart(mockProduct);
    expect((cartViewModel.cartSize), 1);
  });
}

