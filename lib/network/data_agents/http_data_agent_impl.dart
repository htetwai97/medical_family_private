import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:medical_family_app/data/vo_models/both_order_response_vo.dart';
import 'package:medical_family_app/data/vo_models/color_vo.dart';
import 'package:medical_family_app/data/vo_models/design_object_vo.dart';
import 'package:medical_family_app/data/vo_models/fabric_vo.dart';
import 'package:medical_family_app/data/vo_models/gender_vo.dart';
import 'package:medical_family_app/data/vo_models/item_vo.dart';
import 'package:medical_family_app/data/vo_models/size_vo.dart';
import 'package:medical_family_app/network/api_constants.dart';
import 'package:medical_family_app/network/responses/get_colors_for_family_arrow_response.dart';
import 'package:medical_family_app/network/responses/get_item_by_id_response.dart';
import 'package:medical_family_app/network/responses/get_itemlist_by_cat_and_subcat_response.dart';
import 'package:medical_family_app/network/responses/get_items_and_subcategories_by_category_response.dart';
import 'package:medical_family_app/network/responses/get_order_detail_and_invoice_response.dart';
import 'package:medical_family_app/network/responses/post_payment_response.dart';

class HttpDataAgentImpl {
  Future<GetItemByIdResponse> getItemById(String id) async {
    final response =
        await http.get(Uri.parse(BASE_URL + END_POINT_ITEMS_BY_ID + id));

    if (response.statusCode == 200) {
      return GetItemByIdResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future<GetItemsByCatAndSubCatResponse> getItemsByCategoryAndSubCategory(
      String categoryId, String subCategoryId) async {
    final response = await http.get(Uri.parse(
        "$BASE_URL$END_POINT_BRANDS_WITH_LOGO/$categoryId/$subCategoryId"));

    if (response.statusCode == 200) {
      return GetItemsByCatAndSubCatResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future<GetItemsAndSubCategoriesByCategoryResponse>
      getItemsAndSubCategoriesByCategory(String categoryId) async {
    final response = await http
        .get(Uri.parse("$BASE_URL$END_POINT_BRANDS_WITHOUT_LOGO/$categoryId"));

    if (response.statusCode == 200) {
      return GetItemsAndSubCategoriesByCategoryResponse.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future<GetOrderDetailAndInVoiceResponse> getOrderDetailAndInvoiceResponse(
      String orderId) async {
    final response = await http
        .get(Uri.parse("$BASE_URL$END_POINT_ECOMMERCE_ORDER_DETAIL/$orderId"));

    if (response.statusCode == 200) {
      return GetOrderDetailAndInVoiceResponse.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future<List<ItemVO>> postSearchStringToGetItems(String search) async {
    var searchData = {"item": search};
    var body = json.encode(searchData);
    final headers = {
      PARAM_CONTENT_TYPE: APPLICATIONJSON,
      PARAM_ACCEPT: APPLICATIONJSON
    };
    final url = Uri.parse("$BASE_URL$END_POINT_SEARCH_ITEM");
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body) as List<dynamic>;
      final List<ItemVO> itemList = responseData
          .map((dynamic item) => ItemVO.fromJson(item as Map<String, dynamic>))
          .toList();
      return itemList;
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future<List<DesignObjectVO>> getDesign(String brandId) async {
    final response =
        await http.get(Uri.parse("$BASE_URL$END_POINT_DESIGN_API/$brandId"));
    if (response.statusCode == 200) {
      final responseData =
          json.decode(response.body)['design'] as Map<String, dynamic>;
      final values = responseData.values.toList();
      final List<DesignObjectVO> designs = values
          .map((dynamic item) =>
              DesignObjectVO.fromJson(item as Map<String, dynamic>))
          .toList();
      return designs;
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future<GenderVO> getGender(String itemName) async {
    final response = await http
        .get(Uri.parse("$BASE_URL$END_POINT_ECOMMERCE_ORDER$itemName"));
    if (response.statusCode == 200) {
      return GenderVO.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future<GetColorsForFamilyArrowResponse> getColorsForFamilyArrow(
      String itemName) async {
    final response = await http
        .get(Uri.parse("$BASE_URL$END_POINT_ECOMMERCE_ORDER_COLOR$itemName"));
    if (response.statusCode == 200) {
      return GetColorsForFamilyArrowResponse.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future<FabricVO> getFabric(String itemName, String gender) async {
    final response = await http
        .get(Uri.parse("$BASE_URL$END_POINT_ECOMMERCE_ORDER$itemName/$gender"));
    if (response.statusCode == 200) {
      return FabricVO.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future<ColorVO> getColor(
      String itemName, String gender, String fabric) async {
    final response = await http.get(Uri.parse(
        "$BASE_URL$END_POINT_ECOMMERCE_ORDER$itemName/$gender/$fabric"));
    if (response.statusCode == 200) {
      return ColorVO.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future<SizeVO> getSize(
      String itemName, String gender, String fabric, String color) async {
    final response = await http.get(Uri.parse(
        "$BASE_URL$END_POINT_ECOMMERCE_ORDER$itemName/$gender/$fabric/$color"));
    if (response.statusCode == 200) {
      return SizeVO.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future<BothOrderResponseVO> postCustomImageAndBody(
    String quantity,
    String description,
    String price,
    String totalQuantity,
    String totalAmount,
    String orderId,
    File file,
  ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://familyuniformapp.medicalworld.com.mm/api/ecommerce_attach_store'),
    );
    request.fields.addAll({
      'qty': quantity,
      'description': description,
      'price': price,
      'totqty': totalQuantity,
      'totamount': totalAmount,
      'id': orderId
    });

    request.files.add(
      http.MultipartFile.fromBytes(
        'attachs',
        await file.readAsBytes(),
        filename: file.path.split('/').last,
      ),
    );
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return BothOrderResponseVO.fromJson(jsonDecode(responseBody));
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future<PostPaymentResponse> postScreenShot(
    File file,
    String remark,
    String payAmount,
  ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://familyuniformapp.medicalworld.com.mm/api/storescreenshot'),
    );

    request.fields.addAll({
      'remark': remark,
      'payamount': payAmount,
    });

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        await file.readAsBytes(),
        filename: file.path.split('/').last,
      ),
    );

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return PostPaymentResponse.fromJson(jsonDecode(responseBody));
    } else {
      throw Exception('Failed to load response');
    }
  }
}
