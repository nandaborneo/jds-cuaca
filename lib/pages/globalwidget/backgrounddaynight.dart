import 'package:flutter/material.dart';

import '../../apptheme.dart';

class BackgroundGradientDayNight extends StatelessWidget {
    const BackgroundGradientDayNight({@required this.dayStatus, Key key}) : super(key: key);
    final bool dayStatus;
    
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [dayStatus ? AppTheme.dayStartGradient:AppTheme.nightStartGradient,
                  dayStatus ? AppTheme.dayEndGradient:AppTheme.nightEndGradient,]
        )
      ),
    );
  }
}