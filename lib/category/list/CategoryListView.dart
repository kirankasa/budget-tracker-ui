import 'package:budget_tracker/category/Category.dart';
import 'package:budget_tracker/category/add/AddCategoryView.dart';
import 'package:budget_tracker/category/update/UpdateCategoryView.dart';
import 'package:budget_tracker/common/di/injection.dart';
import 'package:budget_tracker/common/ui/BudgetDrawer.dart';
import 'package:flutter/material.dart';

class CategoryListView extends StatelessWidget {
  final _repository = Injector().categoryRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      drawer: BudgetDrawer(),
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: FutureBuilder(
          builder: (BuildContext context,
              AsyncSnapshot<List<TransactionCategory>> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                  children: _buildCategoryList(context, snapshot.data));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
          future: _repository.retrieveTransactionCategories(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => onAdd(context)),
    );
  }

  onAdd(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddCategoryView()));
  }

  List<_CategoryListItem> _buildCategoryList(
      BuildContext context, List<TransactionCategory> categories) {
    return categories
        .map((category) => _CategoryListItem(
            category: category,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateCategoryView(category)));
            }))
        .toList();
  }
}

class _CategoryListItem extends ListTile {
  _CategoryListItem({TransactionCategory category, GestureTapCallback onTap})
      : super(
            title: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(category.category),
            ),
            leading: CircleAvatar(
              child: Text(category.category[0]),
            ),
            onTap: onTap);
}
