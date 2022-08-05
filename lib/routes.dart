
import 'package:agen_pulsa/page/Login.dart';
import 'package:agen_pulsa/page/base.dart';
import 'package:agen_pulsa/page/detailPage.dart';
import 'package:agen_pulsa/page/keranjangPage.dart';
import 'package:agen_pulsa/page/splashScreen.dart';
import 'package:agen_pulsa/page/suksesPesan.dart';
import 'package:agen_pulsa/page/welcomePage.dart';
import 'package:provider/provider.dart';

import 'genosLib/bloc/baseBloc.dart';


class GenProvider {
  static var providers = [
    ChangeNotifierProvider<BaseBloc>.value(value: BaseBloc()),

  ];

  static routes(context) {
    return {
//           '/': (context) {
//        return Base();
//      },

      // '/': (context) {
      //   return SplashScreen();
      // },

      '/': (context) {
        return Base();
      },

      'welcome': (context) {
        return WelcomePage();
      },

      'home': (context) {
        return Base();
      },

      'detail': (context) {
        return DetailPage();
      },

      'keranjang': (context) {
        return KeranjangPage();
      },

      'suksespesan': (context) {
        return SuksesPesanPage();
      },

      'login': (context) {
        return LoginPage();
      },

    };
  }
}
