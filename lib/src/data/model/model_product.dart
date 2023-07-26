import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_file.dart';
import 'package:heidi/src/data/model/model_image.dart';
import 'package:heidi/src/data/model/model_open_time.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class ProductModel {
  final int id;
  final int userId;
  final int? subcategoryId;
  final int? categoryId;
  final int? cityId;
  final int? villageId;
  final int? statusId;
  final String title;
  final String image;
  final String? videoURL;
  final String? category;
  final String startDate;
  final String endDate;
  final String createDate;
  final String? dateEstablish;
  final double? rate;
  final num? numRate;
  final String? rateText;
  final String? status;
  @Default(false)
  bool favorite;
  final String address;
  final String? zipCode;
  final String phone;
  final String? fax;
  final String email;
  final String website;
  final String description;
  final String? color;
  final String? icon;
  final List<CategoryModel>? tags;
  final String? price;
  final String? priceMin;
  final String? priceMax;
  final CategoryModel? country;
  final CategoryModel? city;
  final CategoryModel? state;
  final UserModel? author;
  final List<ImageModel>? galleries;
  final List<CategoryModel>? features;
  final List<ProductModel>? related;
  final List<ProductModel>? latest;
  final List<OpenTimeModel>? openHours;
  final Map<String, dynamic>? socials;
  final List<FileModel>? attachments;
  final LocationData? location;
  final String? link;
  final bool? bookingUse;
  final String? bookingStyle;
  final String? priceDisplay;

  ProductModel(
      {required this.id,
      required this.title,
      required this.image,
      this.videoURL,
      this.category,
      required this.startDate,
      required this.endDate,
      required this.createDate,
      this.dateEstablish,
      this.rate,
      this.numRate,
      this.rateText,
      this.status,
      required this.favorite,
      required this.address,
      this.zipCode,
      required this.phone,
      this.fax,
      required this.email,
      required this.website,
      required this.description,
      this.color,
      this.icon,
      this.tags,
      this.price,
      this.priceMin,
      this.priceMax,
      this.country,
      this.city,
      this.state,
      this.author,
      this.galleries,
      this.features,
      this.related,
      this.latest,
      this.openHours,
      this.socials,
      this.location,
      this.attachments,
      this.link,
      this.bookingUse,
      this.bookingStyle,
      this.priceDisplay,
      this.categoryId,
      this.subcategoryId,
      required this.userId,
      this.cityId,
      this.villageId,
      this.statusId});

  factory ProductModel.fromJson(
    Map<String, dynamic> json, {
    SettingModel? setting,
  }) {
    List<ImageModel> galleries = [];
    List<CategoryModel> features = [];
    List<OpenTimeModel> openHours = [];
    List<FileModel> attachments = [];
    List<CategoryModel> tags = [];
    Map<String, dynamic> socials = {};
    UserModel? author;
    String? category;
    LocationData? location;
    CategoryModel? country;
    CategoryModel? state;
    CategoryModel? city;
    String status = '';
    String videoURL = '';
    String startDate = '';
    String endDate = '';
    String createDate = '';
    String priceMin = '';
    String priceMax = '';
    String priceDisplay = '';

    if (json['author'] != null) {
      author = UserModel.fromJson(json['author']);
    }

    if (json['categoryId'] == 1) {
      category = "Nachricht";
      final parsedDateTime = DateTime.parse(json['createdAt']);
      createDate = DateFormat('dd.MM.yyyy').format(parsedDateTime);
    } else if (json['categoryId'] == 2) {
      category = "Straßenarbeiten/Verkehr";
    } else if (json['categoryId'] == 3) {
      category = "Veranstaltungen";
      final parsedDateTime = DateTime.parse(json['startDate']);
      startDate = DateFormat('dd.MM.yyyy').format(parsedDateTime);
      final parsedEDateTime = DateTime.parse(json['endDate']);
      endDate = DateFormat('dd.MM.yyyy').format(parsedEDateTime);
      // startDate = json['startDate'];
      // endDate = json['endDate'];
    } else if (json['categoryId'] == 4) {
      category = "Vereine";
    } else if (json['categoryId'] == 5) {
      category = "Regionale Produkte";
    } else if (json['categoryId'] == 6) {
      category = "Angebot/Suche";
    } else if (json['categoryId'] == 7) {
      category = "Bürgerinfo";
    } else if (json['categoryId'] == 8) {
      category = "Mängelbericht";
    } else if (json['categoryId'] == 9) {
      category = "Verloren gefunden";
    } else if (json['categoryId'] == 10) {
      category = "Firmenporträts";
    } else if (json['categoryId'] == 11) {
      category = "Fahrgemeinschaften/Öffentliche Verkehrsmittel";
    } else if (json['categoryId'] == 11) {
      category = "Angebote";
    }

    final listRelated = List.from(json['related'] ?? []).map((item) {
      return ProductModel.fromJson(item, setting: setting);
    }).toList();

    final listLatest = List.from(json['lastest'] ?? []).map((item) {
      return ProductModel.fromJson(item, setting: setting);
    }).toList();

    final bookingUse = json['booking_use'] == true;
    if (bookingUse) {
      priceDisplay = json['booking_price_display'];
    }

    return ProductModel(
      id: json['id'],
      userId: json['userId'] ?? 0,
      title: json['title'] ?? '',
      image: json['logo'] ?? 'admin/News.jpeg',
      videoURL: videoURL,
      category: category ?? '',
      createDate: createDate,
      startDate: startDate,
      endDate: endDate,
      rate: double.tryParse('${json['rating_avg']}') ?? 0.0,
      numRate: json['rating_count'] ?? 0,
      rateText: json['post_status'] ?? '',
      status: status,
      favorite: json['wishlist'] ?? false,
      address: json['address'] ?? '',
      zipCode: json['zip_code'] ?? '',
      phone: json['phone'] ?? '',
      fax: json['fax'] ?? '',
      email: json['email'] ?? '',
      website: json['website'] ?? '',
      description: json['description'] ?? '',
      color: json['color'] ?? '',
      categoryId: json['categoryId'] ?? 0,
      subcategoryId: json['subcategoryId'] ?? 0,
      cityId: json['cityId'] ?? 0,
      villageId: json['villageId'] ?? 0,
      statusId: json['statusId'] ?? 0,
      icon: json['icon'] ?? '',
      tags: tags,
      price: json['booking_price'] ?? '',
      priceMin: priceMin,
      priceMax: priceMax,
      country: country,
      state: state,
      city: city,
      features: features,
      author: author,
      galleries: galleries,
      related: listRelated,
      latest: listLatest,
      openHours: openHours,
      socials: socials,
      location: location,
      attachments: attachments,
      link: json['guid'] ?? '',
      bookingUse: bookingUse,
      bookingStyle: json['booking_style'] ?? '',
      priceDisplay: priceDisplay,
    );
  }

  factory ProductModel.fromNotification(Map<String, dynamic> json) {
    return ProductModel(
      id: int.tryParse('${json['id']}') ?? 0,
      userId: json['userId'] ?? 0,
      title: json['post_title'] ?? '',
      image: json['logo'],
      // image: ImageModel.fromJson(json['image'] ?? {'full': {}, 'thumb': {}}),
      videoURL: '',
      createDate: '',
      startDate: '',
      endDate: '',
      rate: double.tryParse('${json['rating_avg']}') ?? 0.0,
      numRate: 0,
      categoryId: 0,
      subcategoryId: 0,
      statusId: 0,
      cityId: 0,
      villageId: 0,
      rateText: '',
      status: '',
      favorite: false,
      address: '',
      zipCode: '',
      phone: '',
      fax: '',
      email: '',
      website: '',
      description: '',
      color: '',
      icon: '',
      tags: [],
      price: '',
      priceMin: '',
      priceMax: '',
      features: [],
      galleries: [],
      related: [],
      latest: [],
      openHours: [],
      socials: {},
      attachments: [],
      link: '',
      bookingUse: false,
      bookingStyle: '',
      priceDisplay: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "title": title,
      "image": {
        "id": 0,
        "full": {},
        "thumb": {},
      },
    };
  }
}