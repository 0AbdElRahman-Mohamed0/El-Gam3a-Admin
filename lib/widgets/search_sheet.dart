import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

class SearchSheet extends StatefulWidget {
  SearchSheet({this.type});
  final String type;
  @override
  _SearchSheetState createState() => _SearchSheetState();
}

class _SearchSheetState extends State<SearchSheet> {
  String _search;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 11.7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.type == 'product'
                    ? 'Search Product'
                    : widget.type == 'brand'
                        ? 'Search Brand'
                        : 'Search Update Request',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: 16,
                    ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (value) => _search = value,
                decoration: InputDecoration(
                  labelText: widget.type == 'product'
                      ? 'Enter Product Name'
                      : widget.type == 'brand'
                          ? 'Enter Brand Name'
                          : 'Enter Product Name',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.085 * 0.39789,
              ),
              GestureDetector(
                onTap: () {
                  // if (isBlank(_search)) return;
                  // widget.type == 'product'
                  //     ? context.read<ProductsProvider>().searchProducts(_search)
                  //     : widget.type == 'brand'
                  //         ? context.read<BrandsProvider>().searchBrands(_search)
                  //         : context
                  //             .read<PriceUpdatesProvider>()
                  //             .searchProducts(_search);
                  // Navigator.of(context).pop();
                },
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context).buttonColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'SEARCH',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
