abstract class searchEvent{}

class fetchProducts extends searchEvent{
}

class fetchMoreProducts extends searchEvent{}

class search extends searchEvent{
  final String query;
  search(this.query);
}

class filterSearch extends searchEvent{
  final String query;
  filterSearch(this.query);
}