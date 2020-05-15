import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum ActivityType {
  CONTACT_PERSON,
  EAT_WITH_SOMEONE,
  SMOKING_AREA,
  ATM,
  VENDING_MACHINE,
  STAIRS,
  RESTROOM,
  AREA,
}

class Activity {
  static IconData getActivityIcon({@required ActivityType activityType}) {
    switch (activityType) {
      case ActivityType.CONTACT_PERSON:
        return Icons.people;
      case ActivityType.EAT_WITH_SOMEONE:
        return Icons.restaurant;
      case ActivityType.SMOKING_AREA:
        return Icons.smoking_rooms;
      case ActivityType.ATM:
        return Icons.local_atm;
      case ActivityType.VENDING_MACHINE:
        return MdiIcons.cookie;
      case ActivityType.STAIRS:
        return MdiIcons.stairs;
      case ActivityType.RESTROOM:
        return Icons.wc;
      case ActivityType.AREA:
        return Icons.location_on;
    }

    return null;
  }

  static String getActivityText({@required ActivityType activityType}) {
    switch (activityType) {
      case ActivityType.CONTACT_PERSON:
        return 'Contacto con alguien';
      case ActivityType.EAT_WITH_SOMEONE:
        return 'Comida con alguien';
      case ActivityType.SMOKING_AREA:
        return 'Área para fumar utilizada';
      case ActivityType.ATM:
        return 'Cajero automático utilizado';
      case ActivityType.VENDING_MACHINE:
        return 'Máquina expendedora utilizada';
      case ActivityType.STAIRS:
        return 'Escalera utilizada';
      case ActivityType.RESTROOM:
        return 'Baño utilizado';
      case ActivityType.AREA:
        return 'Área recorrida';
    }

    return null;
  }
}
