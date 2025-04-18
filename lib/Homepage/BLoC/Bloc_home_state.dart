import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_task/Homepage/widgets/product_card.dart';

abstract class productSearchState{
}
class  ProductSearchInit extends productSearchState{

}

class productSearchLoading extends productSearchState{
}

class ProductSearchSucess extends productSearchState {
  final List<ProductCard> results;
  final bool hasMore ;
  ProductSearchSucess({required this.hasMore,required this.results});

  ProductSearchSucess copyWith({
    List<ProductCard>? results,
    bool? hasMore
  }) => ProductSearchSucess(results: results ?? this.results,  hasMore: hasMore?? this.hasMore);

}
class ProductQuerySearchSucess extends productSearchState{
  final List<ProductCard> results;
  ProductQuerySearchSucess({required this.results});
}
class ProductQuerySearchEmpty extends productSearchState{}
class ProductQuerySearchError extends productSearchState{
  final String message;
  ProductQuerySearchError({required this.message});
}
class ProductSearchError extends productSearchState {
  final String message;
  ProductSearchError({required this.message});
}


