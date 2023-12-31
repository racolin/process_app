import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:process_app/business_logic/cubits/cart_cubit.dart';
import 'package:process_app/data/models/store_detail_model.dart';
import 'package:process_app/presentation/res/strings/values.dart';
import 'package:process_app/presentation/widgets/app_image_widget.dart';

import '../../data/models/store_model.dart';
import '../widgets/slide/slide_images_widget.dart';

class StoreBottomSheet extends StatelessWidget {
  final StoreModel store;
  final StoreDetailModel detail;

  const StoreBottomSheet({
    Key? key,
    required this.store,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 1,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
          margin: const EdgeInsets.only(top: 56),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SlideImagesWidget(
                            height: 300,
                            separator: 2,
                            itemWidth: 250,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            images: detail.images,
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.grey,
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                      _getInformation(),
                      _getLinksInformation(),
                      _getMap(),
                      _getButton(context),
                      const SizedBox(
                        height: 36,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getInformation() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            txtAppName.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            store.name,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'Giờ mở cửa: ${detail.openTime}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getLinksInformation() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.withAlpha(30),
                ),
                child: const Icon(
                  Icons.send_rounded,
                  size: 16,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  store.address,
                  style: const TextStyle(height: 1.5),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 48, top: 8, bottom: 8),
            child: const Divider(),
          ),
          Row(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.withAlpha(30),
                ),
                child: const Icon(
                  Icons.favorite,
                  size: 16,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Text('Thêm vào danh sách yêu thích'),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 48, top: 8, bottom: 8),
            child: const Divider(),
          ),
          Row(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.withAlpha(30),
                ),
                child: const Icon(
                  Icons.call,
                  size: 16,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Text('Liên hệ: ${detail.phone}'),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 48, top: 8, bottom: 8),
            child: const Divider(),
          ),
          Row(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.withAlpha(30),
                ),
                child: const Icon(
                  Icons.reply_rounded,
                  size: 16,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Text('Chia sẻ với bạn bè'),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 48, top: 8, bottom: 8),
            child: const Divider(),
          ),
        ],
      ),
    );
  }

  Widget _getMap() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: const AppImageWidget(
          image:
              'https://www.google.com/maps/d/u/0/thumbnail?mid=16ICMtDmGmWt2B-p5_AJWkw-9-OY&hl=en',
          height: 180,
        ),
      ),
    );
  }

  Widget _getButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      width: double.maxFinite,
      child: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.all(12),
            ),
            backgroundColor: MaterialStateProperty.all(
              Colors.orange,
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          onPressed: () {
            context.read<CartCubit>().setStore(store, detail);
            context.read<CartCubit>().setCategory(1);
          },
          child: Column(
            children: const [
              Text(
                'Đặt sản phẩm',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              Text(
                'Tự đến lấy tại cửa hàng này',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          )),
    );
  }
}
