// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:medical_family_app/bloc/home_page_bloc.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/vo_models/item_vo.dart';
import 'package:medical_family_app/network/api_constants.dart';
import 'package:medical_family_app/pages/contact_us_page.dart';
import 'package:medical_family_app/pages/item_detail_new_version_page.dart';
import 'package:medical_family_app/pages/login_page.dart';
import 'package:medical_family_app/pages/my_cart_page.dart';
import 'package:medical_family_app/pages/my_order_page.dart';
import 'package:medical_family_app/pages/my_profile_page.dart';
import 'package:medical_family_app/pages/product_line_new_version_page.dart';
import 'package:medical_family_app/utils/extensions/extention.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  int newArrivalOrHotSale = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageBloc(),
      child: Scaffold(
        drawer: Drawer(
          width: scaleWidth(context) / 1.3,
          child: const DrawerPropertyListView(),
        ),
        appBar: PreferredSize(
          preferredSize: Size(scaleWidth(context), scaleWidth(context) / 6),
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: AppBar(
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
              elevation: 4.0,
              backgroundColor: APP_THEME_COLOR,
              title: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: scaleWidth(context) / 10,
                width: scaleWidth(context) / 2.3,
                child: Consumer<HomePageBloc>(
                  builder: (context, bloc, child) => SearchTextFieldView(
                    hintText: SEARCH_TEXT,
                    onSearchDone: (text) {
                      navigateToScreen(
                          context,
                          ProductLineNewVersionPage(
                            searchItem: text,
                            comeFromHomePage: true,
                          ));
                    },
                    readOnly: false,
                  ),
                ),
              ),
              actions: [
                Consumer<HomePageBloc>(
                  builder: (context, bloc, child) =>
                      CartIconToNavigateCartPageView(
                    iconColor: Colors.white,
                    cartCount: bloc.cartList?.length.toString(),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Selector<HomePageBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              Visibility(
                visible: !isLoading,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: scaleWidth(context) / 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: scaleWidth(context) / 20),
                        const BannerSectionView(),
                        SizedBox(height: scaleWidth(context) / 40),
                        TitleAndSeeMoreView(
                          title: "Brands",
                          visibleSeeMOreButton: true,
                        ),
                        SizedBox(height: scaleWidth(context) / 40),
                        const BrandLogoListView(),
                        SizedBox(height: scaleWidth(context) / 20),
                        TitleAndSeeMoreView(
                          title: "Promotion",
                          visibleSeeMOreButton: false,
                        ),
                        SizedBox(height: scaleWidth(context) / 40),
                        Consumer<HomePageBloc>(
                          builder: (context, bloc, child) => ItemListView(
                            itemList: bloc.promotionItemList,
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 40),
                        TitleAndSeeMoreView(
                          title: "New Arrival",
                          visibleSeeMOreButton: false,
                        ),
                        SizedBox(height: scaleWidth(context) / 40),
                        Consumer<HomePageBloc>(
                          builder: (context, bloc, child) => ItemListView(
                            itemList: bloc.newArrivalItemList,
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 40),
                        TitleAndSeeMoreView(
                          title: "Hot Sale",
                          visibleSeeMOreButton: false,
                        ),
                        SizedBox(height: scaleWidth(context) / 40),
                        Consumer<HomePageBloc>(
                          builder: (context, bloc, child) => ItemListView(
                            itemList: bloc.hotSaleItemList,
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 40),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isLoading,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerPropertyListView extends StatelessWidget {
  const DrawerPropertyListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage("assets/images/intro_image_two.jpg"),
              fit: BoxFit.contain,
            ),
          ),
          child: Image.asset("assets/images/intro_image_two.jpg"),
        ),
        SizedBox(height: scaleWidth(context) / 10),
        DrawerListTileSectionView(
          icon: Icons.person,
          text: "My Profile",
          onTap: () {
            navigateToScreen(context, const MyProfilePage());
          },
        ),
        DrawerListTileSectionView(
          icon: Icons.shopping_cart_rounded,
          text: "My Cart",
          onTap: () {
            navigateToScreen(context, const MyCartPage());
          },
        ),
        DrawerListTileSectionView(
          icon: Icons.call,
          text: "Contact Us",
          onTap: () {
            navigateToScreen(context, const ContactUsPage());
          },
        ),
        DrawerListTileSectionView(
          icon: Icons.format_list_numbered,
          text: "My Orders",
          onTap: () {
            navigateToScreen(context,  MyOrderPage(isComingFromHome: true,));
          },
        ),
        Consumer<HomePageBloc>(
          builder: (context, bloc, child) => DrawerListTileSectionView(
            icon: Icons.logout,
            text: "Logout",
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ConfirmOrNotShowDialogView(
                      onTapOK: () {
                        bloc.onTapLogOut().then((value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                              (route) => false);
                        });
                      },
                      notification: "Are you sure to Logout?",
                    );
                  });
            },
          ),
        ),
      ],
    );
  }
}

