class Urls {
  static const String baseUrl = 'https://craftybay.teamrabbil.com/api';
  static const String productSliderUrl = '$baseUrl/ListProductSlider';
  static const String productCategoryUrl = '$baseUrl/CategoryList';
  static const String readProfileDetails = '$baseUrl/ReadProfile';
  static const String addToCartUrl = '$baseUrl/CreateCartList';

  static String productByRemarksUrl(String remarks) =>
      '$baseUrl/ListProductByRemark/$remarks';

  static String productByCategoryUrl(String categoryId) =>
      '$baseUrl/ListProductByCategory/$categoryId';

  static String productDetailsByIdUrl(int productId) =>
      '$baseUrl/ProductDetailsById/$productId';

  static String sendOtpToEmail(String email) =>
      '$baseUrl/UserLogin/$email';

  static String verifyOtp(String email, String otp) =>
      '$baseUrl/VerifyLogin/$email/$otp';
}