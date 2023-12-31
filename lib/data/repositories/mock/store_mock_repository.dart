import 'package:process_app/data/models/response_model.dart';
import 'package:process_app/data/models/store_detail_model.dart';

import '../../models/store_model.dart';
import '../../../business_logic/repositories/store_repository.dart';
import '../../../exception/app_message.dart';

class StoreMockRepository extends StoreRepository {
  var _list = List.generate(
    10,
    (index) => StoreModel(
      id: 'STORE$index',
      address: 'Võ Thị Sáu, Quận 3, Thành phố Hồ Chí Minh',
      name: '175A Lý Chính Thắng',
      image:
          'https://file.hstatic.net/1000075078/file/grandview5_35ccc48004574095b53e1de3b86a9eb5_master.jpg',
      distance: 100 * index * index,
      isFavorite: false,
    ),
  );

  @override
  Future<ResponseModel<bool>> changeFavorite({required String id}) async {
    return ResponseModel<bool>(
      type: ResponseModelType.success,
      data: true,
    );
    return ResponseModel<bool>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi thay đổi cửa hàng yêu thích!',
      ),
    );
  }

  @override
  Future<ResponseModel<StoreDetailModel>> getDetail(
      {required String id}) async {
    return ResponseModel<StoreDetailModel>(
      type: ResponseModelType.success,
      data: StoreDetailModel(
        id: id,
        openTime: '07:00-21:00',
        phone: '0868754872',
        images: [
          'https://file.hstatic.net/1000075078/file/sig-04_45f046ffbfa94c069b4d9697e8444baa_master.png',
          'https://file.hstatic.net/1000075078/file/sig-01_2c5b08d6b9294c82ac64901e12ae6106_master.png',
          'https://file.hstatic.net/1000075078/file/grandview3_badde8d8296d4474b7ecb2ae67fb2dd8_master.jpg',
          'https://file.hstatic.net/1000075078/file/grandview5_35ccc48004574095b53e1de3b86a9eb5_master.jpg',
        ],
        unavailableProducts: [
          'PRODUCT-1',
          'PRODUCT-12',
          'PRODUCT-4',
        ],
        unavailableOptions: [
          'OPTION-1',
        ],
        unavailableCategories: [],
      ),
    );
    return ResponseModel<StoreDetailModel>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi lấy danh sách cửa hàng',
      ),
    );
  }

  @override
  Future<ResponseModel<List<StoreModel>>> gets() async {
    return ResponseModel<List<StoreModel>>(
      type: ResponseModelType.success,
      data: _list,
    );
    return ResponseModel<List<StoreModel>>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi lấy danh sách cửa hàng',
      ),
    );
  }
}
