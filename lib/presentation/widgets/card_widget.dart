import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:process_app/business_logic/cubits/cart_cubit.dart';
import 'package:process_app/supports/extension.dart';
import '../../business_logic/cubits/card_cubit.dart';
import '../../business_logic/states/card_state.dart';
import '../../data/models/card_model.dart';
import '../../presentation/res/dimen/dimens.dart';

import '../res/strings/values.dart';
import 'app_image_widget.dart';

class CardWidget extends StatelessWidget {
  final bool isDetail;
  final double height = 200;
  final double barHeight = 76;
  final double barCoverHeight = 96;
  final double barWidth = 300;
  final double cardHeight = 160;
  final double top = 172;

  const CardWidget({
    Key? key,
    this.isDetail = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardCubit, CardState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case CardInitial:
            return Container();
          case CardLoading:
            return Container();
          case CardLoaded:
            state as CardLoaded;
            context.read<CartCubit>().setFee(state.card.fee);
            return Stack(
              children: [
                if (isDetail) _getDetail(state.card),
                _getCard(state.card),
              ],
            );
        }
        return const SizedBox();
      },
    );
  }

  Widget _getCard(CardModel card) {
    return SizedBox(
      height: height,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(spaceXS),
        ),
        color: Colors.orange,
        child: AppImageWidget(
          image: card.backgroundImage,
          errorWidget: (ctx, url, error) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(spaceXS),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(assetDefaultImage),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getInfo(card),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(right: spaceMD),
                        padding: const EdgeInsets.symmetric(
                          vertical: spaceXS,
                          horizontal: spaceSM,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(spaceXS),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.keyboard_double_arrow_down_outlined,
                              color: Colors.white.withAlpha(200),
                              size: fontLG,
                            ),
                            const SizedBox(
                              width: spaceXXS,
                            ),
                            const Text(
                              txtAccumulate,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: barCoverHeight,
                    padding: const EdgeInsets.all(spaceMD),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(spaceXS),
                    ),
                    margin: const EdgeInsets.all(spaceMD),
                    // child: SvgPicture.string(
                    //   card.id.qrCode(barWidth, barHeight),
                    // ),
                  ),
                ],
              ),
            );
          },
          imageBuilder: (ctx, provider) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(spaceXS),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: provider,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getInfo(card),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(right: spaceMD),
                        padding: const EdgeInsets.symmetric(
                          vertical: spaceXS,
                          horizontal: spaceSM,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(spaceXS),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.keyboard_double_arrow_down_outlined,
                              color: Colors.white.withAlpha(200),
                              size: fontLG,
                            ),
                            const SizedBox(
                              width: spaceXXS,
                            ),
                            const Text(
                              txtAccumulate,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: barCoverHeight,
                    padding: const EdgeInsets.all(spaceMD),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(spaceXS),
                    ),
                    margin: const EdgeInsets.all(spaceMD),
                    child: SvgPicture.string(
                      card.code.barcode(barWidth, barHeight),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getDetail(CardModel card) {
    return Card(
      margin: EdgeInsets.only(top: top),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          spaceXS,
        ),
      ),
      color: Colors.white,
      child: SizedBox(
        height: cardHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: spaceMD),
              child: SliderRank(
                preRankName: card.currentRankName,
                nextRankName: card.nextRankName,
                nextPoint: card.nextRankPoint - card.currentRankPoint,
                progress: card.point - card.currentRankPoint,
                color: Color(card.color),
              ),
            ),
            const SizedBox(height: 2),
            ...card.description
                .split('|')
                .map(
                  (e) => Text(
                    e,
                    style: const TextStyle(
                      fontSize: fontSM,
                      height: 1.5,
                    ),
                  ),
                )
                .toList(),
            const SizedBox(height: spaceMD),
          ],
        ),
      ),
    );
  }

  Widget _getInfo(CardModel? card) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(spaceXS),
        color: Colors.black54.withOpacity(opaMD),
      ),
      padding: const EdgeInsets.all(spaceXS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            card != null ? card.name.toUpperCase() : '',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: fontLG,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: spaceXS,
          ),
          Text(
            '${card != null ? card.currentPoint : '0'} $txtPointName '
            '- ${card != null ? card.currentRankName : ''}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: fontMD,
            ),
          )
        ],
      ),
    );
  }
}

class SliderRank extends StatelessWidget {
  final String preRankName;
  final String nextRankName;
  final int nextPoint;
  final int progress;
  final Color color;

  const SliderRank({
    Key? key,
    required this.preRankName,
    required this.nextRankName,
    required this.nextPoint,
    required this.progress,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.85;
    var widthSlider = width > spaceLG ? width - spaceLG : 0;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(preRankName), Text(nextRankName)],
        ),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: width,
              height: spaceXS,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withAlpha(100), color],
                ),
                borderRadius: BorderRadius.circular(spaceXS / 2),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: widthSlider * (progress.toDouble() / nextPoint),
              ),
              height: spaceLG,
              width: spaceLG,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(spaceSM),
                border: Border.all(width: 2, color: color),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.eco,
                color: color,
                size: fontLG,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: width - spaceXS),
              child: Container(
                height: spaceXXS,
                width: spaceXXS,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(spaceXXS / 2),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
