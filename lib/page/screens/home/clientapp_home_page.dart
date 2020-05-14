import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:haircut_delivery/config/all_constants.dart';
import 'package:haircut_delivery/config/marketplace_colors.dart';
import 'package:haircut_delivery/datas/categories.dart';
import 'package:haircut_delivery/datas/client_app_banners.dart';
import 'package:haircut_delivery/datas/client_app_coupons.dart';
import 'package:haircut_delivery/datas/client_app_products.dart';
import 'package:haircut_delivery/datas/client_app_services.dart';
import 'package:haircut_delivery/datas/client_app_shops.dart';
import 'package:haircut_delivery/datas/client_app_top_shop_of_category.dart';
import 'package:haircut_delivery/datas/service_categories.dart';
import 'package:haircut_delivery/model/client_app_coupons.dart';
import 'package:haircut_delivery/model/client_app_service.dart';
import 'package:haircut_delivery/model/client_app_shop.dart';
import 'package:haircut_delivery/model/product.dart';
import 'package:haircut_delivery/page/base_components/appbar/client_app_default_appbar.dart';
import 'package:haircut_delivery/page/base_components/transitions/slide_up_transition.dart';
import 'package:haircut_delivery/page/screens/category/widgets/client_app_category_item.dart';
import 'package:haircut_delivery/page/screens/content/client_app_content_page.dart';
import 'package:haircut_delivery/page/screens/home/widgets/client_app_category_column.dart';
import 'package:haircut_delivery/page/screens/home/widgets/client_app_coupon_item.dart';
import 'package:haircut_delivery/page/screens/home/widgets/client_app_middle_banner_item.dart';
import 'package:haircut_delivery/page/screens/home/widgets/client_app_shop_category_item.dart';
import 'package:haircut_delivery/page/screens/home/widgets/client_app_shop_item.dart';
import 'package:haircut_delivery/page/screens/profile/client_app_shop_profile_page.dart';
import 'package:haircut_delivery/page/screens/service_list/client_app_service_list_page.dart';
import 'package:haircut_delivery/styles/text_style_with_locale.dart';

class ClientAppHomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  ClientAppHomePage({this.scaffoldKey, Key key}) : super(key: key);

  @override
  _ClientAppHomePageState createState() => _ClientAppHomePageState();
}

