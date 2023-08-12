
import 'package:expense_app/widgets/chart.dart';
import 'package:flutter/services.dart';
import './widgets/new_transaction.dart';

import './widgets/transaction _list.dart';
import 'package:flutter/material.dart';
import './model/transaction.dart';
import './widgets/chart.dart';
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        hintColor: Colors.amber, //button take accent color if colors not specified
        secondaryHeaderColor: Colors.purple,
        fontFamily: 'open-sans',

         ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  /*String? TitleInput;
  String? amountInput;*/ //removes non nullable instance field must be initialized error


  final List<Transaction> userTransaction = [
    // Transaction(
    //     Id: 't1', title: 'new shoes', date: DateTime.now(), amount: 69.99),
    // Transaction(
    //     Id: 't2', title: 'Groceries', date: DateTime.now(), amount: 19.99),
  ];

  bool _showChart=false;
  List<Transaction>get _recentTransactions{
    return userTransaction.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txamount,DateTime chosenDate) {
    final newTx = Transaction(
        Id: DateTime.now().toString(),
        title: txTitle,
        date: chosenDate,
        amount: txamount,
        );

    setState(() {
      userTransaction.add(newTx);
    });
  }
    void _startAddNewTransaction(BuildContext ctx) {
      showModalBottomSheet(context: ctx, builder: (_) {
        return GestureDetector(
          onTap: (){},
          child:
          NewTransaction(_addNewTransaction) ,
          behavior: HitTestBehavior.opaque,);NewTransaction(_addNewTransaction);
      });
    }


    void deleteTransaction(String id){
      setState(() {
        userTransaction.removeWhere((tx){
          return tx.Id ==id;
        } );
      });
    }

    @override
    Widget build(BuildContext context) {
      print('build()MyHomePageState');
      final mediaQuery=MediaQuery.of(context);
      final isLandscape =MediaQuery.of(context).orientation ==Orientation.landscape;
      final appBar=AppBar(
        title: Text("Personal Expenses"),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add))
        ],
      );
      final txListWidget=Container(
          height:(mediaQuery.size.height- appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
          child: TranscationList(userTransaction,deleteTransaction)
      );
      return Scaffold(
        appBar:appBar,
        body: SingleChildScrollView(child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(isLandscape)Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children:[
              Text('Show Chart'),
              Switch(value: _showChart, onChanged: (val){
                setState(() {
                  _showChart=val;
                });
              }),
            ]),
            if(!isLandscape)Container(
                height:(MediaQuery.of(context).size.height- appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,
                child: Chart(_recentTransactions)
            ),
            if(!isLandscape)txListWidget,
            if(isLandscape)_showChart
              ?Container(
                height:(MediaQuery.of(context).size.height- appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
                child: Chart(_recentTransactions)
            ):txListWidget
            //turning List of Objects into list of transcation/widgets
          ],
        ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          child: Icon(Icons.add),),
      );
    }
  }