class DrawerListTileSectionView extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;
  DrawerListTileSectionView({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.drawer,
      leading: Icon(icon, color: APP_THEME_COLOR, size: FONT_XLARGE),
      title: Text(
        text,
        style: const TextStyle(
          color: APP_THEME_COLOR,
          fontSize: FONT_LARGE - 4,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          onTap();
        },
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
          size: FONT_LARGE,
          color: APP_THEME_COLOR,
        ),
      ),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  const BannerSectionView({
    super.key,
  });

  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _position = index.toDouble();
              });
            },
            aspectRatio: 16 / 9,
            viewportFraction: 2,
            enlargeCenterPage: false,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
          ),
          items: [
            BannerItemView(
              learnMoreToWebsite: true,
              bannerImage: "assets/images/viber_image_1.jpg",
              onTapLearnMore: () {},
            ),
            BannerItemView(
              learnMoreToWebsite: true,
              bannerImage: "assets/images/viber_image_2.jpg",
              onTapLearnMore: () {},
            ),
            BannerItemView(
              learnMoreToWebsite: true,
              bannerImage: "assets/images/viber_image_3.jpg",
              onTapLearnMore: () {},
            ),
            BannerItemView(
              learnMoreToWebsite: true,
              bannerImage: "assets/images/viber_image_4.jpg",
              onTapLearnMore: () {},
            ),
            BannerItemView(
              learnMoreToWebsite: true,
              bannerImage: "assets/images/viber_image_5.jpg",
              onTapLearnMore: () {},
            ),
            BannerItemView(
              learnMoreToWebsite: true,
              bannerImage: "assets/images/viber_image_6.jpg",
              onTapLearnMore: () {},
            ),
            BannerItemView(
              learnMoreToWebsite: true,
              bannerImage: "assets/images/viber_image_7.jpg",
              onTapLearnMore: () {},
            ),
            BannerItemView(
              learnMoreToWebsite: true,
              bannerImage: "assets/images/viber_image_8.jpg",
              onTapLearnMore: () {},
            ),
          ],
        ),
        DotsIndicator(
          dotsCount: 8,
          position: _position,
          decorator: const DotsDecorator(
            color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
            activeColor: APP_THEME_COLOR,
          ),
        ),
      ],
    );
  }
}

