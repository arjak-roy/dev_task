import 'dart:math';

import 'package:dev_task/Homepage/widgets/product_card.dart';
import 'package:dev_task/data/Repository/_products_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc_home_event.dart';
import 'Bloc_home_state.dart';

class ProductSearchBloc extends Bloc<searchEvent,productSearchState>{
  final ProductRepository _productrepo;

  ProductSearchBloc(this._productrepo) : super(ProductSearchInit()){

    on<fetchProducts>((fetchProducts event, Emitter<productSearchState> emit) async{
      emit(productSearchLoading());
      try{
        final products = await _productrepo.getProducts();
        final bool hasmore = products.isNotEmpty;
        emit(ProductSearchSucess(results: products, hasMore: hasmore)); 
      } 
      catch(e){
        emit(ProductSearchError(message: e.toString()));
      }
    });

    on<fetchMoreProducts>((fetchMoreProducts event, Emitter<productSearchState> emit) async{
      final cuurentState = state;
      if(cuurentState is ProductSearchSucess){
      try{
        final List<ProductCard> products = await _productrepo.loadMore();
        final bool hasmore = products.isNotEmpty;
        emit(ProductSearchSucess(results: (cuurentState.results)..addAll(products),hasMore: hasmore)); 
      }
      catch(e){
        emit(ProductSearchError(message: e.toString()));
      }
      }
    });

  on<search>((search event, Emitter<productSearchState> emit) async{
      final query = event.query;    
      final cuurentState = state;


      if(cuurentState is ProductQuerySearchError){
        try{
          emit(productSearchLoading());
          final List<ProductCard> products = await _productrepo.searchProducts(query);
          emit(ProductQuerySearchSucess(results: products)); 
        }
        catch(e){
          emit(ProductQuerySearchError(message: "No Products found"));
        }
      }

      else if(cuurentState is ProductQuerySearchSucess){
      cuurentState.results.clear();

      try{
        emit(productSearchLoading());
        final List<ProductCard> products = await _productrepo.searchProducts(query);
        emit(ProductQuerySearchSucess(results: products)); 
      }
      catch(e){
        emit(ProductQuerySearchError(message: "No Products found"));
      }
   
      }

      else{
        try{
          emit(productSearchLoading());
          final List<ProductCard> products = await _productrepo.searchProducts(query);
          emit(ProductQuerySearchSucess(results: products)); 
        }
        catch(e){
          emit(ProductQuerySearchError(message: "No Products found"));
        }

      }
  });
  on<filterSearch> ((filterSearch event, Emitter<productSearchState> emit) async{
      final query = event.query;    
      final cuurentState = state;
      if(cuurentState is ProductSearchSucess){
        try{
          emit(productSearchLoading());
          final List<ProductCard> products = await _productrepo.getProducts();
          emit(ProductQuerySearchSucess(results: products.where((element) => element.product.category == query).toList())); 
        }
        catch(e){
          emit(ProductQuerySearchError(message: "No Products found"));
        }

      }

      });
  }}
