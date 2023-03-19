class UserDetails {
  final String firstName, lastName, shippingAddress, email, city, mobile;
  final int id;

  UserDetails(this.firstName, this.lastName, this.shippingAddress, this.email,
      this.city, this.id, this.mobile);

  factory UserDetails.fromJson(Map<String, dynamic> map) {
    return UserDetails(
      map['firstName'],
      map['lastName'],
      map['shippingAddress'],
      map['email'],
      map['city'],
      map['id'],
      map['mobile'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['id'] = id;
    map['shippingAddress'] = shippingAddress;
    map['email'] = email;
    map['mobile'] = mobile;
    map['city'] = city;
    return map;
  }
}
