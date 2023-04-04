import 'package:dio/dio.dart';
import 'package:medical_family_app/data/vo_models/brand_item_vo.dart';
import 'package:medical_family_app/data/vo_models/instock_order_object_vo.dart';
import 'package:medical_family_app/data/vo_models/item_detail_vo.dart';
import 'package:medical_family_app/data/vo_models/item_to_post_related_item_vo.dart';
import 'package:medical_family_app/data/vo_models/item_vo.dart';
import 'package:medical_family_app/data/vo_models/post_pre_order_object_vo.dart';
import 'package:medical_family_app/data/vo_models/send_email_body_vo.dart';
import 'package:medical_family_app/data/vo_models/township_vo.dart';
import 'package:medical_family_app/data/vo_models/user_vo.dart';
import 'package:medical_family_app/network/responses/get_all_items_response.dart';
import 'package:medical_family_app/network/responses/order_list_response.dart';
import 'package:medical_family_app/network/responses/order_save_success_response.dart';
import 'package:medical_family_app/network/responses/post_email_success_response.dart';
import 'package:medical_family_app/network/responses/post_login_response.dart';
import 'package:medical_family_app/network/responses/post_preorder_success_response.dart';
import 'package:medical_family_app/network/responses/post_register_response.dart';

abstract class DataAgent {
  Future<PostLoginResponse> postLoginResponse(
      UserVO user, String contentType, String accept);
  Future<PostRegisterResponse> postRegisterResponse(
      UserVO user, String contentType, String accept);
  Future<List<BrandItemVO>> getBrandsWithLogo();
  Future<List<BrandItemVO>> getBrandsWithoutLogo();
  Future<List<ItemVO>> getHotSaleItems();
  Future<List<ItemVO>> getNewArrivalItems();
  Future<List<ItemVO>> getPromotionItems();
  Future<List<ItemDetailVO>> postRelatedItem(
      ItemToPostRelatedItemVO itemToPostRelatedItemVO,
      String contentType,
      String accept);
  Future<List<TownShipVO>> getTownShips();
  Future<OrderListResponse> getOrderList();
  Future<OrderSaveSuccessResponse> postOrderSave(
      String contentType, String accept, InStockOrderVO inStockOrder);
  Future<GetAllItemsResponse> getAllItems();
  Future<PostPreOrderSuccessResponse> postPreOrderSave(String contentType,
      String accept, PostPreOrderObjectVO postPreOrderObjectVO);
  Future<int> postCustomerOrderStepOne(String contentType, String accept,
      PostPreOrderObjectVO postPreOrderObjectVO);
  Future<PostEmailSuccessResponse> postEmailBody(
      String contentType, String accept, SendEmailBodyVO emailBody);
  Future<PostEmailSuccessResponse> postEmailBodyFormData(
      String contentType, String accept, FormData formData);
}
