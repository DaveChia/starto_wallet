import 'package:flutter/material.dart';
import './wallets.dart' as Wallets;
import './repeated_transactions.dart' as RepeatedTransactions;
import './category.dart' as Category;
import 'package:starto_wallet/main.dart' as Main;
import 'wallets.dart' as Wallets;

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color borderColor = Color(0xFFEBEDEF);
    Color hintTextColor = Color(0xFF9CA3AD);
    Color backgroundColor = Color(0xFFFFFFFF);
    Color nav_border_color = Color(0xFF24324A1A);
    Color selected_nav_color = Color(0xFF0472FF);
    Color unselected_nav_color = Color(0xFF616C7D);

    String selected_page = 'setting';

    double scrollHeight = MediaQuery.of(context).size.height -
        72 -
        MediaQuery.of(context).viewPadding.top - // height of status bar
        AppBar().preferredSize.height; //  height of AppBar

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          centerTitle: true,
          title: Text('Settings'),
          elevation: 0,
          automaticallyImplyLeading: false),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Container(
                height: scrollHeight,
                child: SingleChildScrollView(
                  child: Stack(children: [
                    Column(children: [
                      Container(
                        height: 28,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.0,
                              color: borderColor,
                            ),
                          ),
                        ),
                        width: double.infinity,
                        child: Text(
                          'Expense settings',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: hintTextColor,
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => RepeatedTransactions
                      //               .RepeatedTransactions()),
                      //     );
                      //   },
                      //   child: Container(
                      //     height: 48,
                      //     width: double.infinity,
                      //     decoration: BoxDecoration(
                      //       border: Border(
                      //         bottom: BorderSide(
                      //           width: 1.0,
                      //           color: borderColor,
                      //         ),
                      //       ),
                      //     ),
                      //     child: Text(
                      //       'Repeated transactions',
                      //       style: TextStyle(
                      //         fontSize: 14.0,
                      //         height:
                      //             2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      //  Budget functionalities temporary disabled
                      // GestureDetector(
                      //   onTap: () {
                      //     print("budget was tapped");
                      //   },
                      //   child: Container(
                      //     height: 48,
                      //     width: double.infinity,
                      //     decoration: BoxDecoration(
                      //       border: Border(
                      //         bottom: BorderSide(
                      //           width: 1.0,
                      //           color: borderColor,
                      //         ),
                      //       ),
                      //     ),
                      //     child: Text(
                      //       'Budget',
                      //       style: TextStyle(
                      //         fontSize: 14.0,
                      //         height:
                      //             2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      //  Wallet functionalities temporary disabled
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => Wallets.Wallets()),
                      //     );
                      //   },
                      //   child: Container(
                      //     height: 48,
                      //     width: double.infinity,
                      //     decoration: BoxDecoration(
                      //       border: Border(
                      //         bottom: BorderSide(
                      //           width: 1.0,
                      //           color: borderColor,
                      //         ),
                      //       ),
                      //     ),
                      //     child: Text(
                      //       'Wallet',
                      //       style: TextStyle(
                      //         fontSize: 14.0,
                      //         height:
                      //             2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Category.Category()),
                          );
                        },
                        child: Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: borderColor,
                              ),
                            ),
                          ),
                          child: Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 14.0,
                              height:
                                  2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 32,
                      ),
                      Container(
                        height: 28,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.0,
                              color: borderColor,
                            ),
                          ),
                        ),
                        width: double.infinity,
                        child: Text(
                          'General settings',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: hintTextColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("date format was tapped");
                        },
                        child: Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: borderColor,
                              ),
                            ),
                          ),
                          child: Text(
                            'Date format',
                            style: TextStyle(
                              fontSize: 14.0,
                              height:
                                  2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("reminders was tapped");
                        },
                        child: Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: borderColor,
                              ),
                            ),
                          ),
                          child: Text(
                            'Reminders',
                            style: TextStyle(
                              fontSize: 14.0,
                              height:
                                  2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 32,
                      ),
                      GestureDetector(
                        onTap: () {
                          print("help faq was tapped");
                        },
                        child: Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: borderColor,
                              ),
                            ),
                          ),
                          child: Text(
                            'Help/FAQ',
                            style: TextStyle(
                              fontSize: 14.0,
                              height:
                                  2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("feedback was tapped");
                        },
                        child: Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: borderColor,
                              ),
                            ),
                          ),
                          child: Text(
                            'Feedback',
                            style: TextStyle(
                              fontSize: 14.0,
                              height:
                                  2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("rate it was tapped");
                        },
                        child: Container(
                          height: 48,
                          width: double.infinity,
                          child: Text(
                            'Rate it',
                            style: TextStyle(
                              fontSize: 14.0,
                              height:
                                  2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ]),
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1.0,
                      color: nav_border_color,
                    ),
                  ),
                ),
                height: 72,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Main.MyApp()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Column(
                            children: [
                              Text(
                                '21 Nov',
                                style: TextStyle(
                                  color: selected_page == 'transaction'
                                      ? selected_nav_color
                                      : unselected_nav_color,
                                  fontSize: 14.0,
                                ),
                              ),
                              Container(
                                height: 4,
                              ),
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: selected_page == 'transaction'
                                    ? selected_nav_color
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //  Wallet functionalities temporary disabled
                    // Expanded(
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => Wallets.Wallets()),
                    //       );
                    //     },
                    //     child: Padding(
                    //       padding: EdgeInsets.only(top: 12),
                    //       child: Column(
                    //         children: [
                    //           Icon(
                    //             Icons.folder_open_rounded,
                    //             size: 24,
                    //             color: selected_page == 'wallet'
                    //                 ? selected_nav_color
                    //                 : unselected_nav_color,
                    //           ),
                    //           Container(
                    //             height: 4,
                    //           ),
                    //           Icon(
                    //             Icons.circle,
                    //             size: 8,
                    //             color: selected_page == 'wallet'
                    //                 ? selected_nav_color
                    //                 : Colors.transparent,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              Icon(
                                Icons.settings,
                                size: 24,
                                color: selected_page == 'setting'
                                    ? selected_nav_color
                                    : unselected_nav_color,
                              ),
                              Container(
                                height: 4,
                              ),
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: selected_page == 'setting'
                                    ? selected_nav_color
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
