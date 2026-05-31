import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:quran_play/core/network/dio_client.dart';
import 'package:quran_play/data/models/ayah_model.dart';
import 'package:quran_play/data/models/surah_model.dart';

const String _testBaseUrl = 'https://api.alquran.cloud/v1';

void main() {
  late DioClient client;

  setUp(() {
    client = DioClient(baseUrl: _testBaseUrl);

    client.dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
        error: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ),
    );
  });

  // ─────────────────────────────────────────────────────────
  group('GET /surah ─', () {
    test('GET /surah → ', () async {
      final result = await client.get<List<SurahModel>>(
        '/surah',
        parser: (data) => (data['data'] as List)
            .map((e) => SurahModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

      if (result.isSuccess) {
        debugPrint('\n✅ Success! Total: ${result.data!.length} data');
        debugPrint('   First data: ${result.data!.first}');
      } else {
        debugPrint('\n❌ Failed: ${result.status} (${result.code})');
      }

      expect(
        result.isSuccess,
        true,
        reason: 'Request failed: ${result.status}',
      );
      expect(result.data, isNotNull);
      expect(result.data!.isNotEmpty, true);
    });

    test('GET /ayah → ', () async {
      final result = await client.get<List<AyahModel>>(
        '/surah/110/editions/ar.alafasy,en.asad',
        parser: (data) {
          final editions = data['data'] as List;
          final audioAyahs = editions[0]['ayahs'] as List<dynamic>;
          final translationAyahs = editions[1]['ayahs'] as List<dynamic>;

          return List.generate(audioAyahs.length, (index) {
            final arabic = audioAyahs[index] as Map<String, dynamic>;
            final translation = translationAyahs[index] as Map<String, dynamic>;
            return AyahModel(
              numberInSurah: arabic['numberInSurah'] as int,
              textArabic: arabic['text'] as String,
              translation: translation['text'] as String,
              audio: arabic['audio'] as String,
            );
          });
        },
      );

      if (result.isSuccess) {
        debugPrint('\n✅ Success! Total: ${result.data!.length} data');
        debugPrint('   First data: ${result.data!.first}');
      } else {
        debugPrint('\n❌ Failed: ${result.status} (${result.code})');
      }

      expect(
        result.isSuccess,
        true,
        reason: 'Request failed: ${result.status}',
      );
      expect(result.data, isNotNull);
      expect(result.data!.isNotEmpty, true);
    });
  });
}
