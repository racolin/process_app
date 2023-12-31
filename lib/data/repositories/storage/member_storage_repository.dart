import 'package:process_app/data/models/response_model.dart';

import '../../../data/models/app_bar_model.dart';
import '../../../data/models/card_model.dart';
import '../../../data/models/history_point_model.dart';
import '../../../business_logic/repositories/member_repository.dart';

class MemberStorageRepository extends MemberRepository {
  @override
  Future<ResponseModel<AppBarModel>> getAppBar() async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<CardModel>> getCard() async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<MapEntry<int, List<HistoryPointModel>>>> getHistoryPoint({
    int? page,
    int? limit,
  }) async {
    throw UnimplementedError();
  }
}
