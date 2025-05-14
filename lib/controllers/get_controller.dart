import 'dart:async';
import 'dart:convert';
import 'package:epubx/epubx.dart' as epub;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_epub_viewer/flutter_epub_viewer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ildiz_kitoblari/resource/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../bottomBar/accaunt_page.dart';
import '../bottomBar/basket_page.dart';
import '../bottomBar/home_page.dart';
import '../bottomBar/library_page.dart';
import '../bottomBar/shop_page.dart';
import '../models/author_detail_model.dart';
import '../models/author_model.dart';
import '../models/banner_model.dart';
import '../models/basket/cart_create.dart';
import '../models/basket/basket_model.dart';
import '../models/basket/get_price.dart';
import '../models/books/books_model.dart';
import '../models/library/audio_fragment.dart';
import '../models/library/audio_library_list.dart';
import '../models/library/audio_review_model.dart';
import '../models/login_model.dart';
import '../models/me_models.dart';
import '../models/menu_detail.dart';
import '../models/menu_model.dart';
import '../models/menu_options.dart';
import '../models/notification_model.dart';
import '../models/orders/country_model.dart';
import '../models/orders/order_create_model.dart';
import '../models/orders/order_detail_model.dart';
import '../models/orders/order_list.dart';
import '../models/orders/order_list_detail.dart';
import '../models/orders/region_model.dart';
import '../models/product_audio_model.dart';
import '../models/product_detail_model.dart';
import '../models/product_model.dart';
import '../models/product_rate.dart';
import '../models/quotos_model.dart';
import '../models/shop/shop_data_model.dart';
import '../models/user/about_model.dart';
import '../models/user/contact_us_model.dart';
import '../models/user/offer_model.dart';
import '../models/user/partner_model.dart';
import '../pages/sample_page.dart';
import 'api_controller.dart';

class GetController extends GetxController {
  var height = 0.0.obs;
  var width = 0.0.obs;
  var fullName = 'Dilshodjon Haydarov'.obs;
  late EpubController epubController;
  var onLoading = false.obs;
  var check = false.obs;
  var widgetOptions = <Widget>[];
  var index = 0.obs;
  var bottomBarHeight = 0.0.obs;
  var obscureText = true.obs;
  var fullCheck = false.obs;
  var fullIndex = 0.obs;
  var indexSub = 0.obs;
  var page = 0.obs;
  var itemPage = 0.obs;
  var productModelLength = 0.obs;
  var passwordCheck = false.obs;
  var editCheck = false.obs;
  var image = ''.obs;
  List filters = <bool>[false,false,false,false,false,false].obs;
  List filtersObj = ['','',[]].obs;
  List filtersListSelect = [].obs;
  List filterGenre = [].obs;
  List filtersPage = [].obs;
  var genreIndex = 0.obs;
  var genreIndexSub = 0.obs;
  var genreIndexSubSub = 0.obs;
  var checkBoxCardList = <bool>[].obs;
  var checkEBoxCardList = <bool>[].obs;
  var allCheckBoxCard = false.obs;
  var allECheckBoxCard = false.obs;
  List dropDownOrders = <int>[].obs;
  var paymentTypeIndex = 0.obs;
  var deliveryPrice = ''.obs;
  var brightness = 0.5.obs;
  RxBool whileApi = true.obs;
  RxList allPages = <int>[].obs;
  RxBool isOver = false.obs;
  RxInt currentIndex = 0.obs;
  Rx<Color> backgroundColor = Colors.white.obs;
  Rx<Color> textColor = Colors.black.obs;
  RxDouble fontSize = 18.0.obs;
  RxBool isVertical = false.obs;
  RxList<String> fontNames = ["Segoe", "Alegreya", "Amazon Ember", "Atkinson Hyperlegible", "Bitter Pro", "Bookerly", "Droid Sans", "EB Garamond", "Gentium Book Plus", "Halant", "IBM Plex Sans", "LinLibertine", "Literata", "Lora", "Ubuntu"].obs;
  RxString selectedFont = "Segoe".obs;


  Future<Map<String, String>> getEpubMetadata(String epubUrl) async {
    try {
      // EPUB faylni URL orqali yuklash
      final response = await http.get(Uri.parse(epubUrl));
      final bytes = response.bodyBytes;

      // EPUB faylni o'qish
      final book = await epub.EpubReader.readBook(bytes);

      // Kitob nomi va muallifni olish
      final title = book.Title ?? 'Noma’lum kitob';
      final author = book.Author ?? 'Noma’lum muallif';

      return {
        'title': title,
        'author': author,
      };
    } catch (e) {
      print('Metama’lumotlarni olishda xato: $e');
      return {
        'title': 'Noma’lum kitob',
        'author': 'Noma’lum muallif',
      };
    }
  }

