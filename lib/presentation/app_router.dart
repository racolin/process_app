import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:process_app/business_logic/cubits/history_point_cubit.dart';
import 'package:process_app/presentation/screens/address/address_screen.dart';
import 'package:process_app/presentation/screens/cart_template_screen.dart';
import 'package:process_app/presentation/screens/history_point_screen.dart';

import '../business_logic/cubits/address_cubit.dart';
import '../data/repositories/api/auth_api_repository.dart';
import '../data/repositories/api/cart_api_repository.dart';
import '../data/repositories/api/member_api_repository.dart';
import '../data/repositories/api/news_api_repository.dart';
import '../data/repositories/api/notify_api_repository.dart';
import '../data/repositories/api/promotion_api_repository.dart';
import '../data/repositories/api/setting_api_repository.dart';
import '../data/repositories/api/store_api_repository.dart';
import '../data/repositories/api/voucher_api_repository.dart';
import 'pages/reward_screen.dart';
import 'screens/cart/cart_detail_screen.dart';
import 'screens/cart/carts_screen.dart';
import 'screens/setting_screen.dart';
import 'screens/splash_screen.dart';
import '../../business_logic/cubits/product_scroll_cubit.dart';
import '../business_logic/cubits/auth_cubit.dart';
import '../business_logic/cubits/cart_detail_cubit.dart';
import '../business_logic/cubits/notify_cubit.dart';
import '../business_logic/cubits/profile_cubit.dart';
import '../business_logic/cubits/carts_cubit.dart';
import '../business_logic/cubits/store_cubit.dart';
import '../business_logic/repositories/auth_repository.dart';
import '../business_logic/repositories/cart_repository.dart';
import '../business_logic/repositories/account_repository.dart';
import '../business_logic/repositories/member_repository.dart';
import '../business_logic/repositories/news_repository.dart';
import '../business_logic/repositories/notify_repository.dart';
import '../business_logic/repositories/promotion_repository.dart';
import '../business_logic/repositories/setting_repository.dart';
import '../business_logic/repositories/store_repository.dart';
import '../business_logic/repositories/voucher_repository.dart';
import '../data/repositories/mock/auth_mock_repository.dart';
import '../data/repositories/mock/cart_template_mock_repository.dart';
import '../data/repositories/mock/member_mock_repository.dart';
import '../data/repositories/mock/news_mock_repository.dart';
import '../data/repositories/mock/notify_mock_repository.dart';
import '../data/repositories/mock/product_mock_repository.dart';
import '../data/repositories/mock/promotion_mock_repository.dart';
import '../data/repositories/mock/setting_mock_repository.dart';
import '../data/repositories/mock/store_mock_repository.dart';
import '../data/repositories/mock/voucher_mock_repository.dart';
import '../data/repositories/mock/cart_mock_repository.dart';
import '../business_logic/cubits/app_bar_cubit.dart';
import '../business_logic/cubits/card_cubit.dart';
import '../business_logic/cubits/home_cubit.dart';
import '../business_logic/cubits/news_cubit.dart';
import '../business_logic/cubits/promotion_cubit.dart';
import '../business_logic/cubits/voucher_cubit.dart';
import '../data/repositories/storage/account_storage_repository.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/address/address_search_screen.dart';
import 'screens/notify_screen.dart';
import 'screens/profile_screen.dart';

class AppRouter {
  static const String home = '/home';
  static const String splash = '/splash';
  static const String auth = '/auth';
  static const String setting = '/setting';
  static const String reward = '/reward';
  static const String address = '/address';
  static const String addressSearch = '/select-address';
  static const String storeSearch = '/select-store';
  static const String carts = '/carts';
  static const String cartTemplate = '/cart-template';
  static const String profile = '/profile';
  static const String notify = '/notify';
  static const String historyPoint = '/history_point';

