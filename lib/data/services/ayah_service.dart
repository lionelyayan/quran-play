import '../../core/network/api_response.dart';
import '../models/ayah_model.dart';
import 'base/base_service.dart';

class AyahService extends BaseService {
  Future<ApiResponse<List<AyahModel>>> getAyahList(int surahNumber) {
    return get<List<AyahModel>>(
      '/surah/$surahNumber/editions/ar.alafasy,en.asad',
      parser: (data) {
        final editions = data['data'] as List;
        final audioAyahs = editions[0]['ayahs'] as List<dynamic>;
        final translationAyahs = editions[1]['ayahs'] as List<dynamic>;

        return List.generate(audioAyahs.length, (index) {
          final arabic = audioAyahs[index] as Map<String, dynamic>;
          final translation = translationAyahs[index] as Map<String, dynamic>;

          final numberInSurah = arabic['numberInSurah'] ?? 0;
          String textArabic = arabic['text'] ?? '';

          if (numberInSurah == 1) {
            textArabic = textArabic.replaceAll(
              'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ ',
              '',
            );
          }

          return AyahModel(
            numberInSurah: numberInSurah,
            textArabic: textArabic,
            translation: translation['text'] ?? '',
            audio: arabic['audio'] ?? '',
          );
        });
      },
    );
  }
}
