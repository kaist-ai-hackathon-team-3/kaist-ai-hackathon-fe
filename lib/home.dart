import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'home_category.dart';
import 'policy_detail.dart';
import 'common_layout.dart';

class HomePage extends StatefulWidget {
  final List<int> categories;

  const HomePage({super.key, required this.categories});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> _policies;

  @override
  void initState() {
    super.initState();
    _policies = fetchPolicies(widget.categories);
  }

  Future<List<dynamic>> fetchPolicies(List<int> categories) async {
    final List<dynamic> policies = [];

    for (int category in categories) {
      try {
        final response = await http.get(
          Uri.parse('http://223.130.141.98:3000/policy/category/$category'),
          headers: {
            'Accept': 'application/json',
          },
        ).timeout(const Duration(seconds: 10)); // 10초 타임아웃 설정
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          policies.addAll(data);
          print('Data for category $category: $data');
        } else {
          print('Failed to load policies for category $category');
          throw Exception('Failed to load policies');
        }
      } catch (e) {
        print('Error fetching policies for category $category: $e');
        throw Exception('Error fetching policies for category $category: $e');
      }
    }

    print('Total policies: $policies');
    return policies;
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      body: HomePageContent(policies: _policies),
      selectedIndex: 0,
    );
  }
}

class HomePageContent extends StatelessWidget {
  final Future<List<dynamic>> policies;

  const HomePageContent({super.key, required this.policies});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeCategoryScreen()),
                );
              },
              child: Center(
                child: Container(
                  width: 345,
                  height: 45,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF0F2F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '조건 검색',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF686A8A),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        letterSpacing: 0.34,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '새로 나온 정책',
              style: TextStyle(
                color: Color(0xFF303030),
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                height: 1.5,
                letterSpacing: 0.56,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 218.43,
              child: FutureBuilder<List<dynamic>>(
                future: policies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    print('No policies found');
                    return const Center(child: Text('No policies found'));
                  } else {
                    final displayData = snapshot.data!.take(10).toList();
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: displayData
                          .map((policy) => policyCard(context, policy))
                          .toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget policyCard(BuildContext context, dynamic policy) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PolicyDetailScreen(policyId: policy['serviceID']),
          ),
        );
      },
      child: Container(
        width: 147,
        margin: const EdgeInsets.only(right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 147,
              height: 108,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
              ),
              child: Image.network(
                'https://via.placeholder.com/147x108', // 임시 이미지 URL
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('images/home_category_농축어업.png');
                },
              ),
            ),
            const SizedBox(height: 5),
            Flexible(
              child: Text(
                policy['serviceName'],
                style: const TextStyle(
                  color: Color(0xFF303030),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  letterSpacing: 0.39,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 3),
            Flexible(
              child: Text(
                policy['applicationDeadline'],
                style: const TextStyle(
                  color: Color(0xFF686A8A),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  letterSpacing: 0.34,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 3),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(11),
              ),
              child: Text(
                policy['responsibleAgencyName'],
                style: const TextStyle(
                  color: Color(0xFF686A8A),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  letterSpacing: 0.34,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
