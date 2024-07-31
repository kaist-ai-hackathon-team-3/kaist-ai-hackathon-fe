import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'common_layout.dart'; // CommonLayout import

class PolicyDetailScreen extends StatefulWidget {
  final String policyId;

  const PolicyDetailScreen({super.key, required this.policyId});

  @override
  _PolicyDetailScreenState createState() => _PolicyDetailScreenState();
}

class _PolicyDetailScreenState extends State<PolicyDetailScreen> {
  late Future<Map<String, dynamic>> _policy;

  @override
  void initState() {
    super.initState();
    _policy = fetchPolicy(widget.policyId);
  }

  Future<Map<String, dynamic>> fetchPolicy(String policyId) async {
    try {
      final response = await http.get(
        Uri.parse('http://223.130.141.98:3000/policy/$policyId'),
        headers: {
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10)); // 10초 타임아웃 설정
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load policy');
      }
    } catch (e) {
      print('Error fetching policy: $e');
      throw Exception('Error fetching policy: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      selectedIndex: -1, // 정책 상세 화면에서는 하단 내비게이션 바의 인덱스를 선택하지 않음
      body: FutureBuilder<Map<String, dynamic>>(
        future: _policy,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          } else {
            final policy = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F4E9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          "https://via.placeholder.com/44x45"),
                                      fit: BoxFit.fill,
                                    ),
                                    border: Border.all(
                                        width: 0.5,
                                        color: const Color(0xFF949497)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  // 추가: Row의 오버플로우 방지를 위해 Expanded로 감싸기
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        policy['serviceName'] ?? 'N/A',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                        ),
                                        maxLines: 2, // 최대 두 줄까지 표시
                                        overflow: TextOverflow
                                            .ellipsis, // 텍스트가 길 경우 말줄임표 표시
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          _buildTag(policy['supportType'] ?? 'N/A'),
                                          const SizedBox(width: 10),
                                          _buildTag('해시태그'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(
                                  child: Text(
                                    'AI 3줄 요약',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildSectionTitle('지원 대상'),
                    const SizedBox(height: 10),
                    Text(policy['supportTarget'] ?? 'N/A',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 20),
                    _buildSectionTitle('지원 기간'),
                    const SizedBox(height: 10),
                    Text(policy['applicationDeadline'] ?? 'N/A',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 20),
                    _buildSectionTitle('지원 내용'),
                    const SizedBox(height: 10),
                    Text(policy['supportDetails'] ?? 'N/A',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 20),
                    _buildSectionTitle('관련 정보'),
                    const SizedBox(height: 10),
                    Text(policy['selectionCriteria'] ?? 'N/A',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 20),
                    _buildSectionTitle('신청 방법'),
                    const SizedBox(height: 10),
                    Text(policy['applicationMethod'] ?? 'N/A',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F6),
        border: Border.all(width: 0.5, color: const Color(0xFF949497)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20, // Increased font size from 18 to 20
        fontFamily: 'Poppins',
        fontWeight:
            FontWeight.bold, // Changed from FontWeight.w400 to FontWeight.bold
      ),
    );
  }
}
