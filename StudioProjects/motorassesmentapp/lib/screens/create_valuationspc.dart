import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:motorassesmentapp/database/sessionpreferences.dart';
import 'package:motorassesmentapp/models/usermodels.dart';
import 'package:motorassesmentapp/database/sessionpreferences.dart';

import 'package:motorassesmentapp/models/usermodels.dart';
import 'package:motorassesmentapp/screens/create_instruction.dart';
import 'package:motorassesmentapp/screens/home.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:motorassesmentapp/screens/login_screen.dart';

import 'package:motorassesmentapp/widgets/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:motorassesmentapp/utils/config.dart' as Config;
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:query_params/query_params.dart';

class CreatSpecialeValuation extends StatefulWidget {
  const CreatSpecialeValuation({Key? key}) : super(key: key);

  @override
  State<CreatSpecialeValuation> createState() => _CreatSpecialeValuationState();
}

class _CreatSpecialeValuationState extends State<CreatSpecialeValuation> {
  late User _loggedInUser;

  int? _userid;
  int? _custid;
  int? _hrid;
  String? _username;
  String? _costcenter;
  String? loanofficerName;
  String? loanofficerEmail;
  String? loanofficerPhone;
  String? vehicleReg;
  String? chassisNo;
  String? carModel;
  String? vehicleType;
  String? vehicleColor;
  String? engineNo;
  String? custName;
  String? custPhone;
  bool _loggedIn = false;
  String? remarks;
  String? installationLocation;

  int? customerid;
  bool value1inspb1 = true;
  bool value1inspb2 = true;
  bool value1inspb3 = true;
  bool value1inspb4 = true;
  bool value1inspb5 = true;
  bool value1inspb6 = true;
  bool value1inspb7 = true;
  bool value1inspb8 = true;
  bool value1inspb9 = true;
  bool value1inspb10 = true;
  bool value1inspb11 = true;
  bool value1inspb12 = true;
  bool value1inspb13 = true;
  bool value1inspb14 = true;
  bool value1inspb15 = true;
  bool value1inspb16 = true;
  bool value1inspaf1 = true;
  bool value1inspaf2 = true;
  bool value1inspaf3 = true;
  bool value1inspaf4 = true;
  bool value1inspaf5 = true;
  bool value1inspaf6 = true;
  bool value1inspaf7 = true;
  bool value1inspaf8 = true;
  bool value1inspaf9 = true;
  bool value1inspaf10 = true;
  bool value1inspaf11 = true;
  bool value1inspaf12 = true;
  bool value1inspaf13 = true;
  bool value1inspaf14 = true;
  bool value1inspaf15 = true;
  bool value1inspaf16 = true;
  static late var _custName;
  // static late var _custEmail;
  static late var _custPhone;
  static late var _salesrepId = null;
  static late var _salesrepName = null;
  static late var _installationBranch = null;
  static late var noTracker = null;
  static late var _techName;
  static late var _techId;
  static late var _financierEmail;
  static late var _financierPhone;
  static late var custid;
  static late var financierid;
  static late var _financierName;
  List<String> listOfCustomers = [
    'AIG INSURANCE',
    'KENYAN ALLIANCE INSURANCE',
    'AIG INSURANCE',
    'SAHAM ASSURANCE',
    "TAUSI ASSURANCE"
  ];
  List<String> listOfDepartments = [
    "DEPARTMENT1",
    "DEPARTMENT2",
    "DEPARTMENT3",
    "DEPARTMENT4",
  ];
  void _toggle() {
    setState(() {
      isExistingClient = !isExistingClient;
    });
  }

  void _toggleFinancier() {
    setState(() {
      isExistingFinancier = !isExistingFinancier;
    });
  }

  @override
  void initState() {
    DateTime dateTime = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(dateTime);
    _dateinput.text = formattedDate; //set the initial value of text field

    financierid = null;
    _financierName = null;
    custid = null;
    _financierEmail = null;
    _financierPhone = null;
    _custName = null;
    // _custEmail = null;
    _custPhone = null;
    _techName = null;
    _techId = null;
    // SessionPreferences().getSelectedFinancier().then((financier) {
    //   setState(() {
    //     _selectedFinancier = financier;
    //   });
    // });

    // SessionPreferences().getSelectedCustomer().then((customer) {
    //   setState(() {
    //     _selectedCustomer = customer;
    //   });
    // });
    // customerid = widget.custID;
    // _custName = widget.custName;
    // financierid = widget.custID;
    // _financierName = widget.custName;
    isBankSelected = false;
    isFinancierSelected = false;
    iscameraopen = false;
    // isExistingClient = true;
    // print(customerid);

    SessionPreferences().getLoggedInUser().then((user) {
      setState(() {
        _loggedInUser = user;
        _userid = user.id;
        _hrid = user.hrid;
        _costcenter = user.branchname;
        _username = user.fullname;
      });
    });

    super.initState();
  }

