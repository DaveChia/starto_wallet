import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './category.dart' as Categories;

class Category extends StatefulWidget {
  String category_type;
  String category_name;
  int category_index;

  Category({this.category_type, this.category_name, this.category_index});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  static const IconData warning = IconData(0xe6cb, fontFamily: 'MaterialIcons');

  Color borderColor = Color(0xFFEBEDEF);
  Color backgroundColor = Color(0xFFFFFFFF);
  Color addButtonColor = Color(0xFF24324A);
  Color hintTextColor = Color(0xFF9CA3AD);
  Color whenButtonInactiveColor = Color(0xFFC4C8CE);

  bool categoryNameError = false;

  String categoryName = '';
  String originalCategoryType = '';

  @override
  void initState() {
    super.initState();
    originalCategoryType = widget.category_type;
  }

  _store_category() async {
    if (categoryName == '') {
      categoryNameError = true;
      setState(() {});
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Fetch and decode data
    final String existing_categories =
        await prefs.getString(originalCategoryType + '_categories');

    var decodedData = jsonDecode(existing_categories);

    //  Delete category and create new category if category type has been changed
    if (originalCategoryType != widget.category_type) {
      var new_category = {'name': categoryName, 'type': widget.category_type};

      String new_categories =
          await prefs.getString(widget.category_type + '_categories');

      if (new_categories == null) {
        var encodedData = [new_category];
        var stringList = jsonEncode(encodedData);

        prefs.setString(widget.category_type + '_categories', stringList);
      } else {
        var decodedData = jsonDecode(new_categories);

        for (int i = 0; i < decodedData?.length ?? 0; i++) {
          if (decodedData[i]['name'] == new_category['name']) {
            return false;
          }
        }
        decodedData.add(new_category);

        var stringList = jsonEncode(decodedData);
        prefs.setString(widget.category_type + '_categories', stringList);
      }

      decodedData.removeAt(widget.category_index);
      var originalStringList = jsonEncode(decodedData);
      prefs.setString(originalCategoryType + '_categories', originalStringList);
    } else {
      for (int i = 0; i < decodedData?.length ?? 0; i++) {
        if (decodedData[i]['name'] == categoryName) {
          return false;
        }
      }
      decodedData[widget.category_index]['name'] = categoryName;
      var stringList = jsonEncode(decodedData);
      prefs.setString(widget.category_type + '_categories', stringList);
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Categories.Category()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    categoryName = widget.category_name;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Edit Category'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                    color: borderColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: widget.category_name.toString(),
                      textAlign: TextAlign.right,
                      onChanged: (content) {
                        categoryName = content;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name your category',
                        hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: hintTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (categoryNameError == true)
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                height: 20,
                width: double.infinity,
                child: Text(
                  'Add a name for easy recognition.',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                  ),
                ),
              ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                    color: borderColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 75,
                    height: 36,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(6.0),
                          side: BorderSide(
                            color: widget.category_type == 'expense'
                                ? addButtonColor
                                : whenButtonInactiveColor,
                          )),
                      elevation: 0,
                      color: backgroundColor,
                      onPressed: () {
                        setState(() {
                          widget.category_type = 'expense';
                        });
                      },
                      child: Row(
                        children: [
                          if (widget.category_type == 'expense')
                            Icon(
                              Icons.check,
                              color: addButtonColor,
                              size: 14,
                            ),
                          Container(
                            width: 5,
                            height: 36,
                          ),
                          Text(
                            'Expense',
                            style: TextStyle(
                              color: widget.category_type == 'expense'
                                  ? addButtonColor
                                  : whenButtonInactiveColor,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 8,
                  ),
                  ButtonTheme(
                    minWidth: 82,
                    height: 36,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(6.0),
                          side: BorderSide(
                            color: widget.category_type == 'income'
                                ? addButtonColor
                                : whenButtonInactiveColor,
                          )),
                      elevation: 0,
                      color: backgroundColor,
                      onPressed: () {
                        setState(() {
                          widget.category_type = 'income';
                        });
                      },
                      child: Row(
                        children: [
                          if (widget.category_type == 'income')
                            Icon(
                              Icons.check,
                              color: addButtonColor,
                              size: 14,
                            ),
                          Container(
                            width: 5,
                            height: 36,
                          ),
                          Text(
                            'Income',
                            style: TextStyle(
                              color: widget.category_type == 'income'
                                  ? addButtonColor
                                  : whenButtonInactiveColor,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 32,
            ),
            Row(
              children: [
                Expanded(
                  child: ButtonTheme(
                    height: 50,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(100.0),
                      ),
                      elevation: 0,
                      color: addButtonColor,
                      onPressed: () {
                        _store_category();
                      },
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