  //write getstore text size
  void saveTextSize(textSize) => GetStorage().write('textSize', textSize);

  void increaseTextSize() {
    if (fontSize.value == 30) return;
    textSize;
    fontSize.value += 1;
    saveTextSize(fontSize.value);
    print(fontSize.value);
  }

  void decreaseTextSize() {
    if (fontSize.value == 10) return;
    textSize;
    fontSize.value -= 1;
    saveTextSize(fontSize.value);
    print(fontSize.value);
  }

  double get textSize {
    if (GetStorage().read('textSize') != null) {
      fontSize.value = GetStorage().read('textSize');
      return GetStorage().read('textSize');
    } else {
      fontSize.value = 16.0;
      return 16.0;
    }
  }

  void changeSelectedFont(int index) {
    if (index < 0) {
      selectedFont.value = fontNames[0];
    } else if (index >= fontNames.length) {
      selectedFont.value = fontNames[fontNames.length - 1];
    }
    selectedFont.value = fontNames[index];
    saveFont(fontNames[index]);
  }

  //write font
  void saveFont(String font) {
    selectedFont.value = font;
    GetStorage().write('font', font);
  }

  String get font {
    if (GetStorage().read('font') != null) {
      selectedFont.value = GetStorage().read('font');
      return GetStorage().read('font');
    } else {
      selectedFont.value = 'Segoe';
      return 'Segoe';
    }
  }

  //write theme color
  void saveThemeColor(index) {
    print(index);
    if (index == 0) {
      backgroundColor.value = AppColors.white;
      textColor.value = AppColors.black;
      GetStorage().write('themeColor', index);
    } else if (index == 1) {
      backgroundColor.value = AppColors.trueToneColor;
      textColor.value = AppColors.black;
      GetStorage().write('themeColor', index);
    } else if (index == 2) {
      backgroundColor.value = AppColors.grey;
      textColor.value = AppColors.black;
      GetStorage().write('themeColor', index);
    } else if (index == 3) {
      backgroundColor.value = AppColors.midnightBlack;
      textColor.value = AppColors.white;
      GetStorage().write('themeColor', index);
    } else {
      backgroundColor.value = AppColors.black;
      textColor.value = AppColors.white;
      GetStorage().write('themeColor', index);
    }
  }

  get themeColor {
    if (GetStorage().read('themeColor') != null) {
      var colors = GetStorage().read('themeColor');
      backgroundColor.value = colors == 0 ? AppColors.white : colors == 1 ? AppColors.trueToneColor : colors == 2 ? AppColors.grey : colors == 3 ? AppColors.midnightBlack : AppColors.black;
      return AppColors.primaryColor;
    } else {
      backgroundColor.value = Colors.white;
      return Colors.white;
    }
  }

  //write oriantation
  void saveOrientation(bool orientation) {
    isVertical.value = orientation;
    GetStorage().write('orientation', orientation);
  }

