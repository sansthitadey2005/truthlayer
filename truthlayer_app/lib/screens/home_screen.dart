import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/web3_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _inputController = TextEditingController();
  final Web3Service _web3 = Web3Service();

  bool loading = false;
  String verdict = '';
  List<String> explanations = [];

  // 🔍 Verdict logic
  String getVerdict(List<dynamic> flags) {
    if (flags.length >= 3) return "🚨 Scam Likely";
    if (flags.length == 2) return "⚠️ High Risk";
    if (flags.length == 1) return "⚠️ Caution";
    return "✅ Likely Safe";
  }

  // 📖 Explanation logic
  List<String> explainFlags(List<dynamic> flags) {
    return flags.map((flag) {
      switch (flag) {
        case "URGENCY_PRESSURE":
          return "Creates urgency to force quick action";
        case "REWARD_BAIT":
          return "Promises fake rewards to lure victims";
        case "PAYMENT_MANIPULATION":
          return "Attempts deceptive payment requests";
        default:
          return "Unknown risk pattern detected";
      }
    }).toList();
  }

  // 📤 Submit Evidence
  Future<void> submitEvidence() async {
    if (_inputController.text.isEmpty) return;

    setState(() {
      loading = true;
      verdict = '';
      explanations = [];
    });

    // Blockchain proof (demo)
    await _web3.init();
    await _web3.setData(1);

    // Simple risk detection (MVP logic)
    final isSuspicious = _inputController.text.contains('free') ||
        _inputController.text.contains('pay');

    await FirebaseFirestore.instance.collection('autopsies').add({
      'createdAt': FieldValue.serverTimestamp(),
      'input': _inputController.text,
      'findings': {
        'riskFlags': isSuspicious
            ? [
                'URGENCY_PRESSURE',
                'REWARD_BAIT',
                'PAYMENT_MANIPULATION',
              ]
            : []
      }
    });

    setState(() {
      loading = false;
    });
  }

  // 📥 Check Verification
  Future<void> checkVerification() async {
    setState(() {
      loading = true;
    });

    final snapshot = await FirebaseFirestore.instance
        .collection('autopsies')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      setState(() {
        loading = false;
        verdict = 'No verification data found';
      });
      return;
    }

    final data = snapshot.docs.first.data();
    final flags = data['findings']['riskFlags'] as List<dynamic>;

    setState(() {
      loading = false;
      verdict = getVerdict(flags);
      explanations = explainFlags(flags);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TruthLayer')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verify Digital Evidence',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Paste suspicious URL or text',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: loading ? null : submitEvidence,
              child: const Text('Submit Evidence'),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: loading ? null : checkVerification,
              child: const Text('Check Verification Status'),
            ),

            const SizedBox(height: 20),

            if (loading) const CircularProgressIndicator(),

            if (verdict.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text(
                verdict,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],

            for (final explanation in explanations)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text("• $explanation"),
              ),
          ],
        ),
      ),
    );
  }
}
