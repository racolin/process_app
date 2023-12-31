import 'package:process_app/data/models/response_model.dart';
import 'package:process_app/data/models/store_detail_model.dart';

import '../../../data/models/store_model.dart';
import '../../../business_logic/repositories/store_repository.dart';

class StoreStorageRepository extends StoreRepository {

  @override
  Future<ResponseModel<bool>> changeFavorite({required String id}) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<StoreDetailModel>> getDetail({required String id}) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<StoreModel>>> gets() async {
    throw UnimplementedError();
  }
}
