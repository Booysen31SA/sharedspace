import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingView extends StatefulWidget {
    LoadingView({Key key}) : super(key: key);

    @override
    _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
    @override
    Widget build(BuildContext context) {
        final firebaseUser = context.watch<>(User);

        if(firebaseUser != null){
            print('Home View');
            //return HomeView();
        }
        else{
            print('LoginView');
            //return Signin;
        }

        // loading
        return Scaffold();
    }
}