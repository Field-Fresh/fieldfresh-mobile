import 'package:fieldfreshmobile/feature/products/product_search/bloc/product_search_cubit.dart';
import 'package:fieldfreshmobile/feature/products/product_search/bloc/states.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/ThemedTextFieldFactory.dart';
import 'package:fieldfreshmobile/widgets/product_card_listItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ProductClickListener = void Function(Product product);

class ProductSearch extends StatefulWidget {
  final ProductClickListener _clickListener;

  const ProductSearch(this._clickListener, {Key key}) : super(key: key);

  @override
  _ProductSearchState createState() => _ProductSearchState(_clickListener);
}

class _ProductSearchState extends State<ProductSearch> {
  final ProductClickListener _clickListener;

  ProductSearchCubit _cubit;
  TextEditingController _searchController = TextEditingController();

  _ProductSearchState(this._clickListener);

  @override
  void initState() {
    super.initState();
    _cubit = sl<ProductSearchCubit>();
    _searchController.addListener(() {
      _cubit.searchTextUpdated(_searchController.value.text);
      // another event
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ThemedTextFieldFactory.create(_searchController, "Search"),
        BlocBuilder(
          builder: (context, ProductSearchState state) {
            List<Product> products = [];
            if (state is Loading) {
              products.addAll(state.currentProducts);
            }

            if (state is Loaded) {
              products.addAll(state.products);
            }

            Widget content;
            if (products.isEmpty) {
              content = Center(
                child: Text(
                  "No products found",
                  style: TextStyle(color: AppTheme.colors.white),
                ),
              );
            } else {
              content = ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  return GestureDetector(
                      onTap: () {
                        _clickListener.call(product);
                      },
                      child: ProductCardListItem(product));
                },
              );
            }

            return Container(
                margin: EdgeInsets.only(top: 24),
                child: Material(
                  borderRadius: BorderRadius.circular(4),
                  color: AppTheme.colors.light.secondary,
                  elevation: 8,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    height: 350,
                    child: content,
                  ),
                ));
          },
          cubit: _cubit,
        )
      ],
    );
  }
}
