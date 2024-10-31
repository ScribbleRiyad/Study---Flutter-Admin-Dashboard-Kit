import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:study/helpers/services/json_decoder.dart';
import 'package:study/images.dart';
import 'package:study/models/identifier_model.dart';

class OrganizationListModel extends IdentifierModel {
  final String name, address, email, contactNumber, city, image;
  final int numberOfCourses, staffQuantity;

  OrganizationListModel(
    super.id,
    this.name,
    this.address,
    this.email,
    this.contactNumber,
    this.city,
    this.image,
    this.numberOfCourses,
    this.staffQuantity,
  );

  static OrganizationListModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String name = decoder.getString('name');
    String address = decoder.getString('address');
    String email = decoder.getString('email');
    String contactNumber = decoder.getString('contact_number');
    String city = decoder.getString('city');
    String image = Images.randomImage(Images.schools);
    int numberOfCourses = decoder.getInt('number_of_course');
    int staffQuantity = decoder.getInt('staff_quantity');

    return OrganizationListModel(
      decoder.getId,
      name,
      address,
      email,
      contactNumber,
      city,
      image,
      numberOfCourses,
      staffQuantity,
    );
  }

  static List<OrganizationListModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => OrganizationListModel.fromJSON(e)).toList();
  }

  static List<OrganizationListModel>? _dummyList;

  static Future<List<OrganizationListModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!.sublist(0, 19);
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/organization_list.json');
  }
}
