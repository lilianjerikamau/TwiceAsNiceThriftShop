import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motorassesmentapp/models/instructionmodels.dart';
import 'package:motorassesmentapp/screens/create_assesment.dart';
import 'package:motorassesmentapp/screens/create_instruction.dart';
import 'package:motorassesmentapp/screens/create_reinspection.dart';
import 'package:motorassesmentapp/screens/create_supplementary.dart';
import 'package:motorassesmentapp/screens/create_valuationstd.dart';
import 'package:motorassesmentapp/screens/sidemenu/side_menu.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List stocksList = [
    Instruction(
        name: "AIG INSURANCE",
        regno: "KCA 029N",
        duedate: "20/Sep/2022",
        assignedto: "GEORGE GITHINJI "),
    Instruction(
        name: "KENYAN ALLIANCE INSURANCE",
        regno: "KCC 090J",
        duedate: "20/Sep/2022",
        assignedto: "LUCY KAMAU "),
    Instruction(
        name: "AIG INSURANCE",
        regno: "KCA 029N",
        duedate: "20/Sep/2022",
        assignedto: "GEORGE GITHINJI "),
    Instruction(
        name: "SAHAM ASSURANCE",
        regno: "KCA 029N",
        duedate: "20/Sep/2022",
        assignedto: "GEORGE GITHINJI "),
    Instruction(
        name: "TAUSI ASSURANCE",
        regno: "KCA 029N",
        duedate: "20/Sep/2022",
        assignedto: "GEORGE GITHINJI "),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bool isAssessmentTapped = false;
    bool isReinspectionTapped = false;
    bool isStandardValuationTapped = false;
    bool isSpecialValuationTapped = false;
    bool isInstructionTapped = false;
  }

  bool isAssessmentTapped = false;
  bool isReinspectionTapped = false;
  bool isStandardValuationTapped = false;
  bool isSpecialValuationTapped = false;
  bool isInstructionTapped = false;
  @override
  Widget build(BuildContext context) {
    return isAssessmentTapped == false &&
            isInstructionTapped == false &&
            isReinspectionTapped == false &&
            isSpecialValuationTapped == false &&
            isStandardValuationTapped == false
        ? Scaffold(
            backgroundColor: Colors.grey[200],
            drawer: SideMenu(),
            appBar: AppBar(
              title: const Text(
                'Home',
                style: TextStyle(color: Colors.black),
              ),
              leading: Builder(
                builder: (BuildContext context) {
                  return RotatedBox(
                    quarterTurns: 1,
                    child: IconButton(
                      icon: const Icon(
                        Icons.bar_chart_rounded,
                        color: Colors.black,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  );
                },
              ),
              actions: [],
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        side: BorderSide(
                          color: Colors.red,
                          width: 1, //<-- SEE HERE
                        ),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.all(12.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('TASKS TO DO',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Icon(
                                      Icons.notifications_active,
                                      color: Colors.red,
                                    ),
                                  ]),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isAssessmentTapped = true;
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    const Icon(Icons.pending),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Assessments :5",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isStandardValuationTapped = true;
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    const Icon(Icons.pending),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Standard Valuations :5",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isReinspectionTapped = true;
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    const Icon(Icons.pending),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Reinspections:5",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isInstructionTapped = true;
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    const Icon(Icons.pending),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Instructions:5",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        side: BorderSide(
                          color: Colors.red,
                          width: 1, //<-- SEE HERE
                        ),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.all(12.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Create Assessment',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateAssesment()),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.red,
                                        )),
                                  ]),
                            ),
                            const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        side: BorderSide(
                          color: Colors.red,
                          width: 1, //<-- SEE HERE
                        ),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.all(12.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Create Valuation',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CreateValuation()),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.red,
                                        )),
                                  ]),
                            ),
                            const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        side: BorderSide(
                          color: Colors.red,
                          width: 1, //<-- SEE HERE
                        ),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.all(12.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('ReInspection',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CreateReinspection()),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.red,
                                        )),
                                  ]),
                            ),
                            const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        side: BorderSide(
                          color: Colors.red,
                          width: 1, //<-- SEE HERE
                        ),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.all(12.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Create Supplementary',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CreateSupplementary()),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.red,
                                        )),
                                  ]),
                            ),
                            const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
        : isAssessmentTapped == true
            ? Scaffold(
                backgroundColor: Colors.grey[200],
                appBar: AppBar(
                  title: const Text(
                    'Pending Assessments',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    },
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                ),
                body: ListView.builder(
                    itemCount: stocksList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(
                              stocksList[index].name,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            leading: CircleAvatar(
                              child: Text(
                                stocksList[index].regno,
                                style: const TextStyle(
                                    fontSize: 8, fontWeight: FontWeight.bold),
                              ),
                            ),
                            trailing: Text(" ${stocksList[index].duedate}"),
                          ),
                        ),
                      );
                    }))
            : isInstructionTapped == true
                ? Scaffold(
                    backgroundColor: Colors.grey[200],
                    appBar: AppBar(
                      title: const Text(
                        'Instructions',
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                    ),
                    body: ListView.builder(
                        itemCount: stocksList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: ListTile(
                                title: Text(
                                  stocksList[index].name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                leading: CircleAvatar(
                                  child: Text(
                                    stocksList[index].regno,
                                    style: const TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                trailing: Text(" ${stocksList[index].duedate}"),
                              ),
                            ),
                          );
                        }))
                : isReinspectionTapped == true
                    ? Scaffold(
                        backgroundColor: Colors.grey[200],
                        appBar: AppBar(
                          title: const Text(
                            'Reinspections',
                            style: TextStyle(color: Colors.black),
                          ),
                          leading: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                              );
                            },
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0.0,
                        ),
                        body: ListView.builder(
                            itemCount: stocksList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ListTile(
                                    title: Text(
                                      stocksList[index].name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    leading: CircleAvatar(
                                      child: Text(
                                        stocksList[index].regno,
                                        style: const TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    trailing:
                                        Text(" ${stocksList[index].duedate}"),
                                  ),
                                ),
                              );
                            }))
                    : isSpecialValuationTapped == true
                        ? Scaffold(
                            backgroundColor: Colors.grey[200],
                            appBar: AppBar(
                              title: const Text(
                                'Valuations',
                                style: TextStyle(color: Colors.black),
                              ),
                              leading: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()),
                                  );
                                },
                              ),
                              backgroundColor: Colors.white,
                              elevation: 0.0,
                            ),
                            body: ListView.builder(
                                itemCount: stocksList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: ListTile(
                                        title: Text(
                                          stocksList[index].name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        leading: CircleAvatar(
                                          child: Text(
                                            stocksList[index].regno,
                                            style: const TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        trailing: Text(
                                            " ${stocksList[index].duedate}"),
                                      ),
                                    ),
                                  );
                                }))
                        : isStandardValuationTapped == true
                            ? Scaffold(
                                backgroundColor: Colors.grey[200],
                                appBar: AppBar(
                                  title: const Text(
                                    'Standard Valuations',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  leading: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const Home()),
                                      );
                                    },
                                  ),
                                  backgroundColor: Colors.white,
                                  elevation: 0.0,
                                ),
                                body: ListView.builder(
                                    itemCount: stocksList.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: ListTile(
                                            title: Text(
                                              stocksList[index].name,
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            leading: CircleAvatar(
                                              backgroundColor: Colors.redAccent,
                                              maxRadius: 35,
                                              child: Text(
                                                stocksList[index].regno,
                                                style: const TextStyle(
                                                    fontSize: 8,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            trailing: Text(
                                                "${stocksList[index].duedate}"),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            : Container();
  }
}
