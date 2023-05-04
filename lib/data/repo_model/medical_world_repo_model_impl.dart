import 'dart:io';
import 'package:dio/dio.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model.dart';
import 'package:medical_family_app/data/vo_models/both_order_response_vo.dart';
import 'package:medical_family_app/data/vo_models/brand_item_vo.dart';
import 'package:medical_family_app/data/vo_models/cart_item_vo.dart';
import 'package:medical_family_app/data/vo_models/color_vo.dart';
import 'package:medical_family_app/data/vo_models/counting_unit_instock_order_vo.dart';
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
import 'package:medical_family_app/data/vo_models/unit_instock_order_vo.dart';
import 'package:medical_family_app/data/vo_models/user_vo.dart';
import 'package:medical_family_app/network/api_constants.dart';
import 'package:medical_family_app/network/data_agents/data_agent.dart';
import 'package:medical_family_app/network/data_agents/data_agent_impl.dart';
import 'package:medical_family_app/network/data_agents/http_data_agent_impl.dart';
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
import 'package:medical_family_app/persistence/hive/daos/abstracts/cart_item_dao.dart';
import 'package:medical_family_app/persistence/hive/daos/abstracts/custom_pre_order_item_dao.dart';
import 'package:medical_family_app/persistence/hive/daos/abstracts/pre_order_item_dao.dart';
import 'package:medical_family_app/persistence/hive/daos/impl/cart_item_dao_impl.dart';
import 'package:medical_family_app/persistence/hive/daos/impl/custom_pre_order_item_dao_impl.dart';
import 'package:medical_family_app/persistence/hive/daos/impl/pre_order_item_dao_impl.dart';
import 'package:medical_family_app/persistence/share_preference/share_preference.dart';
import 'package:stream_transform/stream_transform.dart';

class MedicalWorldRepoModelImpl extends MedicalWorldRepoModel {
  static final MedicalWorldRepoModelImpl _singleton =
      MedicalWorldRepoModelImpl._internal();
  factory MedicalWorldRepoModelImpl() {
    return _singleton;
  }
  MedicalWorldRepoModelImpl._internal();

  /// Dependency
  DataAgent dataAgent = DataAgentImpl();
  HttpDataAgentImpl httpDataAgent = HttpDataAgentImpl();
  SharePreferenceModel sharePreferenceModel = SharePreferenceModel();
  CartItemDao cartItemDao = CartItemDaoImpl();
  PreOrderItemDao preOrderItemDao = PreOrderItemDaoImpl();
  CustomPreOrderItemDao customPreOrderItemDao = CustomPreOrderItemDaoImpl();

  @override
  Future<PostLoginResponse> postLoginResponse(UserVO user) {
    return dataAgent.postLoginResponse(user, APPLICATIONJSON, APPLICATIONJSON);
  }

  @override
  Future<PostRegisterResponse> postRegisterResponse(UserVO user) {
    return dataAgent.postRegisterResponse(
        user, APPLICATIONJSON, APPLICATIONJSON);
  }

  @override
  Future<List<BrandItemVO>> getBrandsWithLogo() {
    return dataAgent.getBrandsWithLogo();
  }

  @override
  Future<List<BrandItemVO>> getBrandsWithoutLogo() {
    return dataAgent.getBrandsWithoutLogo();
  }

  @override
  Future<List<ItemVO>> getHotSaleItems() {
    return dataAgent.getHotSaleItems();
  }

  @override
  Future<List<ItemVO>> getNewArrivalItems() {
    return dataAgent.getNewArrivalItems();
  }

  @override
  Future<List<ItemVO>> getPromotionItems() {
    return dataAgent.getPromotionItems();
  }

  @override
  Future<GetItemByIdResponse> getItemById(String id) {
    return httpDataAgent.getItemById(id);
  }

