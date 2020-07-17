import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moving_forward/category_detail.dart';
import 'package:moving_forward/localization.dart';
import 'package:moving_forward/models/category.dart';
import 'package:moving_forward/services/db.dart';
import 'package:moving_forward/theme.dart';

class CategoryList extends StatelessWidget {
  final _db = DBService.instance;

  Card _categoryCard(BuildContext context, Category category) {
    return Card(
      child: new InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoryDetail(category: category)));
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(
                    'assets/images/categories/${category.icon}.svg',
                    height: 50),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      category.description,
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 6,
      shadowColor: Colors.grey[100],
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: Icon(
        Icons.explore,
        size: 30,
        color: MfColors.dark,
      ),
      title: Text(
        'MovingForward',
        style: TextStyle(
          color: MfColors.dark,
          fontWeight: FontWeight.bold,
        ),
      ),
      titleSpacing: 0,
      backgroundColor: MfColors.primary[100],
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search, size: 30, color: MfColors.dark),
          onPressed: () {
            print('SEARCH...');
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appBar(),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 90, 20, 30),
                    color: MfColors.primary[100],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate('title'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 36),
                        ),
                        Text(
                          AppLocalizations.of(context).translate('description'),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Text(AppLocalizations.of(context)
                        .translate('header_categories')),
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  ),
                  FutureBuilder<List<Category>>(
                      future: _db.listCategories(lang: Localizations.localeOf(context).languageCode),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Category>> snapshot) {
                        if (snapshot.data != null) {
                          return Column(
                            children: snapshot.data
                                .map((category) => Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 0, 10, 10),
                                    child: _categoryCard(context, category)))
                                .toList(),
                          );
                        } else {
                          return Column(
                            children: <Widget>[
                              Center(
                                  child: Text(AppLocalizations.of(context)
                                      .translate('loading_categories')))
                            ],
                          );
                        }
                      })
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Container(
              height: 80.0,
              child: _appBar(),
            ),
          )
        ],
      ),
    );
  }
}
