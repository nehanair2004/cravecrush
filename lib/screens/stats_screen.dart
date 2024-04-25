import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int totalCigarettesAvoided = 0;
  int longestNonSmokingStreak = 0;
  int smokingDays = 0;
  int nonSmokingDays = 0;
  double totalMoneySaved = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').get();

      int totalCigarettes = 0;
      double pricePerCigarette = 0.0;
      List<DateTime> smokingDates = [];

      userSnapshot.docs.forEach((userDoc) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        print('User Data: $userData');

        int numCigarettes = userData['num_cigarettes'] ?? 0;
        totalCigarettes += numCigarettes;
        pricePerCigarette = (userData['price_per_cigarette'] ?? 0.0).toDouble();

        List<dynamic> entries = userData['entries'] ?? [];
        entries.forEach((entry) {
          String status = entry['status'];
          if (status == 'No') {
            nonSmokingDays++;
          } else {
            smokingDays++;
            smokingDates.add(DateTime.parse(entry['date']));
          }
        });
      });

      print('Total Cigarettes: $totalCigarettes');
      print('Price Per Cigarette: $pricePerCigarette');
      print('Smoking Dates: $smokingDates');

      // Calculate statistics...

      setState(() {});
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStatCard('Total Cigarettes Avoided', totalCigarettesAvoided.toString()),
            _buildStatCard('Longest Non-Smoking Streak', '$longestNonSmokingStreak days'),
            _buildStatCard('Smoking Days', smokingDays.toString()),
            _buildStatCard('Non-Smoking Days', nonSmokingDays.toString()),
            _buildStatCard('Total Money Saved', '\$$totalMoneySaved'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