  @override
  Future<List<ItemDetailVO>> postRelatedItem(
      ItemToPostRelatedItemVO itemToPostRelatedItemVO) {
    return dataAgent.postRelatedItem(
        itemToPostRelatedItemVO, APPLICATIONJSON, APPLICATIONJSON);
  }

  @override
  Future<ColorVO> getColor(String itemName, String gender, String fabric) {
    return httpDataAgent.getColor(itemName, gender, fabric);
  }

  @override
  Future<FabricVO> getFabric(String itemName, String gender) {
    return httpDataAgent.getFabric(itemName, gender);
  }

  @override
  Future<SizeVO> getSize(
      String itemName, String gender, String fabric, String color) {
    return httpDataAgent.getSize(itemName, gender, fabric, color);
  }

  @override
  Future<GenderVO> getGender(String itemName) {
    return httpDataAgent.getGender(itemName);
  }

  @override
  Future<List<DesignObjectVO>> getDesign(String brandId) {
    return httpDataAgent.getDesign(brandId);
  }

  @override
  Future<String> getUserInfoString(String key) {
    return sharePreferenceModel.getUserInfoString(key);
  }

  @override
  Future<GetItemsAndSubCategoriesByCategoryResponse>
      getItemsAndSubCategoriesByCategory(String categoryId) {
    return httpDataAgent.getItemsAndSubCategoriesByCategory(categoryId);
  }

  @override
  Future<GetItemsByCatAndSubCatResponse> getItemsByCategoryAndSubCategory(
      String categoryId, String subCategoryId) {
    return httpDataAgent.getItemsByCategoryAndSubCategory(
        categoryId, subCategoryId);
  }

  @override
  void deleteCartItem(int? countingUnitId) {
    cartItemDao.deleteCartItem(countingUnitId);
  }

  @override
  Stream<List<CartItemVO?>?> getAllCartsStream() {
    return cartItemDao
        .getAllCartEventStream()
        .startWith(cartItemDao.getAllCartsStream())
        .map((event) => cartItemDao.getAllCarts());
  }

  @override
  void saveCartItem(CartItemVO? cartItem) {
    cartItemDao.saveCartItem(cartItem);
  }

  @override
  Future<List<ItemVO>> postSearchStringToGetItems(String search) {
    return httpDataAgent.postSearchStringToGetItems(search);
  }

  @override
  Future<void> clearSharedPreferences() {
    return sharePreferenceModel.clearSharedPreferences();
  }

  @override
  Future<void> saveUserInfoString(String key, String value) {
    return sharePreferenceModel.saveUserInfoString(key, value);
  }

  @override
  Future<bool> isPreferenceExists(String key) {
    return sharePreferenceModel.isPreferenceExists(key);
  }

  @override
  Future<OrderListResponse> getOrderList() {
    return dataAgent.getOrderList();
  }

  @override
  Future<List<TownShipVO>> getTownShips() {
    return dataAgent.getTownShips();
  }

  @override
  Future<OrderSaveSuccessResponse> postOrderSave(InStockOrderVO inStockOrder) {
    return dataAgent.postOrderSave(
        APPLICATIONJSON, APPLICATIONJSON, inStockOrder);
  }

  @override
  Future<GetOrderDetailAndInVoiceResponse> getOrderDetailAndInvoiceResponse(
      String orderId) {
    return httpDataAgent
        .getOrderDetailAndInvoiceResponse(orderId)
        .then((response) async {
      List<UnitInStockOrderVO?>? unitList = response.units?.map((unit) {
        CountingUnitInStockOrderVO? countingUnit = response.countingUnits
            ?.singleWhere(
                (countingUnit) => countingUnit?.id == unit?.countingUnitId);
        unit?.countingUnitInStockOrder = countingUnit;
        return unit;
      }).toList();

      response.units = unitList;
      return response;
    });
  }

  @override
  void deletePreOrderItem(String? itemName) {
    preOrderItemDao.deletePreOrderItem(itemName);
  }