class _ClientAppHomePageState extends State<ClientAppHomePage>
    with AutomaticKeepAliveClientMixin<ClientAppHomePage> {
  @override
  bool get wantKeepAlive => true;

  double _height;
  ScrollController _scrollController = ScrollController();
  List<ClientAppService> _newList = List<ClientAppService>();

  @override
  void initState() {
    super.initState();
    _newList.addAll(clientAppServices.take(5).toList());
    _height = 130.0 * 5;
  }

  Future<void> _fetch() async {
    setState(() {
      if (_newList.length < 10) {
        _newList
            .addAll(clientAppServices.skip(_newList.length).take(5).toList());
        _height = 130.0 * _newList.length;
      }
    });
  }

  void _goToProfile({@required ClientAppShop shop}) {
    Navigator.push(
      context,
      SlideUpTransition(
        child: ClientAppShopProfilePage(
          shop: shop,
        ),
      ),
    );
  }

  void _goToCouponPage({@required ClientAppCoupon coupon}) {
    Navigator.push(
      context,
      SlideUpTransition(
        child: ClientAppContentPage(
          appbarTitle: 'Coupon',
          image: Image.asset(
            'assets/clientapp/mockup/coupons/${coupon.couponImageUrl}',
            fit: BoxFit.cover,
          ),
          content: coupon.content,
          contentTitle: coupon.title,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context).delegates;
    super.build(context);
    return Stack(children: <Widget>[
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 40),
            _buildBannerSliderSection(),
            _buildCategoriesSliderSection(),
            _buildCouponSection(),
            _buildMiddleBannerSection(),
            _buildPoppularItemsSecion(),
            _buildRecommendedItemsSection(),
            SizedBox(height: 20),
            _buildServiceItemList(),
            _newList.length < 10
                ? Container(
                    color: Colors.white,
                    child: FlatButton(
                      onPressed: _fetch,
                      child: Text(
                        tr("home_see_more"),
                        style: textStyleWithLocale(
                          context: context,
                          fontSize: 16,
                          color: Color(0xff707070),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                : Container(height: 0, width: 0),
          ],
        ),
      ),
      Container(
        height: marketPlaceToolbarHeight,
        child: ClientAppDefaultAppBar(
          context: context,
          scaffoldKey: widget.scaffoldKey,
        ),
      ),
      // Positioned(
      //   child: SearchButton(bgColor: Theme.of(context).primaryColor),
      //   right: 0,
      //   top: 100,
      // ),
    ]);
  }

  /// Builds the banner slider.
  Widget _buildBannerSliderSection() {
    return Container(
      height: 250,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            'assets/clientapp/mockup/banners/${clientAppBannerUrl[index]}',
            fit: BoxFit.cover,
          );
        },
        itemCount: clientAppBannerUrl.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }

  /// Builds the services section.
  Widget _buildCategoriesSliderSection() {
    return Container(
      color: Theme.of(context).primaryColor,
      height: 310,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              offset: Offset(
                0, // horizontal, move right 10
                3.0, // vertical, move down 10
              ),
            ),
          ],
        ),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _buildCategoryRows(index),
              ),
            );
          },
          itemCount: (categoryList.length / 8).ceil(),
          pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              activeColor: MarketplaceColors.PINK_PRICE_ON_CARD_COMPONENT,
              color: MarketplaceColors.GRAY_BORDER_COLOR,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCouponSection() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            tr('home_free_coupons'),
            style: textStyleWithLocale(
              context: context,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              primary: true,
              crossAxisCount: 2,
              childAspectRatio: 1.65,
              children: List.generate(clientAppCoupons.length, (index) {
                return InkWell(
                  onTap: () => _goToCouponPage(coupon: clientAppCoupons[index]),
                  child: ClientAppCouponItem(
                    clientAppCoupon: clientAppCoupons[index],
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 10),
          // Text(
          //   '${AppLocalizations.of(context).tr('marketplace_see_more')}',
          //   textAlign: TextAlign.center,
          //   style: textStyleWithLocale(
          //     context: context,
          //     color: Colors.white,
          //     fontSize: 14,
          //     decoration: TextDecoration.underline,
          //   ),
          // ),
        ],
      ),
    );
  }

  List<Widget> _buildCategoryRows(int index) {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClientAppCategoryColumn(
            category: index * 8 < serviceCategories.length
                ? serviceCategories[(index * 8)]
                : null,
          ),
          ClientAppCategoryColumn(
            category: (index * 8) + 1 < serviceCategories.length
                ? serviceCategories[(index * 8) + 1]
                : null,
          ),
          ClientAppCategoryColumn(
            category: (index * 8) + 2 < serviceCategories.length
                ? serviceCategories[(index * 8) + 2]
                : null,
          ),
          ClientAppCategoryColumn(
            category: (index * 8) + 3 < serviceCategories.length
                ? serviceCategories[(index * 8) + 3]
                : null,
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClientAppCategoryColumn(
              category: (index * 8) + 4 < serviceCategories.length
                  ? serviceCategories[(index * 8) + 4]
                  : null),
          ClientAppCategoryColumn(
              category: (index * 8) + 5 < serviceCategories.length
                  ? serviceCategories[(index * 8) + 5]
                  : null),
          ClientAppCategoryColumn(
              category: (index * 8) + 6 < serviceCategories.length
                  ? serviceCategories[(index * 8) + 6]
                  : null),
          ClientAppCategoryColumn(
              category: (index * 8) + 7 < serviceCategories.length
                  ? serviceCategories[(index * 8) + 7]
                  : null),
        ],
      ),
    ];
  }

  Widget _buildMiddleBannerSection() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            children: _buildMidleBanners(banners: clientAppMiddleBannerUrl),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMidleBanners({List<String> banners}) {
    List<Widget> widgets = [];
    if (banners.length > 0) {
      banners.forEach((bann) {
        widgets.add(ClientAppMiddleBannerItem(
          banner: bann,
        ));
      });
    } else {
      widgets.add(Container());
    }

    return widgets;
  }

  Widget _buildPoppularItemsSecion() {
    return Container(
      height: 250,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildPoppularItemsLabel(),
          SizedBox(height: 5),
          _buildPoppularItemsProductsList(),
        ],
      ),
    );
  }

  Widget _buildPoppularItemsLabel() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            tr("home_recommended_product"),
            style: textStyleWithLocale(
              context: context,
              fontSize: 18,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Text(
          '',
          style: textStyleWithLocale(
            context: context,
            fontSize: 13,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPoppularItemsProductsList() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return _buildProductItem(product: clientAppTopProducts[index]);
        },
        itemCount: clientAppTopProducts.length,
      ),
    );
  }

  Widget _buildProductItem({Product product}) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3.0,
            offset: Offset(
              0, // horizontal, move right 10
              3.0, // vertical, move down 10
            ),
          ),
        ],
      ),
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 150,
            height: 100,
            child: Image.asset(
                'assets/clientapp/mockup/products/${product.productImageUrl[0]}'),
          ),
          SizedBox(height: 5),
          Text(
            '${product.productName}',
            style: textStyleWithLocale(
              context: context,
              fontSize: 12,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '฿ ${product.salePrice != null ? product.salePrice : product.price}',
            style: textStyleWithLocale(
              context: context,
              color: MarketplaceColors.PINK_PRICE_ON_CARD_COMPONENT,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedItemsSection() {
    return Container(
      margin: EdgeInsets.only(left: 15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            tr("home_recommended_shop"),
            style: textStyleWithLocale(
              context: context,
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          Text(
            tr("home_popular_shop"),
            style: textStyleWithLocale(
              context: context,
              color: Theme.of(context).primaryColor,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          _buildRecommendedShopByCategory(),
        ],
      ),
    );
  }

  Widget _buildRecommendedShopByCategory() {
    return Container(
      height: 145,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                SlideUpTransition(
                  child: ClientAppServiceListPage(
                    category: topShopOfCategory[index],
                    serviceType: ServiceType.BOOKING,
                  ),
                ),
              );
            },
            child:
                ClientAppShopCategoryItem(category: topShopOfCategory[index]),
          );
        },
        itemCount: topShopOfCategory.length,
      ),
    );
  }

  Widget _buildServiceItemList() {
    return Container(
      color: Colors.white,
      height: _height,
      child: ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (BuildContext context, int index) {
          final profile = clientAppShops
              .firstWhere((shop) => shop.shopId == _newList[index].shopId);

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                SlideUpTransition(
                  child: ClientAppShopProfilePage(
                    shop: clientAppShops.firstWhere(
                        (shop) => shop.shopId == _newList[index].shopId),
                  ),
                ),
              );
            },
            child: ClientAppServiceItem(
              clientAppService: _newList[index],
              shop: profile,
              callback: () => _goToProfile(shop: profile),
            ),
          );
        },
        itemCount: _newList.length,
      ),
    );
  }
}
