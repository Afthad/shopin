import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopin/constants/api_path.dart';
import 'package:shopin/models/cart.dart';
import 'package:shopin/models/products.dart';

class OrderController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference reference;

  int random(min, max) {
    return min + Random().nextInt(max - min);
  }

  getData() async {
    reference = firestore.collection(APIPath.listOfItems());
    products.bindStream(getProducts());
    isLoading.value = false;
    periodicTimer;
  }

  RxList<Products> products = <Products>[].obs;
  RxList<Cart> carts = <Cart>[].obs;

  addToCart(Cart cart) {
    bool isExists = false;
    for (var e in carts) {
      cartTimer;
      if (e.prodId == cart.prodId) {
        e.quantity = e.quantity! + int.parse(cart.products!.addedQuantity);
        isExists = true;

        break;
      }
    }
    if (!isExists) {
      carts.add(cart);
    }
    getCartCount();
  }

  RxInt cartCount = 0.obs;
  void getCartCount() {
    cartCount.value = carts.fold<int>(
        0, (previousValue, element) => element.quantity! + previousValue);
  }

  void getCartWhereProduct(String id) {
    cartCount.value = carts.fold<int>(
        0, (previousValue, element) => element.quantity! + previousValue);
  }

  delete(String id) {
    carts.removeWhere((element) => element.prodId == id);
  }

  RxBool isLoading = true.obs;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void updateProducts() async {
    var querySnapShot = await reference.get();
    for (var e in querySnapShot.docs) {
      e.reference.update({'price': '${random(10000, 15000)}'});
    }
  }

  late final cartTimer = Timer.periodic(
    const Duration(seconds: 1),
    (timer) {
      if (cartTime.value != 0) {
        cartTime.value--;
      }
      if (cartTime.value == 0) {
        carts.clear();
        getCartCount();
        cartTime = 60.obs;
      }
    },
  );

  RxInt cartTime = 60.obs;

  late final periodicTimer = Timer.periodic(
    const Duration(seconds: 30),
    (timer) {
      updateProducts();
    },
  );
  Stream<List<Products>> getProducts() => reference.snapshots().map(
      (query) => query.docs.map((item) => Products.fromMap(item)).toList());

  @override
  void dispose() {
    cartCount.value = 0;
    carts.clear();
    super.dispose();
  }
}