  @override
  Stream<List<PreOrderItemVO?>?> getAllPreOrdersStream() {
    return preOrderItemDao
        .getAllPreOrdersEventStream()
        .startWith(preOrderItemDao.getAllPreOrdersStream())
        .map((event) => preOrderItemDao.getAllPreOrders());
  }

  @override
  void savePreOrderItem(PreOrderItemVO? preOrderItem) {
    preOrderItemDao.savePreOrderItem(preOrderItem);
  }

  @override
  Future<GetAllItemsResponse> getAllItems() {
    return dataAgent.getAllItems();
  }

  @override
  Future<PostPreOrderSuccessResponse> postPreOrderSave(
      PostPreOrderObjectVO postPreOrderObjectVO) {
    return dataAgent.postPreOrderSave(
        APPLICATIONJSON, APPLICATIONJSON, postPreOrderObjectVO);
  }

  @override
  void clearCarts() {
    cartItemDao.clearCarts();
  }

  @override
  void clearPreOrders() {
    preOrderItemDao.clearPreOrders();
  }

  @override
  void saveAllPreOrders(List<PreOrderItemVO?>? preOrderList) {
    preOrderItemDao.saveAllPreOrders(preOrderList);
  }

  @override
  Future<BothOrderResponseVO> postCustomImageAndBody(
      String quantity,
      String description,
      String price,
      String totalQuantity,
      String totalAmount,
      String orderId,
      File file) {
    return httpDataAgent.postCustomImageAndBody(quantity, description, price,
        totalQuantity, totalAmount, orderId, file);
  }

  @override
  void clearCustomPreOrders() {
    customPreOrderItemDao.clearCustomPreOrders();
  }

  @override
  void deleteCustomPreOrderItem(String? timeStamp) {
    customPreOrderItemDao.deleteCustomPreOrderItem(timeStamp);
  }

  @override
  Stream<List<CustomPreOrderItemVO?>?> getAllCustomPreOrdersStream() {
    return customPreOrderItemDao
        .getAllCustomPreOrdersEventStream()
        .startWith(customPreOrderItemDao.getAllCustomPreOrdersStream())
        .map((event) => customPreOrderItemDao.getAllCustomPreOrders());
  }

  @override
  void saveAllCustomPreOrders(List<CustomPreOrderItemVO?>? customList) {
    customPreOrderItemDao.saveAllCustomPreOrders(customList);
  }

  @override
  void saveCustomPreOrderItem(CustomPreOrderItemVO? customPreOrderItem) {
    customPreOrderItemDao.saveCustomPreOrderItem(customPreOrderItem);
  }

  @override
  Future<int> postCustomerOrderStepOne(
      PostPreOrderObjectVO postPreOrderObjectVO) {
    return dataAgent.postCustomerOrderStepOne(
        APPLICATIONJSON, APPLICATIONJSON, postPreOrderObjectVO);
  }

  @override
  CustomPreOrderItemVO? getCustomOrderItem(String? timeStamp) {
    return customPreOrderItemDao.getCustomOrderItem(timeStamp);
  }

  @override
  Future<PostPaymentResponse> postScreenShot(
      File file, String remark, String payAmount) {
    return httpDataAgent.postScreenShot(file, remark, payAmount);
  }

  @override
  Future<PostEmailSuccessResponse> postEmailBodyRetrofit(
      SendEmailBodyVO emailBody) {
    return dataAgent.postEmailBody(APPLICATIONJSON, APPLICATIONJSON, emailBody);
  }

  @override
  Future<PostEmailSuccessResponse> postEmailBodyFormData(FormData formData) {
    return dataAgent.postEmailBodyFormData(
        MULTIPART_FORM_DATA, APPLICATIONJSON, formData);
  }

  @override
  Future<GetColorsForFamilyArrowResponse> getColorsForFamilyArrow(
      String itemName) {
    return httpDataAgent.getColorsForFamilyArrow(itemName);
  }
}