  bool get orientation {
    if (GetStorage().read('orientation') != null) {
      isVertical.value = GetStorage().read('orientation');
      return GetStorage().read('orientation');
    } else {
      isVertical.value = false;
      return false;
    }
  }

  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness.instance.setSystemScreenBrightness(brightness);
    } catch (e) {
      debugPrint("Failed to set brightness: $e");
    }
  }

  void getSystemBrightness() async {
    try {
      brightness.value = await ScreenBrightness().system;
    } catch (e) {
      debugPrint("Failed to get brightness: $e");
    }
  }



  void changeCheckBoxCardList(int i) {
    checkBoxCardList[i] = !checkBoxCardList[i];
    bool allChecked = checkBoxCardList.every((element) => element);
    allCheckBoxCard.value = allChecked;
    ApiController().getTotalBasketPrice();
  }

  void changeECheckBoxCardList(int i) {
    checkEBoxCardList[i] = !checkEBoxCardList[i];
    bool allChecked = checkEBoxCardList.every((element) => element);
    allECheckBoxCard.value = allChecked;
    ApiController().getETotalBasketPrice();
  }

  void changeAllCheckBoxCardList() {
    if (allCheckBoxCard.value) {
      for (int i = 0; i < checkBoxCardList.length; i++) {
        checkBoxCardList[i] = true;
      }
    } else {
      for (int i = 0; i < checkBoxCardList.length; i++) {
        checkBoxCardList[i] = false;
      }
    }
    ApiController().getTotalBasketPrice();
  }

  void changeAllECheckBoxCardList() {
    if (allECheckBoxCard.value) {
      for (int i = 0; i < checkEBoxCardList.length; i++) {
        checkEBoxCardList[i] = true;
      }
    } else {
      for (int i = 0; i < checkEBoxCardList.length; i++) {
        checkEBoxCardList[i] = false;
      }
    }
    ApiController().getETotalBasketPrice();
  }

  void onLoad() {
    if (!onLoading.value) {
      onLoading.value = true;
    }
  }

  void offLoad() {
    if (onLoading.value) {
      onLoading.value = false;
    }
  }

  void addFilterListSelect(value) => filtersListSelect.add(null);

  void changeFilterListSelect(int index,int value){
    if (filtersListSelect[index] == null) {
      filtersListSelect[index] = value;
    } else if (filtersListSelect[index] == value) {
      filtersListSelect[index] = null;
    } else {
      filtersListSelect[index] = value;
    }
  }

  void changeGenreListSelect(int value){
    if (filterGenre[0] == null) {
      filterGenre[0] = value;
    } else if (filterGenre[0] == value) {
      filterGenre[0] = null;
    } else {
      filterGenre[0] = value;
    }
  }

  void changeFilterIndex(index){
    if (index == 0) {
      filters[0] = !filters[0];
      filters[1] = false;
    } else if (index == 1) {
      filters[1] = !filters[1];
      filters[0] = false;
    } else if (index == 2) {
      filters[2] = !filters[2];
      filters[3] = false;
    } else if (index == 3) {
      filters[3] = !filters[3];
      filters[2] = false;
    } else if (index == 4) {
      filters[4] = !filters[4];
      filters[5] = false;
    } else {
      filters[5] = !filters[5];
      filters[4] = false;
    }
  }

  void clearFilters() {
    for (int i = 0; i < filtersListSelect.length; i++) {
      if (filtersListSelect[i] != null) {
        filtersListSelect[i] = null;
      }
    }
    filterGenre[0] = null;
    filtersObj[0] = '';
    filtersObj[1] = '';
    filtersObj[2] = [];
  }

  @override
  void onInit() {
    super.onInit();
    epubController = EpubController();
    filtersObj.add('');
    filtersObj.add('');
  }

  String getMoneyFormat(value) => value == null ? '0' : value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ');

  void setHeightWidth(BuildContext context) {
    height.value = MediaQuery.of(context).size.height;
    width.value = MediaQuery.of(context).size.width;
  }

  Timer? _timerTap;

  void tapTimes(Function onTap, int sec) {
    if (_timerTap != null) stopTimerTap();
    _timerTap = Timer(Duration(seconds: sec), () {
      onTap();
      _timerTap = null;
    });
  }

  void stopTimerTap() => _timerTap!.cancel();

  void changeWidgetOptions() {
    bottomBarHeight.value = height.value * 0.08;
    widgetOptions.add(HomePage());
    widgetOptions.add(ShopPage());
    widgetOptions.add(LibraryPage());
    widgetOptions.add(BasketPage());
    widgetOptions.add(AccountPage());
  }

  void changeIndex(int index) {this.index.value = index;}

  void changePage(int page) {this.page.value = page;}

  void changeItemPage(int itemPage) {this.itemPage.value = itemPage;}

  changeImage(String newImage) {image.value = newImage;}

  getLocale () {
    if (Get.locale != null) {
      return Get.locale.toString();
    } else {
      return 'uz_UZ';
    }
  }

  void saveLanguage(Locale locale) {
    GetStorage().write('language', '${locale.languageCode}_${locale.countryCode}');
    Get.updateLocale(locale);
  }

  void saveFcmToken(String fcmToken) => GetStorage().write('fcmToken', fcmToken);

  String get fcmToken {
    if (GetStorage().read('fcmToken') != null) {
      return GetStorage().read('fcmToken');
    } else {
      return '';
    }
  }

  Locale get language {
    if (GetStorage().read('language') != null) {
      List<String> locale = GetStorage().read('language').toString().split('_');
      return Locale(locale[0], locale[1]);
    } else {
      return const Locale('uz','UZ');
    }
  }

  //models
  var loginModel = LoginModel().obs;
  var meModel = MeModel().obs;
  var menuModel = MenuModel().obs;
  var bannerModel = BannerModel().obs;
  var productModel = ProductModel().obs;
  var productAudioBookModel = ProductModel().obs;
  var productEBookModel = ProductModel().obs;
  var quotesModel = QuotesModel().obs;
  var productDetailModel = ProductDetailModel().obs;
  var productRate = ProductRate().obs;
  var authorModel = AuthorModel().obs;
  var menuDetailModel = MenuDetailModel().obs;
  var productDetailList = <ProductDetailModel>[].obs;
  var productRateList = <ProductRate>[].obs;
  var authorDetailModelList = <AuthorDetailModel>[].obs;
  var authorDetailProductModelList = <ProductModel>[].obs;
  var menuOptionsModel = MenuOptionsModel().obs;
  var menuOptionsModelList = <MenuOptionsModel>[].obs;
  var basketModel = BasketModel().obs;
  var eBasketModel = BasketModel().obs;
  var cartCreate = CartCreate().obs;
  List<CartCreate> listCartCreate = <CartCreate>[].obs;
  var getPriceModel = GetPrice().obs;
  var getEPriceModel = GetPrice().obs;
  var getCountryModel = CountryModel().obs;
  var getRegionModel = RegionModel().obs;
  var orderCreateModel = OrderCreateModel().obs;
  var orderDetailModel = OrderDetailModel().obs;
  var orderListModel = OrderListModel().obs;
  var orderListDetailModel = OrderListDetail().obs;
  var shopDataModel = ShopDataModel().obs;
  var aboutModel = AboutModel().obs;
  var contactUsModel = ContactUsModel().obs;
  var productAudioModel = ProductAudioModel().obs;
  var notificationModel = NotificationModel().obs;
  var notificationCountModel = NotificationCountModel().obs;
  var audioLibraryList = AudioLibraryList().obs;
  var eBookLibraryList = AudioLibraryList().obs;
  var audioFragmentList = AudioFragment().obs;
  var audioReviewModel = AudioReviewModel().obs;
  var partnerModel = PartnerModel().obs;
  var offerModel = OfferModel().obs;

  void changeOfferModel(OfferModel offerModel) => this.offerModel.value = offerModel;

  void changePartnerModel(PartnerModel partnerModel) => this.partnerModel.value = partnerModel;

  void clearPartnerModel() => partnerModel.value = PartnerModel();

  void changeAudioReviewModel(AudioReviewModel audioReviewModel) => this.audioReviewModel.value = audioReviewModel;

  void clearAudioReviewModel() => audioReviewModel.value = AudioReviewModel();

  void changeAudioLibraryList(AudioLibraryList audioLibraryLists) => audioLibraryList.value = audioLibraryLists;

  void clearAudioLibraryList() => audioLibraryList.value = AudioLibraryList();

  void changeEBookLibraryList(AudioLibraryList eBookLibraryLists) => eBookLibraryList.value = eBookLibraryLists;

  void clearEBookLibraryList() => eBookLibraryList.value = AudioLibraryList();

  void changeAudioFragmentList(AudioFragment audioFragmentList) => this.audioFragmentList.value = audioFragmentList;

  void clearAudioFragmentList() => audioFragmentList.value = AudioFragment();

  void changeAudioBookModel(ProductModel productModel) => productAudioBookModel.value = productModel;

  void changeEBookModel(ProductModel productModel) => productEBookModel.value = productModel;

  void changeNotificationCountModel(NotificationCountModel newNotificationCountModel) {notificationCountModel.value = newNotificationCountModel;}

  void changeNotificationModel(NotificationModel newNotificationModels) {notificationModel.value = newNotificationModels;}

  void changeProductAudioModel(ProductAudioModel newProductAudioModel) {productAudioModel.value = newProductAudioModel;}

  void clearProductAudioModel() {productAudioModel.value = ProductAudioModel();}

  void changeContactUsModel(ContactUsModel newContactUsModel) {contactUsModel.value = newContactUsModel;}

  void clearContactUsModel() {contactUsModel.value = ContactUsModel();}

  void changeAboutModel(AboutModel newAboutModel) => aboutModel.value = newAboutModel;

  void clearAboutModel() {aboutModel.value = AboutModel();}

  void changeShopDataModel(ShopDataModel newShopDataModel) {shopDataModel.value = newShopDataModel;}

  void changeShopDataProductModel(ShopProductModel newShopProductModel, int index) {
    if (shopDataModel.value.data != null && shopDataModel.value.data!.result != null) {
      shopDataModel.update((model) {
        model?.data?.result?[index].shopProductModel = newShopProductModel;
      });
    }
  }

  void clearShopDataModel() {shopDataModel.value = ShopDataModel();}

  void clearNotificationModel() {notificationModel.value = NotificationModel();}

  void removeShopDataModelMenu(index) {
    if (shopDataModel.value.data != null && shopDataModel.value.data!.result != null) {
      shopDataModel.value.data!.result?.removeAt(index);
    }
  }

  void insertCountryAtStart(ResultCountry country) {getCountryModel.update((model) {model?.data?.result?.insert(0, country);});}

  void insertRegionAtStart(ResultRegion region) {getRegionModel.update((model) {model?.data?.result?.insert(0, region);});}

  void changeOrderListModel(OrderListModel orderList){orderListModel.value = orderList;}
  void changeOrderListDetailModel(OrderListDetail orderListDetail){orderListDetailModel.value = orderListDetail;}

  void clearOrderListModel(){orderListModel.value = OrderListModel();}

  void clearOrderListDetailModel(){orderListDetailModel.value = OrderListDetail();}

  String getWeight() {
    if (orderDetailModel.value.data != null) {
      double totalWeight = 0;
      for (int i = 0; i < orderDetailModel.value.data!.orderProducts!.length; i++) {
        if (orderDetailModel.value.data!.orderProducts![i].product!.weight != null) {
          totalWeight += orderDetailModel.value.data!.orderProducts![i].orderCount! * orderDetailModel.value.data!.orderProducts![i].product!.weight!;
        } else {
          return 'Xatolikkkkk';
        }
      }
      return totalWeight.toString();
    } else {
      return '0';
    }
  }

  void changeOrderDetailModel(OrderDetailModel orderDetail) {orderDetailModel.value = orderDetail;}

  void clearOrderDetailModel() {orderDetailModel.value = OrderDetailModel();}

  void changeOrderCreateModel(OrderCreateModel orderCreate) {orderCreateModel.value = orderCreate;}

  void clearOrderCreateModel() {orderCreateModel.value = OrderCreateModel();}

  void changeCountryModel(CountryModel countryModel) {getCountryModel.value = countryModel;}

  void changeRegionModel(RegionModel regionModel) {getRegionModel.value = regionModel;}

  void clearRegionModel() {getRegionModel.value = RegionModel();}

  void changeGetPrice(GetPrice getPrice) => getPriceModel.value = getPrice;

  void changeEGetPrice(GetPrice getPrice) => getEPriceModel.value = getPrice;

  void changeBasketModel(BasketModel basketModels) {
    basketModel.value = basketModels;
    listCartCreate.clear();
  }

  void changeEBasketModel(BasketModel basketModels) {
    eBasketModel.value = basketModels;
    GetStorage().remove('cart');
    basketModel.value.data?.result?.forEach((item) {
      listCartCreate.add(CartCreate(
        sId: item.productId,
        count: item.cartCount,
        type: 'active',
        productType: item.productType ?? 'book',
      ));
    });
    eBasketModel.value.data?.result?.forEach((item) {
      if (!listCartCreate.any((cartItem) => cartItem.sId == item.productId)) {
        listCartCreate.add(CartCreate(
          sId: item.productId,
          count: item.cartCount,
          type: 'active',
          productType: item.productType ?? 'book',
        ));
      }
    });

    GetStorage().write('cart', listCartCreate);
    if (allCheckBoxCard.value && listCartCreate.isNotEmpty) {
      ApiController().getTotalBasketPrice();
    }
    if (allECheckBoxCard.value && listCartCreate.isNotEmpty) {
      ApiController().getETotalBasketPrice();
    }
  }

  bool checkCardId(id) {
    if (listCartCreate.isEmpty) return false;
    for (var element in listCartCreate) {
      if (element.sId == id) {
        return true;
      }
    }
    return false;
  }

  String checkCardIdCount(String id) {
    if (GetStorage().read('cart') == null) return '0';
    for (final element in jsonDecode(jsonEncode(GetStorage().read('cart')))) {
      if (element['_id'] == id) {
        return element['count'].toString();
      }
    }
    return '0';
  }

  int checkCardIdIndex(String id) {
    for (var i = 0; i < listCartCreate.length; i++) {
      if (listCartCreate[i].sId == id) {
        return i;
      }
    }
    return 0;
  }

  void clearBasketModel() {
    basketModel.value = BasketModel();
    listCartCreate.clear();
    checkBoxCardList.clear();
  }

  void clearEBasketModel() {
    eBasketModel.value = BasketModel();
    listCartCreate.clear();
    checkEBoxCardList.clear();
  }

  List<String> getMenuOptionsModelListData(int index) {
    if (menuOptionsModelList[index].data!.result!.isNotEmpty) {
      return menuOptionsModelList[index].data!.result!.map((e) => 'uz_UZ' == Get.locale.toString() ? e.name!.uz! : 'oz_OZ' == Get.locale.toString() ? e.name!.oz! : e.name!.ru!).toList();
    } else {
      return [];
    }
  }

  void addMenuOptionsModelList(MenuOptionsModel menuOptionsModel) {
    filtersPage.clear();
    menuOptionsModelList.add(menuOptionsModel);
    for (int i = 0; i < menuOptionsModelList.length; i++) {
      filtersPage.add(1);
    }
  }

  void addMenuOptionsModelListDetail(index, MenuOptionsModel menuOptionsModel) => menuOptionsModelList[index].data!.result!.addAll(menuOptionsModel.data!.result!);

  void changeFiltersPage(int index) => filtersPage[index] = filtersPage[index] + 1;

  void clearMenuOptionsModelList() {
    if (menuOptionsModelList.isNotEmpty) {
      menuOptionsModelList.clear();
    }
  }

  void removeMenuOptionsModelList(int index) {if (menuOptionsModelList.isNotEmpty&&menuOptionsModelList.length>=index){menuOptionsModelList.removeRange(index, menuOptionsModelList.length);}}

  void changeMenuDetailModel(MenuDetailModel menuDetailModel) {this.menuDetailModel.value = menuDetailModel;}

  void clearMenuDetailModel() {if (menuDetailModel.value.data != null) {menuDetailModel.value = MenuDetailModel();}}

  void addAuthorDetailProductModelList(ProductModel productModel) {authorDetailProductModelList.add(productModel);}

  void clearAuthorDetailProductModelList() {authorDetailProductModelList.clear();}

  void removeAuthorDetailProductModelList(int index) {
    if (authorDetailProductModelList.isNotEmpty&&authorDetailProductModelList.length>=index){
      authorDetailProductModelList.removeRange(index, authorDetailProductModelList.length);
    }
  }

  void addAuthorDetailModelList(AuthorDetailModel authorDetailModel) {authorDetailModelList.add(authorDetailModel);}

  void clearAuthorDetailModelList() {authorDetailModelList.clear();}

  void changeAuthorDetailProductModelList(int index, ProductModel productModel) {authorDetailProductModelList[index] = productModel;}

  void addProductDetailModel(ProductDetailModel productDetailModel) {productDetailList.add(productDetailModel);}

  void clearProductDetailList() {
    productDetailList.clear();
    productRateList.clear();
  }

  void removeProductDetailModel(int index) {
    if (productDetailList.isNotEmpty&&productDetailList.length>=index){
      productDetailList.removeRange(index, productDetailList.length);
      removeProductRate(index);
    }
  }

  void addProductRate(ProductRate productRate) {productRateList.add(productRate);}

  void removeProductRate(int index) {
    if (productRateList.isNotEmpty&&productRateList.length>=index){
      productRateList.removeRange(index, productRateList.length);
    }
  }

  void addAuthorDetailModel(AuthorDetailModel authorDetailModel) {authorDetailModelList.add(authorDetailModel);}

  void clearAuthorDetailList() {authorDetailModelList.clear();}

  void removeAuthorDetailModel(int index) {
    if (authorDetailModelList.isNotEmpty&&authorDetailModelList.length>=index){
      authorDetailModelList.removeRange(index, authorDetailModelList.length);
    }
  }

  void clearAudioModel() => productAudioBookModel.value = ProductModel();

  void clearEBookModel() => productEBookModel.value = ProductModel();

  void clearMenuModel() {
    if (menuModel.value.data != null && menuModel.value.data!.result != null && menuModel.value.data!.result!.isNotEmpty) {
      menuModel.value.data!.result!.clear();
    }
  }

  void changeLoginModel(LoginModel loginModel) {this.loginModel.value = loginModel;}

  void changeMeModel(MeModel meModel) => this.meModel.value = meModel;

  void clearMeModel() {
    if (meModel.value.data != null) {
      meModel.value = MeModel();
    }
  }

  void changeMenuModel(MenuModel menuModel) {this.menuModel.value = menuModel;}

  void deleteMenuModel(int index) {
    if (menuModel.value.data != null && menuModel.value.data!.result != null && menuModel.value.data!.result!.isNotEmpty && index <= menuModel.value.data!.result!.length) {
      menuModel.value.data!.result!.removeAt(index);
    }
  }

  void changeBannerModel(BannerModel bannerModel) {this.bannerModel.value = bannerModel;}

  void clearBannerModel() {
    if (bannerModel.value.data != null) {
      bannerModel.value = BannerModel();
    }
  }

  void addBannerModel(BannerModel bannerModel) => this.bannerModel.value.data!.result!.addAll(bannerModel.data!.result!);

  void changeProductModel(ProductModel productModel) => this.productModel.value = productModel;

  void addProductModel(ProductModel productModel) => this.productModel.value.data!.result!.addAll(productModel.data!.result!);

  void changeQuotesModel(QuotesModel quotesModel) => this.quotesModel.value = quotesModel;

  void addQuotesModel(QuotesModel quotesModel) => this.quotesModel.value.data!.result!.addAll(quotesModel.data!.result!);

  void clearQuotesModel() {
    if (quotesModel.value.data != null) {
      quotesModel.value = QuotesModel();
    }
  }

  void changeAuthorModel(AuthorModel authorModel) {
    this.authorModel.value = authorModel;
    productModelLength.value = authorModel.data!.result!.length;
  }

  void clearAuthorModel() {
    if (authorModel.value.data != null) {
      productModelLength.value = 0;
      authorModel.value = AuthorModel();
    }
  }

  void addAuthorModel(AuthorModel authorModel) {
    this.authorModel.value.data!.result!.addAll(authorModel.data!.result!);
    productModelLength.value = productModelLength.value + authorModel.data!.result!.length;
  }

  void changeProductDetailModel(ProductDetailModel productDetailModel) {this.productDetailModel.value = productDetailModel;}

  void clearProductDetailModel() {
    if (productDetailModel.value.data != null) {
      productDetailModel.value = ProductDetailModel();
    }
  }

  void clearProductModel() {
    if (productModel.value.data != null) {
      productModelLength.value = 0;
      productModel.value.data!.result!.clear();
    }
  }

  void changeProductRate(ProductRate productRate) {this.productRate.value = productRate;}

  void clearProductRate() {
    if (productRate.value.data != null) {
      productRate.value = ProductRate();
    }
  }

  void addPage() {page.value++;}

  void addItemPage() {itemPage.value++;}

  void changeProductModelLength(int length) => productModelLength.value = length;

  final countdownDuration = const Duration(minutes: 1, seconds: 59).obs;
  Timer? _timer;
  void startTimer() {const oneSec = Duration(seconds: 1);
  _timer = Timer.periodic(
    oneSec,
        (timer) {
      if (countdownDuration.value.inSeconds == 0) {
        timer.cancel();
      } else {
        countdownDuration.value = countdownDuration.value - oneSec;
      }
    },
  );
  }

  void stopTimer() {_timer!.cancel();}

  void resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    countdownDuration.value = const Duration(minutes: 1, seconds: 59);
    startTimer();
  }

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController startPriceController = TextEditingController();
  final TextEditingController endPriceController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final List<TextEditingController> textControllers = [];

  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final RefreshController refreshLibController = RefreshController(initialRefresh: false);
  final RefreshController refreshNotifyController = RefreshController(initialRefresh: false);
  final SwiperController swiperController = SwiperController();
  late TabController tabController;
  late final WebViewController controller;

  double calculateTotalHeight(int value) {
    if (value == 0) {
      if (basketModel.value.data != null && basketModel.value.data!.result != null) {
        if (basketModel.value.data!.result!.length < 3) {
          return Get.height * 0.7;
        }else {
          return basketModel.value.data!.result!.length * 131.h + 90;
        }
      } else {
        return Get.height * 0.7;
      }
    } else {
      if (eBasketModel.value.data != null && eBasketModel.value.data!.result != null) {
        if (eBasketModel.value.data!.result!.length < 3) {
          return Get.height * 0.7;
        } else {
          return eBasketModel.value.data!.result!.length * 131.h + 90;
        }
      } else {
        return Get.height * 0.7;
      }
    }

  }

  String getPrice() {
    int total = 0;
    if (allCheckBoxCard.value && basketModel.value.data != null && basketModel.value.data?.result != null) {
      for (var item in basketModel.value.data!.result!) {
        if (item.price != null) {
          total += item.price!;
        }
      }
      return total.toString();
    } else if (!allCheckBoxCard.value &&basketModel.value.data != null && basketModel.value.data?.result != null) {
      for (int i = 0; i < checkBoxCardList.length; i++) {
        if (checkBoxCardList[i] && basketModel.value.data!.result![i].price != null) {
          total += basketModel.value.data!.result![i].price!;
        }
      }
      return total.toString() == '0' ? '0' : total.toString();
    } else {
      return '0';
    }
  }

  String getEbookPrice() {
    int total = 0;
    if (allECheckBoxCard.value && eBasketModel.value.data != null && eBasketModel.value.data?.result != null) {
      for (var item in eBasketModel.value.data!.result!) {
        if (item.price != null) {
          total += item.price!;
        }
      }
      return total.toString();
    } else if (!allECheckBoxCard.value &&eBasketModel.value.data != null && eBasketModel.value.data?.result != null) {
      for (int i = 0; i < checkEBoxCardList.length; i++) {
        if (checkEBoxCardList[i] && eBasketModel.value.data!.result![i].price != null) {
          total += eBasketModel.value.data!.result![i].price!;
        }
      }
      return total.toString() == '0' ? '0' : total.toString();
    } else {
      return '0';
    }
  }

  String getSelectedCard() {
    if (allCheckBoxCard.value && listCartCreate.isNotEmpty) {
      var data = jsonEncode(listCartCreate.where((item) => item.productType == 'book').toList(),).toString();
      return data;
    } else if (!allCheckBoxCard.value && listCartCreate.isNotEmpty) {
      var data = jsonEncode(checkBoxCardList.asMap().entries.where((entry) => entry.value).map((entry) => listCartCreate[entry.key]).where((item) => item.productType == 'book').toList(),).toString();
      return data;
    } else {
      return '[]';
    }
  }

  String getSelectedECard() {
    if (allECheckBoxCard.value && listCartCreate.isNotEmpty) {
      var data = jsonEncode(listCartCreate.where((item) => item.productType != 'book').toList(),).toString();
      return data;
    } else if (!allECheckBoxCard.value && listCartCreate.isNotEmpty) {
      var data = listCartCreate.where((item) => item.productType != 'book').toList();
      var data2 = [];
      for (int i = 0; i < checkEBoxCardList.length; i++) {
        if (checkEBoxCardList[i]) {
          data2.add(data[i]);
        }
      }
      return jsonEncode(data2).toString();
    } else {
      return '[]';
    }
  }

  void addTextControllers() => textControllers.add(TextEditingController());

  void clearControllers() {
    if (textControllers.isNotEmpty) {
      textControllers.clear();
    }
  }

  String getFilterTextFields() {
    String params = '';
    for (int index = 0; textControllers.length > index; index++) {
      if (textControllers[index].text != '') {
        params = '$params&value[]=${textControllers[index].text}';
      }
    }
    if (params.isNotEmpty) {
      return params;
    } else {
      return '';
    }
  }

  String getFilterTextSelect() {
    String params = '';
    for (int index = 0; filtersListSelect.length > index; index++) {
      if (filtersListSelect[index] != null && filtersListSelect[index] != -1) {
        params = '$params&value_id[]=${menuOptionsModelList[index].data!.result![filtersListSelect[index]].sId}';
      }
    }
    if (params.isNotEmpty) {
      return params;
    } else {
      return '';
    }
  }

  String getDistrict() {
    if (getRegionModel.value.data!.result!.isNotEmpty) {
      if (getRegionModel.value.data!.result![dropDownOrders[1]].sId != null) {
        debugPrint('${getRegionModel.value.data!.result![dropDownOrders[1]].sId}');
        return getRegionModel.value.data!.result![dropDownOrders[1]].sId ?? '';
      }
    }
    return '';
  }

  String getCountry() {
    if ( getCountryModel.value.data!.result!.isNotEmpty) {
      if (getCountryModel.value.data!.result![dropDownOrders[0]].sId != null) {
        debugPrint('${getCountryModel.value.data!.result![dropDownOrders[0]].sId}');
        return getCountryModel.value.data!.result![dropDownOrders[0]].sId ?? '';
      }
    }
    return '';
  }

  RxBool isFullScreen = true.obs;


  void toggleFullScreen() {
    debugPrint('toggleFullScreen');
    isFullScreen.value = !isFullScreen.value;
    if (isFullScreen.value) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    }
  }


  //=========================================================================================================================================================

  final ScrollController scrollController = ScrollController();

  void setCurrentIndex(int index) => currentIndex.value = index;

  void setBackgroundColor(Color color) => backgroundColor.value = color;


  Rx<BooksModel> booksModel = BooksModel().obs;

  void changeBooksModel(BooksModel booksModels) => booksModel.value = booksModels;

  //clearBooksModel
  void clearBooksModel() {
    booksModel.value = BooksModel();
    allPages.clear();
    currentIndex.value = 0;
    isOver.value = false;
  }

}