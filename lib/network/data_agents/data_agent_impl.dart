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
import 'package:medical_family_app/network/data_agents/data_agent.dart';
import 'package:medical_family_app/network/medical_world_api.dart';
import 'package:medical_family_app/network/responses/get_all_items_response.dart';
import 'package:medical_family_app/network/responses/order_list_response.dart';
import 'package:medical_family_app/network/responses/order_save_success_response.dart';
import 'package:medical_family_app/network/responses/post_email_success_response.dart';
import 'package:medical_family_app/network/responses/post_login_response.dart';
import 'package:medical_family_app/network/responses/post_preorder_success_response.dart';
import 'package:medical_family_app/network/responses/post_register_response.dart';

class DataAgentImpl extends DataAgent {
  late MedicalWorldApi mApi;

  static final DataAgentImpl _singleton = DataAgentImpl._internal();

  factory DataAgentImpl() {
    return _singleton;
  }

  DataAgentImpl._internal() {
    final dio = Dio();
    mApi = MedicalWorldApi(dio);
  }
  @override
  Future<PostLoginResponse> postLoginResponse(
      UserVO user, String contentType, String accept) {
    return mApi.postLoginResponse(contentType, accept, user);
  }

  @override
  Future<PostRegisterResponse> postRegisterResponse(
      UserVO user, String contentType, String accept) {
    return mApi.postRegisterResponse(contentType, accept, user);
  }

  @override
  Future<List<BrandItemVO>> getBrandsWithLogo() {
    return mApi.getBrandItemWithLogo();
  }

  @override
  Future<List<BrandItemVO>> getBrandsWithoutLogo() {
    return mApi.getBrandItemWithoutLogo();
  }

  @override
  Future<List<ItemVO>> getHotSaleItems() {
    return mApi.getHotSaleItems();
  }

  @override
  Future<List<ItemVO>> getNewArrivalItems() {
    return mApi.getNewArrivalItems();
  }

  @override
  Future<List<ItemVO>> getPromotionItems() {
    return mApi.getPromotionItems();
  }

  @override
  Future<List<ItemDetailVO>> postRelatedItem(
      ItemToPostRelatedItemVO itemToPostRelatedItemVO,
      String contentType,
      String accept) {
    return mApi.postRelatedItem(contentType, accept, itemToPostRelatedItemVO);
  }

  @override
  Future<OrderListResponse> getOrderList() {
    return mApi.getOrderList();
  }

  @override
  Future<List<TownShipVO>> getTownShips() {
    return mApi.getTownShips();
  }

  @override
  Future<OrderSaveSuccessResponse> postOrderSave(
      String contentType, String accept, InStockOrderVO inStockOrder) {
    return mApi.postOrderSave(contentType, accept, inStockOrder);
  }

  @override
  Future<GetAllItemsResponse> getAllItems() {
    return mApi.getAllItems();
  }

  @override
  Future<PostPreOrderSuccessResponse> postPreOrderSave(String contentType,
      String accept, PostPreOrderObjectVO postPreOrderObjectVO) {
    return mApi.postPreOrderSave(contentType, accept, postPreOrderObjectVO);
  }

  @override
  Future<int> postCustomerOrderStepOne(String contentType, String accept,
      PostPreOrderObjectVO postPreOrderObjectVO) {
    return mApi.postCustomerOrderStepOne(
        contentType, accept, postPreOrderObjectVO);
  }

  @override
  Future<PostEmailSuccessResponse> postEmailBody(
      String contentType, String accept, SendEmailBodyVO emailBody) {
    return mApi.postEmailBody(contentType, accept, emailBody);
  }

  @override
  Future<PostEmailSuccessResponse> postEmailBodyFormData(
      String contentType, String accept, FormData formData) {
    return mApi.postEmailBodyFormData(contentType, accept, formData);
  }
}
