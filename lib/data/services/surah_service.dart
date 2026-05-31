import 'package:quran_play/core/network/api_response.dart';
import 'package:quran_play/data/models/surah_model.dart';
import 'package:quran_play/data/services/base/base_service.dart';

class SurahService extends BaseService {
  Future<ApiResponse<List<SurahModel>>> getSurahList() async {
    return await get<List<SurahModel>>(
      '/surah',
      parser: (data) {
        final List<dynamic> list = (data as Map<String, dynamic>)['data'] as List;
        return list.map((item) => SurahModel.fromJson(item)).toList();
      },
    );
  }
}