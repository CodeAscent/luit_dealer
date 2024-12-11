import 'package:luit_dealer/core/local/init_local_storage.dart';

String base_url = 'https://dealer.luitfanclub.com/api/';

String otpToMobileNew = 'otpToMobileNew';


String loadPaymentModes = 'loadPaymentModes';

String get_all_cities = 'getAllCities';
 
String product_categories = 'product_categories';

String get_brands = 'get_brands';

String load_products = 'load_products';

String submitReferral = 'submitReferral';

String submit_user_referral = 'submitUserReferral';

String user_tree = 'userTree';

String rewardList = 'rewardList';

String withdrawList = 'withdrawList';

String leadList = 'leadList';

String getRemarksByLeadId = 'getRemarksByLeadId';

String add_remark_to_lead = 'addRemarkToLead';

String salesOrDealer() {
  bool isSales = LocalStorage.sharedPreferences.getBool('isSales') ?? false;
  if (isSales) {
    return 'sales';
  } else {
    return 'dealer';
  }
}