  bool _searchmode = false;
  late BuildContext _context;

  // late User _loggedInUser;
  TextEditingController _itemDescController = new TextEditingController();

  String? _searchString;
  final _userNameInput = TextEditingController();
  final _passWordInput = TextEditingController();
  TextEditingController _searchController = new TextEditingController();
  final _loanofficername = TextEditingController();
  final _loanofficerphone = TextEditingController();
  final _loanofficeremail = TextEditingController();
  final _vehiclereg = TextEditingController();
  final _chassisno = TextEditingController();
  final _carmodel = TextEditingController();
  final _vehicletype = TextEditingController();
  final _vehiclecolor = TextEditingController();
  final _engineno = TextEditingController();
  final _custname = TextEditingController();
  final _custphone = TextEditingController();
  final _custEmail = TextEditingController();
  // final _financierid = TextEditingController();
  // final _customerid = TextEditingController();
  final _customertypeid = TextEditingController();
  final _notracker = TextEditingController();
  final _fuelsensor = TextEditingController();
  final _location = TextEditingController();
  final _installationdate = TextEditingController();
  final _remarks = TextEditingController();
  TextEditingController _dateinput = TextEditingController();
// User? _loggedInUser;

  // List<Technician>? technicians;
  String _message = 'Search';

  // late final custID;
  // late final custName;
  // TextEditingController _searchController = TextEditingController();
  // TextEditingController _itemDescController = new TextEditingController();

  bool _isEnable = false;
  var _selectedValue = null;
  var _selectedInstaller = null;
  var _selectedAccount = 'Selected Value';
  String? _dropdownError;
  late int? loansNumber = null;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey16 = GlobalKey<FormState>();
  final _formKey17 = GlobalKey<FormState>();
  bool isLoading = false;
  bool isOtherEnabled = false;
  bool isOtherEnabled2 = false;
  bool isOtherEnabled3 = false;
  bool? isBankSelected;
  bool? isFinancierSelected;
  bool? iscameraopen;
  bool isExistingClient = false;
  bool isExistingFinancier = false;
  bool isOther5 = false;
  bool isOther6 = false;
  bool isOther7 = false;
  late String otherValue6;
  late String otherValue7;

  int currentForm = 0;
  int frequencyOfTransaction = 0;
  int hasInsurance = 1;
  int hasCard = 1;
  int doYouOwnaBusiness = 1;
  int percentageComplete = 0;

  late int totalLoan;
  late String frequencyOfTransactionText;
  late String operationTime;

  late String paymentPeriodInMonths, loanTaker;
  List<String> selectedCategory = [];
  List<String> selectedCategory2 = [];
  List<String> selectedCategory3 = [];
  List<String> selectedCategory4 = [];
  List<String> selectedCategory5 = [];
  List<String> selectedCategory6 = [];
  List<String> selectedCategory7 = [];
  List<Widget> widgets = [];

