import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const RoundButton({super.key,required this.title,required this.onTap,this.loading=false});

  @override
  Widget build(BuildContext context) {
    
    double height= MediaQuery.sizeOf(context).height;
    double width=  MediaQuery.sizeOf(context).width;
    return  InkWell
    (
      onTap: onTap,
      child: Container(
        height: height*0.05,
        width: width,
        decoration:  BoxDecoration(
          color: const Color(0xFF260032),
          borderRadius: BorderRadius.circular(10)
        ),
        child:  Center(child:loading ?const CircularProgressIndicator(strokeWidth: 2,color: Colors.white,):  Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
      ),
    );
  }
}