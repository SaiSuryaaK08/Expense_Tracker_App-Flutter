
import 'package:flutter/material.dart';
class ChartBar extends StatelessWidget {
  final String Label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.Label,this.spendingAmount,this.spendingPctOfTotal);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints){
      return Column(children: [
        Container(
          height: constraints.maxHeight*0.15,
          child: FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
          ),
        ),// remove all decimal places
        SizedBox(height:constraints.maxHeight*0.05,),
        Container(
          height: constraints.maxHeight*0.6,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1.0),
                  color: Color.fromARGB(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(heightFactor: spendingPctOfTotal,
                  child:Container(
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(10),),
                  )
              ),//creates a box thats a fraction of another value
              Container(

              )
            ],
          ),
        ),
        SizedBox(height:constraints.maxHeight*0.05,),
        Container(
            height: constraints.maxHeight*0.15,
            child: FittedBox(child: Text(Label))),//display weekday

      ],
      );
    },);

  }
}