  static Route<dynamic>? onGenerateAppRoute(
    RouteSettings settings,
    bool hasInternet,
  ) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        );
      case home:
        return MaterialPageRoute(
          builder: (context) {
            // Sửa provider khi có hoặc ko có mạng ở ngay đây
            // Ví dụ: RepositoryProvider<MemberRepository>(
            //           create: (context) => internet ? MemberMockRepository() : MemberLocalRepository(),
            //        )
            return MultiRepositoryProvider(
              providers: [
                RepositoryProvider<CartRepository>(
                  create: (context) => CartApiRepository(),
                  // create: (context) => CartMockRepository(),
                ),
                RepositoryProvider<AccountRepository>(
                  create: (context) => AccountStorageRepository(),
                ),
                // RepositoryProvider<MemberRepository>(
                //   create: (context) => MemberMockRepository(),
                // ),
                RepositoryProvider<NewsRepository>(
                  create: (context) => NewsApiRepository(),
                ),
                // RepositoryProvider<NewsRepository>(
                //   create: (context) => NewsMockRepository(),
                // ),
                RepositoryProvider<PromotionRepository>(
                  create: (context) => PromotionApiRepository(),
                ),
                // RepositoryProvider<PromotionRepository>(
                //   create: (context) => PromotionMockRepository(),
                // ),
                // RepositoryProvider<SettingRepository>(
                //   create: (context) => SettingMockRepository(),
                // ),
                RepositoryProvider<SettingRepository>(
                  create: (context) => SettingApiRepository(),
                ),
                RepositoryProvider<StoreRepository>(
                  create: (context) => StoreApiRepository(),
                ),
                // RepositoryProvider<StoreRepository>(
                //   create: (context) => StoreMockRepository(),
                // ),
                RepositoryProvider<VoucherRepository>(
                  create: (context) => VoucherApiRepository(),
                ),
                // RepositoryProvider<VoucherRepository>(
                //   create: (context) => VoucherMockRepository(),
                // ),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<HomeCubit>(
                    create: (context) => HomeCubit(),
                  ),
                  BlocProvider<CardCubit>(
                    create: (context) => CardCubit(
                      repository: RepositoryProvider.of<MemberRepository>(
                        context,
                      ),
                    ),
                  ),
                  BlocProvider<ProductScrollCubit>(
                    create: (context) => ProductScrollCubit(),
                  ),
                  BlocProvider<VoucherCubit>(
                    create: (context) => VoucherCubit(
                      repository: RepositoryProvider.of<VoucherRepository>(
                        context,
                      ),
                    ),
                  ),
                  BlocProvider<PromotionCubit>(
                    create: (context) => PromotionCubit(
                      repository: RepositoryProvider.of<PromotionRepository>(
                        context,
                      ),
                    ),
                  ),
                  BlocProvider<StoreCubit>(
                    create: (context) => StoreCubit(
                      repository: RepositoryProvider.of<StoreRepository>(
                        context,
                      ),
                    ),
                  ),
                  BlocProvider<NewsCubit>(
                    create: (context) => NewsCubit(
                      repository: RepositoryProvider.of<NewsRepository>(
                        context,
                      ),
                    ),
                  ),
                ],
                child: const HomeScreen(),
              ),
            );
          },
        );
      case auth:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<AuthRepository>(
              create: (context) => AuthApiRepository(),
              child: BlocProvider<AuthCubit>(
                create: (context) => AuthCubit(
                  repository: RepositoryProvider.of<AuthRepository>(
                    context,
                  ),
                ),
                child: const LoginScreen(),
              ),
            );
          },
        );
      // return MaterialPageRoute(
      //   builder: (context) {
      //     return RepositoryProvider<AuthRepository>(
      //       create: (context) => AuthMockRepository(),
      //       child: BlocProvider<AuthCubit>(
      //         create: (context) => AuthCubit(
      //           repository: RepositoryProvider.of<AuthRepository>(
      //             context,
      //           ),
      //         ),
      //         child: const LoginScreen(),
      //       ),
      //     );
      //   },
      // );
      case reward:
        return MaterialPageRoute(
          builder: (context) {
            return const RewardScreen();
          },
        );
      case cartTemplate:
        return MaterialPageRoute(
          builder: (context) {
            return const CartTemplateScreen();
          },
        );
      case address:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<SettingRepository>(
              create: (context) => SettingApiRepository(),
              child: BlocProvider<AddressCubit>(
                create: (context) => AddressCubit(
                  repository: RepositoryProvider.of<SettingRepository>(context),
                ),
                child: const AddressScreen(),
              ),
            );
          },
        );
      case addressSearch:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<SettingRepository>(
              create: (context) => SettingApiRepository(),
              child: BlocProvider<AddressCubit>(
                create: (context) => AddressCubit(
                  repository: RepositoryProvider.of<SettingRepository>(context),
                ),
                child: const AddressSearchScreen(),
              ),
            );
          },
        );
      case carts:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<CartRepository>(
              create: (context) => CartApiRepository(),
              child: BlocProvider<CartsCubit>(
                create: (context) => CartsCubit(
                  repository: RepositoryProvider.of<CartRepository>(
                    context,
                  ),
                ),
                child: const CartsScreen(),
              ),
            );
          },
        );
      case profile:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<SettingRepository>(
              create: (context) => SettingApiRepository(),
              child: BlocProvider<ProfileCubit>(
                create: (context) => ProfileCubit(
                  repository: RepositoryProvider.of<SettingRepository>(context),
                ),
                child: const ProfileScreen(),
              ),
            );
          },
        );
      case setting:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<SettingRepository>(
              create: (context) => SettingApiRepository(),
              child: BlocProvider<ProfileCubit>(
                create: (context) => ProfileCubit(
                  repository: RepositoryProvider.of<SettingRepository>(context),
                ),
                child: const SettingScreen(),
              ),
            );
          },
        );
      case notify:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<NotifyRepository>(
              create: (context) => NotifyApiRepository(),
              child: BlocProvider<NotifyCubit>(
                create: (context) => NotifyCubit(
                  repository: RepositoryProvider.of<NotifyRepository>(
                    context,
                  ),
                ),
                // create: (context) => NotifyMockRepository(),
                // child: BlocProvider<NotifyCubit>(
                //   create: (context) => NotifyCubit(
                //     repository: RepositoryProvider.of<NotifyRepository>(
                //       context,
                //     ),
                //   ),
                child: const NotifyScreen(),
              ),
            );
          },
        );
      case historyPoint:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<HistoryPointCubit>(
              create: (context) => HistoryPointCubit(
                repository: RepositoryProvider.of<MemberRepository>(
                  context,
                ),
              ),
              child: const HistoryPointScreen(),
            );
          },
        );
    }
    return null;
  }
}
