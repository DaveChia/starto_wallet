import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './create_category.dart' as CreateCategory;
import './edit_category.dart' as EditCategory;
import './settings.dart' as Setting;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List expense_categories = [];
  List income_categories = [];
  List transfer_categories = [
    {'name': 'Transfer', 'type': 'transfer'}
  ];
  List active_categories = [];

  bool isEditMode = false;
  bool isFilterSearchMode = false;
  String filteredSearchString = '';

  String selectedCategory = 'expense';
  Color borderColor = Color(0xFFEBEDEF);
  Color hintTextColor = Color(0xFF9CA3AD);
  Color backgroundColor = Color(0xFFFFFFFF);
  Color addButtonColor = Color(0xFF24324A);
  Color whenButtonInactiveColor = Color(0xFFC4C8CE);
  Color whenButtonInactiveTextColor = Color(0xFF9CA3AD);
  Color whenButtonActiveColor = Color(0xFF24324A);
  Color whenButtonActiveTextColor = Color(0xFF24324A);
  Color addIconColor = Color(0xFF616C7D);
  Color activeCategoryColor = Color(0xFF3A475C);
  Color inActiveCategoryColor = Color(0xFFEBEDEF);
  Color deleteButtonColor = Color(0xFFE36565);
  Color addNewCategoryTextColor = Color(0xFF0472FF);
  var formatter = NumberFormat('#,##,###.00#');

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Object> expense_categories_local = [];
    List<Object> income_categories_local = [];

    if (prefs.getString('expense_categories') == null) {
      expense_categories_local = [];
    } else {
      expense_categories_local =
          jsonDecode(prefs.getString('expense_categories'));
    }

    if (prefs.getString('income_categories') == null) {
      income_categories_local = [];
    } else {
      income_categories_local =
          jsonDecode(prefs.getString('income_categories'));
    }

    //  Set default categories
    if (expense_categories_local.length == 0) {
      expense_categories_local = [
        {'name': 'Auto & Parking', 'type': 'expense'},
        {'name': 'bills', 'type': 'expense'},
        {'name': 'business', 'type': 'expense'},
        {'name': 'Cash & Cheque', 'type': 'expense'},
        {'name': 'education', 'type': 'expense'},
        {'name': 'entertainment', 'type': 'expense'},
        {'name': 'Gift & Charity', 'type': 'expense'},
        {'name': 'grocery', 'type': 'expense'},
        {'name': 'family', 'type': 'expense'},
        {'name': 'Food & Drink', 'type': 'expense'},
        {'name': 'fuel', 'type': 'expense'},
        {'name': 'Health & Medical', 'type': 'expense'},
        {'name': 'insurance', 'type': 'expense'},
        {'name': 'kid', 'type': 'expense'},
        {'name': 'Personal Care', 'type': 'expense'},
        {'name': 'pet', 'type': 'expense'},
        {'name': 'rental', 'type': 'expense'},
        {'name': 'shopping', 'type': 'expense'},
        {'name': 'subscription', 'type': 'expense'},
        {'name': 'tax', 'type': 'expense'},
        {'name': 'taxi', 'type': 'expense'},
        {'name': 'Public Transport', 'type': 'expense'},
        {'name': 'travel', 'type': 'expense'},
      ];

      var stringList = jsonEncode(expense_categories_local);
      prefs.setString('expense_categories', stringList);
    }

    if (income_categories_local.length == 0) {
      income_categories_local = [
        {'name': 'bonus', 'type': 'income'},
        {'name': 'deposit', 'type': 'income'},
        {'name': 'investment', 'type': 'income'},
        {'name': 'refund', 'type': 'income'},
        {'name': 'salary', 'type': 'income'},
        {'name': 'Other Income', 'type': 'income'}
      ];

      var stringList = jsonEncode(income_categories_local);
      prefs.setString('income_categories', stringList);
    }

    setState(() {
      expense_categories = expense_categories_local;
      income_categories = income_categories_local;

      active_categories = expense_categories;
    });
  }

  _deleteCategory(category_index) async {
    switch (selectedCategory) {
      case 'expense':
        expense_categories.removeAt(category_index);
        active_categories = expense_categories;
        break;
      case 'income':
        income_categories.removeAt(category_index);
        active_categories = income_categories;
        break;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var stringList = jsonEncode(active_categories);
    prefs.setString(selectedCategory + '_categories', stringList);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double scrollHeight = MediaQuery.of(context).size.height -
        100 -
        MediaQuery.of(context).viewPadding.top - // height of status bar
        AppBar().preferredSize.height; //  height of AppBar

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Category'),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (isEditMode) {
              setState(() {
                isEditMode = false;
              });
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Setting.Settings()),
                (route) => false,
              );
            }
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(
          //     Icons.grid_view,
          //     color: addIconColor,
          //   ),
          //   onPressed: () {
          //     print('list view');
          //   },
          // ),
          if (isEditMode == false)
            IconButton(
              icon: Icon(
                Icons.edit,
                color: addIconColor,
              ),
              onPressed: () {
                setState(() {
                  isEditMode = !isEditMode;
                  if (selectedCategory == 'transfer') {
                    selectedCategory = 'expense';
                    active_categories = expense_categories;
                  }
                });
              },
            ),
          if (isEditMode == true)
            IconButton(
              icon: Icon(
                Icons.add,
                color: addIconColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateCategory.Category(
                          type: 'create',
                          category_type: selectedCategory,
                          filteredSearchString: filteredSearchString)),
                );
              },
            ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            if (isEditMode == false)
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
                    Container(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (content) {
                          if (content.length > 0) {
                            isFilterSearchMode = true;
                          } else {
                            isFilterSearchMode = false;
                          }

                          List filterCategory = [];

                          switch (selectedCategory) {
                            case 'expense':
                              filterCategory = expense_categories;
                              break;
                            case 'income':
                              filterCategory = income_categories;
                              break;
                            case 'transfer':
                              filterCategory = transfer_categories;
                              break;
                          }

                          if (content.length < 4) {
                            active_categories = filterCategory;
                            filteredSearchString = '';
                            setState(() {});
                            return false;
                          }
                          filteredSearchString = content;
                          active_categories = [];
                          for (var i = 0; i < filterCategory.length; i++) {
                            if (filterCategory[i]['name'].contains(content)) {
                              active_categories.add(filterCategory[i]);
                            }
                          }

                          setState(() {});
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 15,
                    ),
                  ],
                ),
              ),
            Container(
              height: 50,
              child: Row(children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'expense';
                        active_categories = expense_categories;
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: selectedCategory == 'expense' ? 2 : 0.5,
                            color: selectedCategory == 'expense'
                                ? activeCategoryColor
                                : inActiveCategoryColor,
                          ),
                        ),
                      ),
                      child: Text(
                        'Expense',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedCategory == 'expense'
                              ? whenButtonActiveColor
                              : whenButtonInactiveTextColor,
                          fontSize: 14.0,
                          height:
                              2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'income';
                        active_categories = income_categories;
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: selectedCategory == 'income' ? 2 : 0.5,
                            color: selectedCategory == 'income'
                                ? activeCategoryColor
                                : inActiveCategoryColor,
                          ),
                        ),
                      ),
                      child: Text(
                        'Income',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedCategory == 'income'
                              ? whenButtonActiveColor
                              : whenButtonInactiveTextColor,
                          fontSize: 14.0,
                          height:
                              2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                        ),
                      ),
                    ),
                  ),
                ),
                // if (isEditMode == false)
                //   Expanded(
                //     child: GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           selectedCategory = 'transfer';
                //           active_categories = transfer_categories;
                //         });
                //       },
                //       child: Container(
                //         height: 50,
                //         decoration: BoxDecoration(
                //           border: Border(
                //             bottom: BorderSide(
                //               width: selectedCategory == 'transfer' ? 2 : 0.5,
                //               color: selectedCategory == 'transfer'
                //                   ? activeCategoryColor
                //                   : inActiveCategoryColor,
                //             ),
                //           ),
                //         ),
                //         child: Text(
                //           'Transfer',
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //             color: selectedCategory == 'transfer'
                //                 ? whenButtonActiveColor
                //                 : whenButtonInactiveTextColor,
                //             fontSize: 14.0,
                //             height:
                //                 2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: SizedBox(
                height: scrollHeight,
                width: double.infinity,
                child: (isEditMode == false)
                    ? SingleChildScrollView(
                        child: Stack(children: [
                          Column(children: [
                            for (var i = 0; i < active_categories.length; i++)
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1.0,
                                      color: borderColor,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${active_categories[i]['name'].toString()[0].toUpperCase()}${active_categories[i]['name'].toString().substring(1)}",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: hintTextColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (selectedCategory != 'transfer')
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateCategory.Category(
                                                type: 'create',
                                                category_type: selectedCategory,
                                                filteredSearchString:
                                                    filteredSearchString,
                                              )),
                                    );
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 1.0,
                                            color: borderColor,
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                text: new TextSpan(
                                                  style: new TextStyle(
                                                    fontSize: 12.0,
                                                    color:
                                                        addNewCategoryTextColor,
                                                  ),
                                                  children: <TextSpan>[
                                                    new TextSpan(text: 'Add '),
                                                    new TextSpan(
                                                        text: (filteredSearchString
                                                                    .length >
                                                                0)
                                                            ? filteredSearchString
                                                            : 'New'),
                                                    new TextSpan(text: ' +'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))),
                          ]),
                        ]),
                      )
                    : ReorderableListView(
                        children: [
                            for (var i = 0; i < active_categories.length; i++)
                              Container(
                                key: ValueKey(active_categories[i]),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1.0,
                                      color: borderColor,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: Row(
                                    children: [
                                      if (isEditMode == true)
                                        Container(
                                          width: 17,
                                          height: double.infinity,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                showAlertDialog(
                                                    context,
                                                    i,
                                                    active_categories[i]
                                                        ['name']);
                                              });
                                            },
                                            padding: new EdgeInsets.all(0.0),
                                            icon: Icon(
                                              Icons.remove_circle_outlined,
                                              color: deleteButtonColor,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      if (isEditMode == true)
                                        Container(
                                          width: 18,
                                        ),
                                      Expanded(
                                        child: Text(
                                          "${active_categories[i]['name'].toString()[0].toUpperCase()}${active_categories[i]['name'].toString().substring(1)}",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: hintTextColor,
                                          ),
                                        ),
                                      ),
                                      if (isEditMode == true)
                                        Container(
                                          width: 17,
                                          height: double.infinity,
                                          child: IconButton(
                                            padding: new EdgeInsets.all(0.0),
                                            icon: Icon(
                                              Icons.edit_outlined,
                                              color: hintTextColor,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditCategory.Category(
                                                          category_type:
                                                              active_categories[
                                                                  i]['type'],
                                                          category_name:
                                                              active_categories[
                                                                  i]['name'],
                                                          category_index: i,
                                                        )),
                                              );
                                            },
                                          ),
                                        ),
                                      if (isEditMode == true)
                                        Container(
                                          width: 24,
                                        ),
                                      if (isEditMode == true)
                                        Container(
                                          width: 17,
                                          height: double.infinity,
                                          child: IconButton(
                                            padding: new EdgeInsets.all(0.0),
                                            icon: Icon(
                                              Icons.drag_indicator,
                                              color: hintTextColor,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              )
                          ],

                        // The reorder function
                        onReorder: (oldIndex, newIndex) async {
                          if (isFilterSearchMode == true) return;
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final element = active_categories.removeAt(oldIndex);
                          active_categories.insert(newIndex, element);
                          setState(() {});
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          var stringList = jsonEncode(active_categories);
                          prefs.setString(
                              selectedCategory + '_categories', stringList);
                        }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, category_index, category_name) {
    // set up the buttons
    Widget deleteButton = TextButton(
      child: Text("Delete now"),
      onPressed: () {
        _deleteCategory(category_index);
        Navigator.of(context).pop();
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Delete Category",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: whenButtonActiveColor,
          fontSize: 16.0,
        ),
      ),
      content: RichText(
        text: new TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          style: new TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            new TextSpan(text: 'Are you sure you want to delete the category '),
            new TextSpan(
              text:
                  "${category_name[0].toUpperCase()}${category_name.substring(1)}",
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
            new TextSpan(text: ' ?'),
          ],
        ),
      ),
      // content: Text('Are you sure you want to delete the category ' +
      //     "${category_name[0].toUpperCase()}${category_name.substring(1)}" +
      //     ' ?'),

      actions: [
        cancelButton,
        deleteButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
