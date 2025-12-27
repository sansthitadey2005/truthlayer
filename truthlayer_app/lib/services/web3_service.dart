import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class Web3Service {
  late Web3Client _client;
  late DeployedContract _contract;
  late Credentials _credentials;

  final String rpcUrl =
      "https://sepolia.infura.io/v3/e3df9147406446178aed81bb9d27674a";

  final String privateKey =
      "0x4c71cbe1124c8084ab8df549eae1c4a0b57ff90aacf80fb1df5c4eff64a01629";

  final String contractAddress =
      "0x8701D77CdF85c4F0D4067080DA3821019D61201F";

  final String abi = '''
[
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_data",
        "type": "uint256"
      }
    ],
    "name": "set",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "data",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "get",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  }
]
''';

  /// MUST be called once before using any function
  Future<void> init() async {
    _client = Web3Client(rpcUrl, Client());
    _credentials = EthPrivateKey.fromHex(privateKey);

    _contract = DeployedContract(
      ContractAbi.fromJson(abi, "TruthLayer"),
      EthereumAddress.fromHex(contractAddress),
    );
  }

  /// READ function - get()
  Future<BigInt> getData() async {
    final function = _contract.function("get");
    final result = await _client.call(
      contract: _contract,
      function: function,
      params: [],
    );
    return result[0] as BigInt;
  }

  /// READ function - data()
  Future<BigInt> readDataVariable() async {
    final function = _contract.function("data");
    final result = await _client.call(
      contract: _contract,
      function: function,
      params: [],
    );
    return result[0] as BigInt;
  }

  /// WRITE function - set(uint256)
  Future<String> setData(int value) async {
    final function = _contract.function("set");

    final txHash = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: function,
        parameters: [BigInt.from(value)],
      ),
      chainId: 11155111, // Sepolia
    );

    return txHash;
  }
}