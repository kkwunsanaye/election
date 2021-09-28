import 'package:flutter/foundation.dart';
import 'package:kamelection/model/amount_model.dart';

class AmountProvider with ChangeNotifier{
  
// Data 
List<AmountModel> amountModels = [];

// Get Data 
List<AmountModel>getAmountProivder() {
  return amountModels;
}

//Clear Provider
void clearAmountProvider(){
  amountModels.clear();
  notifyListeners();
}


// Add Data
void addAmountProvider(AmountModel amountModel){
  amountModels.clear();
  amountModels.add(amountModel);
  notifyListeners();
}
}
