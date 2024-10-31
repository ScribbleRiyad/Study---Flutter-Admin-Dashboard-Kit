import 'package:study/models/identifier_model.dart';

class User extends IdentifierModel {
  final String email, firstName, lastName;

  User(super.id, this.email, this.firstName, this.lastName);

  String get name => "$firstName $lastName";

}
