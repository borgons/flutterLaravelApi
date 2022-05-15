import 'package:flutter/material.dart';

const baseURL = 'http://10.0.2.2:8000/api';
const registerURL = baseURL + '/register';
const loginURL = baseURL + '/login';
const logoutURL = baseURL + '/logout';
const userURL = baseURL + '/user';
const postsURL = baseURL + '/posts';
const commentsURL = baseURL + '/comments';

// Errors

const serverError = 'Server Error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';

// (WIDGETS)

// Input Decoration  
InputDecoration kInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    contentPadding: EdgeInsets.all(10),
    border: OutlineInputBorder(
      borderSide: BorderSide(
      width: 1,
      color: Colors.black
      )
    )
  );
}

// Button 
TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    child: Text(
        label, 
        style: TextStyle(
          color: Colors.white
        ),
    ),
    style: ButtonStyle(
      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
      padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(vertical:10))
    ),
    onPressed: () => onPressed()
  );
}

// loginRegisterHint
Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center, 
    children: [
      Text(text),
      GestureDetector(
        child: Text(
          label, 
          style: TextStyle(
            color: Colors.blue
          )
        ),
        onTap: () => onTap()
      )
    ],
  );
}


// Likes and comment btn
Expanded kLikeAndComment (
  int value, 
  IconData icon, 
  Color color, 
  Function onTap) {
      return Expanded(
        child: Material(
          child: InkWell(
            onTap: () => onTap(),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon, 
                    size: 16,
                    color: color
                  ),
                  SizedBox(width:4),
                  Text('$value')
                ],
              ),
            ),
          ),
        ),
      );
  }






















