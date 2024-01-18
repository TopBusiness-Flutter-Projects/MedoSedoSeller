class RegisterModel {
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? password;
  String? confirmPassword;
  String? shopName;
  int? isFactory;
  String? shopAddress;
  RegisterModel(
      {this.fName,
      this.lName,
      this.phone,
      this.isFactory = 0,
      this.email,
      this.password,
      this.confirmPassword,
      this.shopName,
      this.shopAddress});
}
