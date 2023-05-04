import 'dart:io';

import 'package:dio/dio.dart';
import 'package:medical_family_app/data/vo_models/both_order_response_vo.dart';
import 'package:medical_family_app/data/vo_models/brand_item_vo.dart';
import 'package:medical_family_app/data/vo_models/cart_item_vo.dart';
import 'package:medical_family_app/data/vo_models/color_for_family_arrow_vo.dart';
import 'package:medical_family_app/data/vo_models/color_vo.dart';
import 'package:medical_family_app/data/vo_models/custom_pre_order_item_vo.dart';
import 'package:medical_family_app/data/vo_models/design_by_brand_id_vo.dart';
import 'package:medical_family_app/data/vo_models/design_object_vo.dart';
import 'package:medical_family_app/data/vo_models/fabric_vo.dart';
import 'package:medical_family_app/data/vo_models/gender_vo.dart';
import 'package:medical_family_app/data/vo_models/instock_order_object_vo.dart';
import 'package:medical_family_app/data/vo_models/item_detail_vo.dart';
import 'package:medical_family_app/data/vo_models/item_to_post_related_item_vo.dart';
import 'package:medical_family_app/data/vo_models/item_vo.dart';
import 'package:medical_family_app/data/vo_models/post_pre_order_object_vo.dart';
import 'package:medical_family_app/data/vo_models/pre_order_item_vo.dart';
import 'package:medical_family_app/data/vo_models/send_email_body_vo.dart';
import 'package:medical_family_app/data/vo_models/size_vo.dart';
import 'package:medical_family_app/data/vo_models/township_vo.dart';
import 'package:medical_family_app/data/vo_models/user_vo.dart';
import 'package:medical_family_app/network/responses/get_all_items_response.dart';
import 'package:medical_family_app/network/responses/get_colors_for_family_arrow_response.dart';
import 'package:medical_family_app/network/responses/get_item_by_id_response.dart';
import 'package:medical_family_app/network/responses/get_itemlist_by_cat_and_subcat_response.dart';
import 'package:medical_family_app/network/responses/get_items_and_subcategories_by_category_response.dart';
import 'package:medical_family_app/network/responses/get_order_detail_and_invoice_response.dart';
import 'package:medical_family_app/network/responses/order_list_response.dart';
import 'package:medical_family_app/network/responses/order_save_success_response.dart';
import 'package:medical_family_app/network/responses/post_email_success_response.dart';
import 'package:medical_family_app/network/responses/post_login_response.dart';
import 'package:medical_family_app/network/responses/post_payment_response.dart';
import 'package:medical_family_app/network/responses/post_preorder_success_response.dart';
import 'package:medical_family_app/network/responses/post_register_response.dart';

abstract class MedicalWorldRepoModel {
  Future<PostRegisterResponse> postRegisterResponse(UserVO user);
  Future<PostLoginResponse> postLoginResponse(UserVO user);
  Future<List<BrandItemVO>> getBrandsWithLogo();
  Future<List<BrandItemVO>> getBrandsWithoutLogo();
  Future<List<ItemVO>> getHotSaleItems();
  Future<List<ItemVO>> getNewArrivalItems();
  Future<List<ItemVO>> getPromotionItems();
  Future<GetItemByIdResponse> getItemById(String id);
  Future<List<ItemDetailVO>> postRelatedItem(
      ItemToPostRelatedItemVO itemToPostRelatedItemVO);
  Future<GenderVO> getGender(String itemName);
  Future<GetColorsForFamilyArrowResponse> getColorsForFamilyArrow(
      String itemName);
  Future<FabricVO> getFabric(String itemName, String gender);
  Future<ColorVO> getColor(String itemName, String gender, String fabric);
  Future<SizeVO> getSize(
      String itemName, String gender, String fabric, String color);
  Future<List<DesignObjectVO>> getDesign(String brandId);
  Future<String> getUserInfoString(String key);
  Future<GetItemsAndSubCategoriesByCategoryResponse>
      getItemsAndSubCategoriesByCategory(String categoryId);
  Future<GetItemsByCatAndSubCatResponse> getItemsByCategoryAndSubCategory(
      String categoryId, String subCategoryId);
  void saveCartItem(CartItemVO? cartItem);
  void deleteCartItem(int? countingUnitId);
  Stream<List<CartItemVO?>?> getAllCartsStream();
  Future<List<ItemVO>> postSearchStringToGetItems(String search);
  Future<void> clearSharedPreferences();
  Future<void> saveUserInfoString(String key, String value);
  Future<bool> isPreferenceExists(String key);
  Future<List<TownShipVO>> getTownShips();
  Future<OrderListResponse> getOrderList();
  Future<OrderSaveSuccessResponse> postOrderSave(InStockOrderVO inStockOrder);
  Future<GetOrderDetailAndInVoiceResponse> getOrderDetailAndInvoiceResponse(
      String orderId);
  void savePreOrderItem(PreOrderItemVO? preOrderItem);
  void deletePreOrderItem(String? itemName);
  Stream<List<PreOrderItemVO?>?> getAllPreOrdersStream();
  Future<GetAllItemsResponse> getAllItems();
  Future<PostPreOrderSuccessResponse> postPreOrderSave(
      PostPreOrderObjectVO postPreOrderObjectVO);
  Future<int> postCustomerOrderStepOne(
      PostPreOrderObjectVO postPreOrderObjectVO);
  void clearCarts();
  void clearPreOrders();
  void saveAllPreOrders(List<PreOrderItemVO?>? preOrderList);
  Future<BothOrderResponseVO> postCustomImageAndBody(
      String quantity,
      String description,
      String price,
      String totalQuantity,
      String totalAmount,
      String orderId,
      File file);
  Future<PostPaymentResponse> postScreenShot(
    File file,
    String remark,
    String payAmount,
  );
  void saveCustomPreOrderItem(CustomPreOrderItemVO? customPreOrderItem);
  void deleteCustomPreOrderItem(String? timeStamp);
  void clearCustomPreOrders();
  void saveAllCustomPreOrders(List<CustomPreOrderItemVO?>? customList);
  Stream<List<CustomPreOrderItemVO?>?> getAllCustomPreOrdersStream();
  CustomPreOrderItemVO? getCustomOrderItem(String? timeStamp);
  Future<PostEmailSuccessResponse> postEmailBodyRetrofit(
      SendEmailBodyVO emailBody);
  Future<PostEmailSuccessResponse> postEmailBodyFormData(FormData formData);
}
