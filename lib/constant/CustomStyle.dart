
import 'package:flutter/material.dart';

class CustomStyle {
   // ignore: non_constant_identifier_names
   TextStyle TitleValue (){
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.amber
    );
  }

   // ignore: non_constant_identifier_names
   TextStyle Title (){
     return TextStyle(
         fontSize: 20,
         fontWeight: FontWeight.bold
     );
   }

   // ignore: non_constant_identifier_names
   TextStyle Value (){
     return TextStyle(
         fontSize: 13,
     );
   }

   // ignore: non_constant_identifier_names
   TextStyle ValueColor (){
     return TextStyle(
         fontSize: 13,
       color: Colors.amber
     );
   }

   // ignore: non_constant_identifier_names
   TextStyle ValueBold (){
     return TextStyle(
         fontSize: 13,
         color: Colors.amber,
         fontWeight: FontWeight.bold
     );
   }

   // ignore: non_constant_identifier_names
   TextStyle Default (){
     return TextStyle(
         fontSize: 12,
     );
   }
}