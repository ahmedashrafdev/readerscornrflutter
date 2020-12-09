import 'package:get_it/get_it.dart';
import 'package:readerscorner/scoped-models/address_model.dart';
import 'package:readerscorner/scoped-models/auth_model.dart';
import 'package:readerscorner/scoped-models/base_model.dart';
import 'package:readerscorner/scoped-models/cart_model.dart';
import 'package:readerscorner/scoped-models/checkoout_model.dart';
import 'package:readerscorner/scoped-models/coupon_model.dart';
import 'package:readerscorner/scoped-models/general_model.dart';

import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/scoped-models/orders_model.dart';
import 'package:readerscorner/scoped-models/product_model.dart';
import 'package:readerscorner/scoped-models/register_model.dart';
import 'package:readerscorner/scoped-models/user_model.dart';

import 'package:readerscorner/services/storage_service.dart';
import 'package:readerscorner/utils/connectivity_state.dart';


GetIt getIt = GetIt.I;

void setupLocator(){
  //register service
  getIt.registerLazySingleton(() => ConnectivityManager());
  getIt.registerLazySingleton<StorageService>(() => StorageService());

  getIt.registerFactory<RegisterModel>(() => RegisterModel());
  getIt.registerFactory<AddressModel>(() => AddressModel());
  getIt.registerFactory<AuthModel>(() => MainModel());
  getIt.registerFactory<CartModel>(() => MainModel());
  getIt.registerFactory<BaseModel>(() => BaseModel());
  getIt.registerFactory<CheckoutModel>(() => CheckoutModel());
  getIt.registerFactory<OrderModel>(() => MainModel());
  getIt.registerFactory<ProductModel>(() => MainModel());
  getIt.registerFactory<UserModel>(() => UserModel());
  getIt.registerFactory<CouponModel>(() => CouponModel());
  getIt.registerFactory<GeneralModel>(() => GeneralModel());
  getIt.registerFactory<MainModel>(() => MainModel());
  // login service


  //Home service
}