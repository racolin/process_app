import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:process_app/data/models/product_category_model.dart';
import 'package:process_app/data/models/product_model.dart';
import 'package:process_app/data/models/response_model.dart';

import '../../business_logic/repositories/product_repository.dart';
import '../../business_logic/states/product_state.dart';
import '../../data/models/product_option_model.dart';
import '../../exception/app_message.dart';
import '../../presentation/res/strings/values.dart';
import '../blocs/interval/interval_submit.dart';

class ProductCubit extends Cubit<ProductState>
    implements IntervalSubmit<ProductModel> {
  final ProductRepository _repository;

  ProductCubit({
    required ProductRepository repository,
  })  : _repository = repository,
        super(ProductInitial()) {
    _init();
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  // get data method: return model if state is loaded, else return null

  void _init() async {
    emit(ProductLoading());
    _repository.getOptions().then((resOption) {
      if (resOption.type == ResponseModelType.success) {
        var listOption = resOption.data;
        _repository.gets().then((resProduct) {
          if (resProduct.type == ResponseModelType.success) {
            var list = resProduct.data;
            Future.wait([
              _repository.getsSuggestion(),
              _repository.getCategories(),
              _repository.getFavorites(),
            ]).then((resList) {
              var resSuggestion = (resList[0] as ResponseModel<List<String>>);
              var resCategory =
                  (resList[1] as ResponseModel<List<ProductCategoryModel>>);
              var resFavorite = (resList[2] as ResponseModel<List<String>>);
              List<String> suggestion = [];
              List<ProductCategoryModel> category = [];
              List<String> favorite = [];
              if (resSuggestion.type == ResponseModelType.success) {
                suggestion = resSuggestion.data;
              }
              if (resCategory.type == ResponseModelType.success) {
                category = resCategory.data;
              }
              if (resFavorite.type == ResponseModelType.success) {
                favorite = resFavorite.data;
              }
              emit(ProductLoaded(
                suggestion: suggestion,
                list: list,
                listOption: listOption,
                listType: category,
                favorites: favorite,
              ));
            });
          } else {
            emit(ProductFailure(message: resProduct.message));
          }
        });
      } else {
        emit(ProductFailure(message: resOption.message));
      }
    });
  }

  Future<AppMessage?> reloadData() async {
    var resListOption = await _repository.getOptions();
    var resList = await _repository.gets();
    var resListType = await _repository.getCategories();
    if (resList.type == ResponseModelType.success) {
      var listOption = resListOption.type == ResponseModelType.success
          ? resListOption.data
          : null;
      var listType = resListType.type == ResponseModelType.success
          ? resListType.data
          : null;
      emit(ProductLoaded(
        list: resList.data,
        listOption: listOption,
        listType: listType,
      ));
    } else {}
    return null;
  }

  Future<AppMessage?> loadFavorites() async {
    if (state is! ProductLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var res = await _repository.getFavorites();
    if (res.type == ResponseModelType.success) {
      var list = res.data;
      emit((state as ProductLoaded).copyWith(favorites: list));
      return null;
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> changeFavorite(String id, bool status) async {
    if (this.state is! ProductLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }
    var state = this.state as ProductLoaded;

    var res = await _repository.changeFavorite(id: id);
    if (res.type == ResponseModelType.success) {
      var list = state.favorites;
      if (status) {
        list.remove(id);
      } else {
        list.add(id);
      }
      emit(state.copyWith(favorites: list));
      return null;
    } else {
      return res.message;
    }
  }

  AppMessage? setUnavailable({
    required List<String> products,
    required List<String> categories,
    required List<String> options,
  }) {
    if (state is! ProductLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    emit(
      (state as ProductLoaded).copyWith(
        unavailableList: products,
        unavailableListOption: options,
        unavailableListType: categories,
      ),
    );
    return null;
  }

  @override
  Future<List<ProductModel>> submit([String? key]) async {
    if (state is ProductLoaded) {
      return (state as ProductLoaded).getSearch(key);
    }
    return <ProductModel>[];
  }

  bool checkFavorite(String id) {
    if (state is! ProductLoaded) {
      return false;
    }
    return (state as ProductLoaded).checkFavorite(id);
  }

  List<ProductModel> get list {
    if (this.state is! ProductLoaded) {
      return [];
    }
    var state = this.state as ProductLoaded;
    return state.list;
  }

  List<ProductModel> get suggestion {
    if (this.state is! ProductLoaded) {
      return [];
    }
    var state = this.state as ProductLoaded;
    return state.suggestion;
  }

  List<ProductOptionModel> get listOption {
    if (this.state is! ProductLoaded) {
      return [];
    }
    var state = this.state as ProductLoaded;
    return state.listOption;
  }

  List<ProductModel> getSearch(String? key) {
    if (this.state is! ProductLoaded) {
      return [];
    }
    var state = this.state as ProductLoaded;
    return state.getSearch(key);
  }

  List<ProductModel> getProductsByCategoryId(String categoryId) {
    if (this.state is! ProductLoaded) {
      return [];
    }
    var state = this.state as ProductLoaded;
    return state.getProductsByCategoryId(categoryId);
  }

  List<ProductModel> getFavorites() {
    if (this.state is! ProductLoaded) {
      return [];
    }
    var state = this.state as ProductLoaded;
    return state.getFavorites();
  }

  List<String> get favorites {
    if (this.state is! ProductLoaded) {
      return [];
    }
    var state = this.state as ProductLoaded;
    return state.favorites;
  }

  ProductModel? getProductById(String id) {
    if (this.state is! ProductLoaded) {
      return null;
    }
    var state = this.state as ProductLoaded;
    return state.getProductById(id);
  }

  ProductOptionItemModel? getProductOptionItemById(String id) {
    if (this.state is! ProductLoaded) {
      return null;
    }
    var state = this.state as ProductLoaded;
    return state.getProductOptionItemById(id);
  }

  int? getCostDefaultOptions(List<String> options) {
    if (this.state is! ProductLoaded) {
      return null;
    }
    var state = this.state as ProductLoaded;
    int result = 0;
    for (var id in options) {
      var model = state.getProductOptionById(id);
      if (model != null) {
        for (var itemDefault in model.defaultSelect) {
          var index = model.optionItems.indexWhere((e) => e.id == itemDefault);
          if (index != -1) {
            result += model.optionItems[index].cost;
          }
        }
      }
    }
    return result;
  }

  ProductOptionModel? getProductOptionById(String id) {
    if (this.state is! ProductLoaded) {
      return null;
    }
    var state = this.state as ProductLoaded;
    return state.getProductOptionById(id);
  }

  int? getCostOptionsItem(List<String> items) {
    if (this.state is! ProductLoaded) {
      return null;
    }
    var state = this.state as ProductLoaded;
    int result = 0;
    for (var id in items) {
      var model = state.getProductOptionItemById(id);
      if (model != null) {
        result += model.cost;
      }
    }
    return result;
  }
}
