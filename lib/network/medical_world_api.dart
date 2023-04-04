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
import 'package:medical_family_app/network/api_constants.dart';
import 'package:medical_family_app/network/responses/get_all_items_response.dart';
import 'package:medical_family_app/network/responses/order_list_response.dart';
import 'package:medical_family_app/network/responses/order_save_success_response.dart';
import 'package:medical_family_app/network/responses/post_email_success_response.dart';
import 'package:medical_family_app/network/responses/post_login_response.dart';
import 'package:medical_family_app/network/responses/post_preorder_success_response.dart';
import 'package:medical_family_app/network/responses/post_register_response.dart';
import 'package:retrofit/http.dart';
part 'medical_world_api.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class MedicalWorldApi {
  factory MedicalWorldApi(Dio dio) = _MedicalWorldApi;

  @POST(END_POINT_POST_REGISTER)
  Future<PostRegisterResponse> postRegisterResponse(
    @Header(PARAM_CONTENT_TYPE) String contentType,
    @Header(PARAM_ACCEPT) String accept,
    @Body() UserVO user,
  );

  @POST(END_POINT_POST_LOGIN)
  Future<PostLoginResponse> postLoginResponse(
    @Header(PARAM_CONTENT_TYPE) String contentType,
    @Header(PARAM_ACCEPT) String accept,
    @Body() UserVO user,
  );

  @GET(END_POINT_BRANDS_WITH_LOGO)
  Future<List<BrandItemVO>> getBrandItemWithLogo();

  @GET(END_POINT_BRANDS_WITHOUT_LOGO)
  Future<List<BrandItemVO>> getBrandItemWithoutLogo();

  @GET(END_POINT_NEW_ARRIVAL_ITEMS)
  Future<List<ItemVO>> getNewArrivalItems();

  @GET(END_POINT_HOT_SALE_ITEMS)
  Future<List<ItemVO>> getHotSaleItems();

  @GET(END_POINT_PROMOTION_ITEMS)
  Future<List<ItemVO>> getPromotionItems();

  @POST(END_POINT_RELATED_ITEM)
  Future<List<ItemDetailVO>> postRelatedItem(
    @Header(PARAM_CONTENT_TYPE) String contentType,
    @Header(PARAM_ACCEPT) String accept,
    @Body() ItemToPostRelatedItemVO itemToPostRelatedItemVO,
  );

  @GET(END_POINT_TOWNSHIPS)
  Future<List<TownShipVO>> getTownShips();

  @GET(END_POINT_ECOMMERCE_ORDER_INDEX)
  Future<OrderListResponse> getOrderList();

  @POST(END_POINT_ECOMMERCE_ORDER_STORE)
  Future<OrderSaveSuccessResponse> postOrderSave(
    @Header(PARAM_CONTENT_TYPE) String contentType,
    @Header(PARAM_ACCEPT) String accept,
    @Body() InStockOrderVO inStockOrderVO,
  );

  @GET(END_POINT_ITEMS_API)
  Future<GetAllItemsResponse> getAllItems();

  @POST(END_POINT_ECOMMERCE_PREORDER_STORE)
  Future<PostPreOrderSuccessResponse> postPreOrderSave(
    @Header(PARAM_CONTENT_TYPE) String contentType,
    @Header(PARAM_ACCEPT) String accept,
    @Body() PostPreOrderObjectVO postPreOrderObjectVO,
  );

  @POST(END_POINT_ECOMMERCE_ATTACH_ORDER_STORE)
  Future<int> postCustomerOrderStepOne(
    @Header(PARAM_CONTENT_TYPE) String contentType,
    @Header(PARAM_ACCEPT) String accept,
    @Body() PostPreOrderObjectVO postPreOrderObjectVO,
  );

  @POST(END_POINT_SEND_EMAIL)
  Future<PostEmailSuccessResponse> postEmailBody(
    @Header(PARAM_CONTENT_TYPE) String contentType,
    @Header(PARAM_ACCEPT) String accept,
    @Body() SendEmailBodyVO emailBody,
  );

  @POST(END_POINT_SEND_EMAIL)
  Future<PostEmailSuccessResponse> postEmailBodyFormData(
      @Header(PARAM_CONTENT_TYPE) String contentType,
      @Header(PARAM_ACCEPT) String accept,
      @Body() FormData formData,
      );
}