  late String otherValue1;
  late String otherValue2;
  late String otherValue3;
  late String otherValue5;
  static final double containerHeight = 170.0;
  double clipHeight = containerHeight * 0.35;
  DiagonalPosition position = DiagonalPosition.BOTTOM_LEFT;
  final size = 200.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                onPressed: () {
                  print("the current form is $currentForm");
                  setState(() {
                    var form;
                    switch (currentForm) {
                      case 0:
                        form = _formKey.currentState;
                        if (currentForm == 0) {
                          currentForm = 0;
                          percentageComplete = 50;
                        }
                        break;
                      case 1:
                        form = _formKey16.currentState;
                        if (currentForm == 1) {
                          currentForm = 0;
                          percentageComplete = 100;
                        }
                        break;
                      case 2:
                        form = _formKey17.currentState;
                        if (currentForm == 2) {
                          currentForm = 1;
                          percentageComplete = 100;
                        }
                        break;
                      case 3:
                        if (currentForm == 3) {
                          currentForm = 2;
                          percentageComplete = 100;
                        }
                        break;
                    }
                  });
                },
                icon: Icon(
                  currentForm == 0 ? Icons.error : Icons.arrow_back,
                  color: Colors.redAccent,
                ),
                label: Text(currentForm == 0 ? "Invalid" : "Prev"),
                heroTag: null,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                onPressed: () {
                  print("the current form is $currentForm");
                  setState(() {
                    var form;
                    switch (currentForm) {
                      case 0:
                        form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          currentForm = 2;
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                                "Make sure all required fields are filled"),
                            duration: Duration(seconds: 3),
                          ));
                        }
                        if (form.validate()) {
                          form.save();
                          currentForm = 1;
                          percentageComplete = 25;
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                                "Make sure all required fields are filled"),
                            duration: Duration(seconds: 3),
                          ));
                        }

                        break;

                      case 1:
                        form = _formKey16.currentState;
                        if (form.validate()) {
                          form.save();
                          currentForm = 2;
                          percentageComplete = 100;
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                                "Make sure all required fields are filled"),
                            duration: Duration(seconds: 3),
                          ));
                        }

                        break;
                      case 2:
                        form = _formKey17.currentState;
                        if (form.validate()) {
                          form.save();
                          currentForm = 3;
                          percentageComplete = 100;
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                                "Make sure all required fields are filled"),
                            duration: Duration(seconds: 3),
                          ));
                        }
                    }
                  });
                },
                icon: Icon(currentForm == 3
                    ? Icons.upload_rounded
                    : Icons.arrow_forward),
                label: Text(currentForm == 2 ? "finish" : "next"),
              ),
            ),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: Builder(
            builder: (BuildContext context) {
              return RotatedBox(
                quarterTurns: 0,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            top: true,
            child: Column(
              children: <Widget>[
                Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    isLoading
                        ? const LinearProgressIndicator()
                        : const SizedBox(),
                    Diagonal(
                      position: position,
                      clipHeight: clipHeight,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Create Supplementary',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 1.0),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 0,
                ),
                [
                  Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        Card(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(),
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                ],
                              ),
                            )),
                        Card(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 30),
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Select Customer",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "*",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(color: Colors.red),
                                        )
                                      ],
                                    ),
                                    DropdownButtonFormField(
                                      hint: const Text(
                                        "Enter Client's Account Type",
                                      ),
                                      isExpanded: true,
                                      onChanged: (String? value) {
                                        _toggleFinancier();
                                        setState(() {
                                          _selectedAccount = value!;
                                          if (_selectedAccount ==
                                              'Selected Value') {
                                            setState(() {
                                              // isBankSelected = false;
                                            });
                                          } else if (_selectedAccount ==
                                              'Bank') {
                                            setState(() {
                                              // isBankSelected = true;
                                            });
                                          }
                                        });
                                      },
                                      onSaved: (String? value) {
                                        setState(() {
                                          _selectedAccount = value!;
                                        });
                                      },
                                      validator: (value) {
                                        if (value != null) {
                                          return null;
                                        } else {
                                          return "can't be empty";
                                        }
                                      },
                                      items: listOfCustomers.map((String val) {
                                        return DropdownMenuItem(
                                          value: val,
                                          child: Text(
                                            val,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Transaction Date	",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(color: Colors.red),
                                        )
                                      ],
                                    ),
                                    TextField(
                                      controller:
                                          _dateinput, //editing controller of this TextField
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color: Colors.red,
                                        ), //icon of text field
                                      ),
                                      readOnly:
                                          true, //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(
                                                    2000), //DateTime.now() - not to allow to choose before today.
                                                lastDate: DateTime(2101));

                                        if (pickedDate != null) {
                                          print(
                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(pickedDate);
                                          print(
                                              formattedDate); //formatted date output using intl package =>  2021-03-16
                                          //you can implement different kind of Date Format here according to your requirement

                                          setState(() {
                                            _dateinput.text =
                                                formattedDate; //set output date to TextField value.
                                          });
                                        } else {
                                          print("Date is not selected");
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Valuation Date",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(color: Colors.red),
                                        )
                                      ],
                                    ),
                                    TextField(
                                      controller:
                                          _dateinput, //editing controller of this TextField
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color: Colors.red,
                                        ), //icon of text field
                                      ),
                                      readOnly:
                                          true, //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(
                                                    2000), //DateTime.now() - not to allow to choose before today.
                                                lastDate: DateTime(2101));

                                        if (pickedDate != null) {
                                          print(
                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(pickedDate);
                                          print(
                                              formattedDate); //formatted date output using intl package =>  2021-03-16
                                          //you can implement different kind of Date Format here according to your requirement

                                          setState(() {
                                            _dateinput.text =
                                                formattedDate; //set output date to TextField value.
                                          });
                                        } else {
                                          print("Date is not selected");
                                        }
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Department",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "*",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(color: Colors.red),
                                        )
                                      ],
                                    ),
                                    DropdownButtonFormField(
                                      hint: const Text(
                                        "Select Department",
                                      ),
                                      isExpanded: true,
                                      onChanged: (String? value) {
                                        _toggleFinancier();
                                        setState(() {
                                          _selectedAccount = value!;
                                          if (_selectedAccount ==
                                              'Selected Value') {
                                            setState(() {
                                              // isBankSelected = false;
                                            });
                                          } else if (_selectedAccount ==
                                              'Bank') {
                                            setState(() {
                                              // isBankSelected = true;
                                            });
                                          }
                                        });
                                      },
                                      onSaved: (String? value) {
                                        setState(() {
                                          _selectedAccount = value!;
                                        });
                                      },
                                      validator: (value) {
                                        if (value != null) {
                                          return null;
                                        } else {
                                          return "can't be empty";
                                        }
                                      },
                                      items:
                                          listOfDepartments.map((String val) {
                                        return DropdownMenuItem(
                                          value: val,
                                          child: Text(
                                            val,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ))
                      ])),
                  Form(
                      key: _formKey16,
                      child: Column(children: <Widget>[
                        Card(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Instruction Details",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                ],
                              ),
                            )),
                        Card(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Insured/Owner",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                      Text(
                                        "*",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.red),
                                      )
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _vehiclereg,
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {vehicleReg},
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                        hintText: "Insured/Owner"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Claim No",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _engineno,
                                    onSaved: (value) => {engineNo},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Claim No"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Policy No.",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _vehiclecolor,
                                    onSaved: (value) => {vehicleColor},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Policy No."),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Location",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                      Text(
                                        "*",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.red),
                                      )
                                    ],
                                  ),
                                  TextFormField(
                                    readOnly: true,
                                    initialValue: _costcenter,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Vehicle Location"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Reg No",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                      Text(
                                        "*",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.red),
                                      )
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _vehiclereg,
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {vehicleReg},
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                        hintText: "Reg No"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ))
                      ])),
                  Form(
                      key: _formKey17,
                      child: Column(children: <Widget>[
                        Card(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Vehicle Details",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                ],
                              ),
                            )),
                        Card(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Make",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _engineno,
                                    onSaved: (value) => {engineNo},
                                    keyboardType: TextInputType.text,
                                    decoration:
                                        const InputDecoration(hintText: "Make"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Type/Model	",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _engineno,
                                    onSaved: (value) => {engineNo},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Type/Model	 By"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Year",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _engineno,
                                    onSaved: (value) => {engineNo},
                                    keyboardType: TextInputType.text,
                                    decoration:
                                        const InputDecoration(hintText: "Year"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Color",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _engineno,
                                    onSaved: (value) => {engineNo},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Color"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Engine No.",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _engineno,
                                    onSaved: (value) => {engineNo},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Engine No."),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Chassis No",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _engineno,
                                    onSaved: (value) => {engineNo},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Chassis No"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Body Type",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _engineno,
                                    onSaved: (value) => {engineNo},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Body Type"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Engine Capacity",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _engineno,
                                    onSaved: (value) => {engineNo},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Engine Capacity"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Place of inspection",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _engineno,
                                    onSaved: (value) => {engineNo},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Color"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Engine No.",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _engineno,
                                    onSaved: (value) => {engineNo},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Engine No."),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Fuel by",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _engineno,
                                    onSaved: (value) => {engineNo},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Fuel by"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Country of origin",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _engineno,
                                    onSaved: (value) => {engineNo},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Country of origin"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Reg Date	",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                      Text(
                                        "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.red),
                                      )
                                    ],
                                  ),
                                  TextField(
                                    controller:
                                        _dateinput, //editing controller of this TextField
                                    decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.calendar_today,
                                        color: Colors.red,
                                      ), //icon of text field
                                    ),
                                    readOnly:
                                        true, //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(
                                                  2000), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(2101));

                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                            DateFormat('dd/MM/yyyy')
                                                .format(pickedDate);
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2021-03-16
                                        //you can implement different kind of Date Format here according to your requirement

                                        setState(() {
                                          _dateinput.text =
                                              formattedDate; //set output date to TextField value.
                                        });
                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ))
                      ])),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _formKey16,
                    child: Column(children: <Widget>[
                      Card(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 0.9,
                          shape: const RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.redAccent, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 30, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Common Features",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Divider(color: Colors.red),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Central Locking'),
                                        selected: value1inspb1,
                                        value: value1inspb1,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb1 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Power Windows RHF'),
                                        selected: value1inspaf1,
                                        value: value1inspaf1,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf1 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Power Windows LHF'),
                                        selected: value1inspb2,
                                        value: value1inspb2,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb2 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Power Windows RHR'),
                                        selected: value1inspaf2,
                                        value: value1inspaf2,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf2 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Power Windows LHR'),
                                        selected: value1inspb3,
                                        value: value1inspb3,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb3 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Power Mirrors'),
                                        selected: value1inspaf3,
                                        value: value1inspaf3,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf3 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Power Steering'),
                                        selected: value1inspb1,
                                        value: value1inspb1,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb1 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('A/Conditioner'),
                                        selected: value1inspaf1,
                                        value: value1inspaf1,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf1 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('ABS Brakes'),
                                        selected: value1inspb2,
                                        value: value1inspb2,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb2 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Fog Lights'),
                                        selected: value1inspaf2,
                                        value: value1inspaf2,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf2 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Roof Rails'),
                                        selected: value1inspb3,
                                        value: value1inspb3,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb3 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Rear Spoiler'),
                                        selected: value1inspaf3,
                                        value: value1inspaf3,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf3 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Side Steps'),
                                        selected: value1inspb1,
                                        value: value1inspb1,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb1 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Fabric Seats'),
                                        selected: value1inspaf1,
                                        value: value1inspaf1,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf1 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Spare Wheel Cover'),
                                        selected: value1inspb2,
                                        value: value1inspb2,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb2 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Dashboard A/Bag'),
                                        selected: value1inspaf2,
                                        value: value1inspaf2,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf2 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Steering Airbag'),
                                        selected: value1inspb3,
                                        value: value1inspb3,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb3 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Alloy Rims'),
                                        selected: value1inspaf3,
                                        value: value1inspaf3,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf3 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Flexible(
                                        child: CheckboxListTile(
                                          title: const Text('Chrome Rims'),
                                          selected: value1inspb1,
                                          value: value1inspb1,
                                          activeColor: Colors.red,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              value1inspb1 = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ]),
                                Row(
                                  children: [
                                    Text(
                                      "Any Other Feature Noted	",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText:
                                          "Enter Any Other Feature Noted	"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )),
                      Card(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 0.9,
                          shape: const RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.redAccent, width: 1),
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 30, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Radio/Music Systems",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Detachable'),
                                        selected: value1inspb4,
                                        value: value1inspb4,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb4 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Inbuilt'),
                                        selected: value1inspaf4,
                                        value: value1inspaf4,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf4 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text(
                                            'Fitted with AM/FM only'),
                                        selected: value1inspb5,
                                        value: value1inspb5,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb5 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Cassette player'),
                                        selected: value1inspaf5,
                                        value: value1inspaf5,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf5 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: value1inspb6,
                                        value: value1inspb6,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb6 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('CD/DVD Player'),
                                        selected: value1inspaf6,
                                        value: value1inspaf6,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf6 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Mini Disc player'),
                                        selected: value1inspb7,
                                        value: value1inspb7,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb7 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Map Reader'),
                                        selected: value1inspaf7,
                                        value: value1inspaf7,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf7 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('HDD Card Reader'),
                                        selected: value1inspb8,
                                        value: value1inspb8,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb8 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('USB Reader'),
                                        selected: value1inspaf8,
                                        value: value1inspaf8,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf8 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Bluetooth'),
                                        selected: value1inspb9,
                                        value: value1inspb9,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb9 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('TV/LCD Screen'),
                                        selected: value1inspaf9,
                                        value: value1inspaf9,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf9 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('CD Changer'),
                                        selected: value1inspb9,
                                        value: value1inspb9,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb9 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Reverse Camera'),
                                        selected: value1inspaf9,
                                        value: value1inspaf9,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf9 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Make/Model",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Make/Model"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "No. of Discs",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText: "No. of Discs"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Any Other Feature",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Any Other Feature"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Music System Approx Value",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText:
                                          "Enter Music System Approx Value"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )),
                      Card(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 0.9,
                          shape: const RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.redAccent, width: 1),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 30, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Anti-Theft Type",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Divider(color: Colors.red),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title:
                                            const Text('Locally Fitted Alarm'),
                                        selected: value1inspb10,
                                        value: value1inspb10,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb10 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text(
                                            'Inbuilt Security Door Locks'),
                                        selected: value1inspaf10,
                                        value: value1inspaf10,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf10 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Inbuilt Alarm'),
                                        selected: value1inspb11,
                                        value: value1inspb11,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb11 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title:
                                            const Text('Inbuilt Immobilizer'),
                                        selected: value1inspaf11,
                                        value: value1inspaf11,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf11 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        selected: value1inspb12,
                                        title: const Text('	Keyless Ignition'),
                                        value: value1inspb12,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb12 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Tracking Device'),
                                        selected: value1inspaf12,
                                        value: value1inspaf12,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf12 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Geer Lever Lock'),
                                        selected: value1inspb13,
                                        value: value1inspb13,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb13 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Engine Cut Off'),
                                        selected: value1inspaf13,
                                        value: value1inspaf13,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf13 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Make",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Make"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Any Other Anti-Theft Feature",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText:
                                          "Enter Any Other Anti-Theft Feature"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )),
                      Card(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 0.9,
                          shape: const RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.redAccent, width: 1),
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 30, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Radio/Music Systems",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Detachable'),
                                        selected: value1inspb4,
                                        value: value1inspb4,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb4 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Inbuilt'),
                                        selected: value1inspaf4,
                                        value: value1inspaf4,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf4 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text(
                                            'Fitted with AM/FM only'),
                                        selected: value1inspb5,
                                        value: value1inspb5,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb5 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Cassette player'),
                                        selected: value1inspaf5,
                                        value: value1inspaf5,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf5 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: value1inspb6,
                                        value: value1inspb6,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb6 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('CD/DVD Player'),
                                        selected: value1inspaf6,
                                        value: value1inspaf6,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf6 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Mini Disc player'),
                                        selected: value1inspb7,
                                        value: value1inspb7,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb7 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Map Reader'),
                                        selected: value1inspaf7,
                                        value: value1inspaf7,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf7 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('HDD Card Reader'),
                                        selected: value1inspb8,
                                        value: value1inspb8,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb8 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('USB Reader'),
                                        selected: value1inspaf8,
                                        value: value1inspaf8,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf8 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Bluetooth'),
                                        selected: value1inspb9,
                                        value: value1inspb9,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb9 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('TV/LCD Screen'),
                                        selected: value1inspaf9,
                                        value: value1inspaf9,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf9 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('CD Changer'),
                                        selected: value1inspb9,
                                        value: value1inspb9,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb9 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Reverse Camera'),
                                        selected: value1inspaf9,
                                        value: value1inspaf9,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf9 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Make/Model",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Make/Model"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "No. of Discs",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText: "No. of Discs"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Any Other Feature",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Any Other Feature"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Music System Approx Value",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText:
                                          "Enter Music System Approx Value"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )),
                      Card(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 0.9,
                          shape: const RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.redAccent, width: 1),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 30, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Windscreens",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Divider(color: Colors.red),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Front",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Front"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Rear",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Rear"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Doors",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Doors"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Approxmate Value",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Approxmate Value"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )),
                      Card(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 0.9,
                          shape: const RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.redAccent, width: 1),
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 30, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Added Features",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Seat Covers'),
                                        selected: value1inspb4,
                                        value: value1inspb4,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb4 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Turbo Timer'),
                                        selected: value1inspaf4,
                                        value: value1inspaf4,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf4 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title:
                                            const Text('Front Grill/Bull Bar'),
                                        selected: value1inspb5,
                                        value: value1inspb5,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb5 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Roof Carrier'),
                                        selected: value1inspaf5,
                                        value: value1inspaf5,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf5 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Rear Bumper Guard'),
                                        selected: value1inspb6,
                                        value: value1inspb6,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb6 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('Suspension Spacers'),
                                        selected: value1inspaf6,
                                        value: value1inspaf6,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspaf6 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text(
                                            'Special/Extra Large Rims'),
                                        selected: value1inspb7,
                                        value: value1inspb7,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            value1inspb7 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Rims Size",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Rims Size"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Any Other Feature",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    Text(
                                      "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: _vehiclereg,
                                  validator: (value) => value!.isEmpty
                                      ? "This field is required"
                                      : null,
                                  onSaved: (value) => {vehicleReg},
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Any Other Feature"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )),
                    ]),
                  ),
                  Column(children: <Widget>[
                    Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )),
                  ])
                ][currentForm]
              ],
            ),
          ),
        ));
  }
}
