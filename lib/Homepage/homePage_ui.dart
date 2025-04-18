import 'package:dev_task/Homepage/BLoC/Bloc_home_List.dart';
import 'package:dev_task/Homepage/BLoC/Bloc_home_event.dart';
import 'package:dev_task/Homepage/BLoC/Bloc_home_state.dart';
import 'package:dev_task/Homepage/widgets/product_card.dart';
import 'package:dev_task/data/Repository/_products_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_debounce/easy_debounce.dart';

class HomepageUi extends StatefulWidget {
  
  const HomepageUi({super.key});

  @override
  State<HomepageUi> createState() => _HomepageUiState();
}

class _HomepageUiState extends State<HomepageUi> {
  final ScrollController _scrollController = ScrollController();
  final ProductSearchBloc _bloc = ProductSearchBloc(ProductRepositoryImpl());
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(fetchProducts());
    _scrollController.addListener((){
     if(_scrollController.offset == _scrollController.position.maxScrollExtent){
     _bloc.add(fetchMoreProducts());
     }
    });
  }
  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: Icon(Icons.search, color: Colors.white,),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            margin: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white,
                width: 1
              )
            ),
            alignment: Alignment.center,
          ),   
          title: TextField(
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
            ),
            onChanged: (value){
              if(value.isEmpty){
                EasyDebounce.cancelAll();
                _bloc.add(fetchProducts());
              }
              else{
                  EasyDebounce.debounce(
                      'my-debouncer',                 // <-- An ID for this particular debouncer
                      Duration(milliseconds: 300),    // <-- The debounce duration
                      () => _bloc.add(search(value)),                // <-- The target method
                  );
              }
      
            },
          ),
      
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: BlocBuilder<ProductSearchBloc, productSearchState>(
            bloc: _bloc,
            builder: (context, state){
              if(state is ProductSearchInit){
              return Center(child: Text('Press the button to fetch posts'));
              }
              else if(state is productSearchLoading){
                return const Center(child: CircularProgressIndicator());
              }
              else if(state is ProductSearchSucess){
               final products = state.results;
               return SmartRefresher(
                 controller: RefreshController(),
                 onRefresh: () => _bloc.add(fetchProducts()),
                 header: ClassicHeader(),
                 footer: ClassicFooter(),
                 child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, index){
                    if(index > products.length-1){
                      return state.hasMore?
                      const Padding(
                        padding:  EdgeInsets.all(8.0),
                        child:  Center(child: CircularProgressIndicator(color: Colors.white,),),
                      ):
                      const Padding(
                        padding:  EdgeInsets.all(8.0),
                        child:  Center(child: Text("No more products", style: TextStyle(color: Colors.white ),),),
                      );
                    }
                    return Container(
                      
                      child: ProductCard(product: products[index].product,));
                  },
                  itemCount: products.length+1,
                  ),
               );
              }
              else if (state is ProductQuerySearchSucess){
                final products = state.results;
                return ListView.builder(
                controller: _scrollController,
                itemBuilder: (context, index){
                  return ProductCard(product: products[index].product,);
                },
                itemCount: products.length,
                );
              }
              else if(state is ProductQuerySearchError){
                final msg = state.message.toString();
                return  Container(
                  color: const Color.fromARGB(255, 12, 12, 12),
                  child: Center(child: Text(msg, style: const TextStyle(color: Colors.white),),),
                );
              }
              else if(state is ProductSearchError){
                final msg = state.message.toString();
                return  Center(child: Text(msg),);
              }
              else{
                return const Center(child: Text("Something went wrong"),);
              }
            
            } )
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        onPressed: (){_bloc.add(fetchProducts());
        }, child: const Icon(Icons.refresh, color: Colors.white,),),
      ),
    );
  }
}