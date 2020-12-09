import 'package:readerscorner/scoped-models/address_model.dart';
import 'package:readerscorner/scoped-models/auth_model.dart';
import 'package:readerscorner/scoped-models/base_model.dart';
import 'package:readerscorner/scoped-models/cart_model.dart';
import 'package:readerscorner/scoped-models/checkoout_model.dart';
import 'package:readerscorner/scoped-models/coupon_model.dart';
import 'package:readerscorner/scoped-models/general_model.dart';
import 'package:readerscorner/scoped-models/orders_model.dart';
import 'package:readerscorner/scoped-models/product_model.dart';
import 'package:readerscorner/scoped-models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';


class MainModel extends BaseModel with AddressModel , CouponModel , GeneralModel , AuthModel , CartModel , CheckoutModel , OrderModel , ProductModel , UserModel {
}
