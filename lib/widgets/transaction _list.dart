import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';

class TranscationList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TranscationList(this.transactions,this.deleteTx);//inheriting from parent class i.e user_transaction

  @override


  Widget build(BuildContext context) {
    return  transactions.isEmpty
          ? LayoutBuilder(builder: (ctx,constraints){
         return    Column(children: [
           Text('Nothing to see here...',style: Theme.of(context).textTheme.titleLarge,),
           SizedBox(height:50),
           Container(
             height: constraints.maxHeight*0.6,
             alignment: Alignment.center,
             child: Image.asset('lib/images/waiting.png',fit: BoxFit.cover,),
           )

         ],
         );
    })
      :ListView.builder(
            itemBuilder:(ctx,index){
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(padding: EdgeInsets.all(6),
                      child:FittedBox(child:
                      Text('\$${transactions[index].amount}'),
                    ),
                  ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleLarge ,),
                  subtitle: Text(DateFormat.yMMMMd().format(transactions[index].date)) ,
                  trailing: MediaQuery.of(context).size.width>460
                      ?
                  IconButton(
                    style: IconButton.styleFrom(),

                      icon: Icon(Icons.delete),
                      onPressed: ()=>deleteTx(transactions[index].Id),
                      )
                      :
                  IconButton(
                      onPressed: ()=>deleteTx(transactions[index].Id),
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                  ),
                ),
                
              );
              
            },
            itemCount:transactions.length,


    );
  }
}
