import 'package:goal_setting/data_classes/global_data_class.dart';

import 'data_classes/sub classes/user_profile_data.dart';
import 'dummy_user_page.dart';

GlobalDataInstance generateRandomGlobalData({required int numberOfDummyGoals, required UserData userDataOBJ}) {
  return RandomDataGenerator.generateRandomGlobalData(numberOfDummyGoals,6, userDataOBJ);
}
