import 'package:flutter/material.dart';
import 'services/web3_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final web3 = Web3Service();
  await web3.init();

  final oldValue = await web3.getData();
  print("Old value from blockchain: $oldValue");

  final txHash = await web3.setData(10);
  print("Transaction hash: $txHash");
}