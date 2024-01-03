import 'package:flutter/material.dart';

class SeatWidget extends StatelessWidget {
  final void Function()? onTap;
  final String seatNumber;
  final double height;
  final double width;
  final bool isSelected;
  final bool isAvailable;

  const SeatWidget(
      {super.key,
      required this.seatNumber,
      this.onTap,
      this.height = 33,
      this.width = 33,
      this.isAvailable = true,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isAvailable
                ? isSelected
                    ? Color.fromARGB(255, 245, 221, 7)
                    : Colors.grey
                :  Colors.grey),
            color: isAvailable
                ? isSelected
                    ? Color.fromARGB(255, 247, 223, 4)
                    : Colors.white
                : Colors.black12),
                child: Center(
                  child: Text(seatNumber,style: TextStyle(color:isAvailable
                  ? isAvailable
                      ? Colors.black
                      : Colors.grey
                  : Colors.black ),),
                ),
      ),
    );
  }
}


class SeatInfoWidget  extends StatelessWidget {
  const SeatInfoWidget ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SeatWidget(seatNumber: '',height: 18,width: 18,isAvailable: false,),
        SizedBox(width: 4,),
        Text('Reserved',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),
        ),
          SizedBox(width: 16,),
        SeatWidget(seatNumber: '',height: 18,width: 18,isAvailable: true,isSelected: true,),
        SizedBox(width: 4,),
        Text('Selected',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),
        ),
          SizedBox(width: 16,),
         SeatWidget(seatNumber: '',height: 18,width: 18,isAvailable: true,isSelected: false,),
        SizedBox(width: 4,),
        Text('Available',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),
        ),
      

      ],
    );
  }
}