class ItemListView extends StatelessWidget {
  List<ItemVO>? itemList;
  ItemListView({
    super.key,
    this.itemList,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: scaleWidth(context) / 2.2,
      child: ListView.separated(
        itemBuilder: (context, index) => ItemDetailView(
          itemImage: "$ITEM_IMAGE_BASE_URL${itemList?[index].photoPath}",
          itemName: itemList?[index].itemName ?? "Error",
          onTap: () {
            navigateToScreen(context,
                ItemDetailNewVersionPage(itemId: "${itemList?[index].id}"));
          },
        ),
        separatorBuilder: (context, index) => SizedBox(
          width: scaleWidth(context) / 30,
        ),
        itemCount: itemList?.length ?? 0,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}

class BannerItemView extends StatelessWidget {
  String bannerImage;
  Function onTapLearnMore;
  bool learnMoreToWebsite;
  BannerItemView({
    super.key,
    required this.bannerImage,
    required this.onTapLearnMore,
    required this.learnMoreToWebsite,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          bannerImage,
          fit: BoxFit.fill,
          height: scaleWidth(context) / 2.2,

          /// width: scaleWidth(context) - 20,
        ),
        Positioned(
          right: scaleWidth(context) / 20,
          bottom: scaleWidth(context) / 12,
          child: Visibility(
            visible: learnMoreToWebsite,
            child: GestureDetector(
              onTap: () {
                onTapLearnMore();
              },
              child: const Text(
                "learn more",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.amber,
                  fontSize: FONT_MEDIUM,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ItemDetailView extends StatelessWidget {
  String itemName;
  String itemImage;
  Function onTap;
  double? height;
  double? width;
  ItemDetailView({
    super.key,
    required this.itemName,
    required this.itemImage,
    required this.onTap,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Container(
            height: height ?? scaleWidth(context) / 2.8,
            width: width ?? scaleWidth(context) / 2.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage(
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, obj, st) {
                    return errorImage();
                  },
                  placeholder:
                      const AssetImage("assets/images/place_holder_asset.jpg"),
                  image: NetworkImage(itemImage)),
            ),
          ),
          SizedBox(
            height: scaleWidth(context) / 40,
          ),
          Text(
            itemName,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: FONT_LARGE - 7,
            ),
          ),
        ],
      ),
    );
  }
}

Widget errorImage() {
  return Image.asset("assets/images/place_holder_asset.jpg", fit: BoxFit.cover);
}

class TabBarForNewArrivalOrHotSaleView extends StatefulWidget {
  String tabOne;
  String tabTwo;
  Color selectedLabelColor;
  Color unselectedLabelColor;
  Color indicatorColor;
  Function(int) brandOrProduct;
  TabBarForNewArrivalOrHotSaleView({
    super.key,
    required this.brandOrProduct,
    required this.tabOne,
    required this.tabTwo,
    this.indicatorColor = Colors.black87,
    this.selectedLabelColor = APP_THEME_COLOR,
    this.unselectedLabelColor = Colors.black,
  });

  @override
  State<TabBarForNewArrivalOrHotSaleView> createState() =>
      _TabBarForNewArrivalOrHotSaleViewState();
}

class _TabBarForNewArrivalOrHotSaleViewState
    extends State<TabBarForNewArrivalOrHotSaleView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: scaleWidth(context) / 1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      child: TabBar(
        indicator: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: APP_THEME_COLOR),
        ),
        labelStyle: const TextStyle(
          fontSize: FONT_LARGE,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: FONT_LARGE - 2,
        ),
        onTap: (tab) {
          setState(() {
            widget.brandOrProduct(tab);
          });
        },
        labelColor: widget.selectedLabelColor,
        unselectedLabelColor: widget.unselectedLabelColor,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: widget.indicatorColor,
        indicatorWeight: 1.5,
        tabs: [
          Tab(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(widget.tabOne),
            ),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(widget.tabTwo),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleAndSeeMoreView extends StatelessWidget {
  String? title;
  bool visibleSeeMOreButton;
  Color titleColor;
  double titleSize;
  TextDecoration textDecoration;
  TitleAndSeeMoreView({
    super.key,
    required this.title,
    this.visibleSeeMOreButton = false,
    this.titleColor = Colors.black,
    this.titleSize = FONT_LARGE - 5,
    this.textDecoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title ?? "",
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.w500,
            fontSize: titleSize,
            decoration: textDecoration,
            decorationColor: Colors.black,
          ),
        ),
        const Spacer(),
        Visibility(
          visible: visibleSeeMOreButton,
          child: GestureDetector(
            onTap: () {
              navigateToScreen(
                  context,
                  ProductLineNewVersionPage(
                    comeFromHomePage: true,
                  ));
            },
            child: const Text(
              "See All",
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Colors.black,
                decorationStyle: TextDecorationStyle.solid,
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: FONT_MEDIUM - 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BrandLogoListView extends StatelessWidget {
  const BrandLogoListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: scaleWidth(context) / 3.5,
      child: Consumer<HomePageBloc>(
        builder: (context, bloc, child) => ListView.separated(
          itemBuilder: (context, index) => BrandItemView(
            imageWidth: scaleWidth(context) / 1.5,
            imageHeight: 40,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductLineNewVersionPage(
                    comeFromHomePage: true,
                  ),
                ),
              );
            },
            imageUrl:
                "$BRAND_IMAGE_BASE_URL${bloc.brandList?[index].photoPath}",
          ),
          separatorBuilder: (context, index) =>
              SizedBox(width: scaleWidth(context) / 40),
          itemCount: bloc.brandList?.length ?? 0,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }
}

class BrandItemView extends StatelessWidget {
  String? imageUrl;
  Function onTap;
  double imageHeight;
  double imageWidth;
  BrandItemView({
    super.key,
    required this.onTap,
    required this.imageUrl,
    required this.imageHeight,
    required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
            height: imageHeight,
            width: imageWidth,
            fit: BoxFit.contain,
            imageErrorBuilder: (context, obj, st) {
              return errorImage();
            },
            placeholder:
                const AssetImage("assets/images/place_holder_asset.jpg"),
            image: NetworkImage(imageUrl ?? "")),
      ),
    );
  }
}

class SearchTextFieldView extends StatelessWidget {
  bool readOnly;
  bool isDense;
  Function(String) onSearchDone;
  String hintText;
  int? maxLines;
  bool isMessageSection;
  SearchTextFieldView({
    super.key,
    this.readOnly = false,
    required this.onSearchDone,
    this.hintText = SEARCH_TEXT,
    this.isDense = true,
    this.maxLines = 1,
    this.isMessageSection = false,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 0),
            spreadRadius: 0,
            blurRadius: 10,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        maxLines: maxLines,
        onEditingComplete: () {
          onSearchDone(controller.text);
        },
        decoration: InputDecoration(
          isDense: isDense,
          prefixIcon: (isMessageSection)
              ? null
              : const Icon(
                  Icons.search,
                  color: Colors.black38,
                  size: FONT_LARGE,
                ),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: FONT_MEDIUM - 1,
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}
