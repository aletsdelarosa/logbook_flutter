import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

enum ActivityType {
  CILINDERS,
  LOADERS,
  COMPONENTS,
  SECURITY_BOOTH,
  VEHICLE,
  OUTSIDE_WORK,
  COMMUTE,
  CONTACT
}

class Activity {
  static IconData getActivityIcon({@required ActivityType activityType}) {
    switch (activityType) {
      case ActivityType.CILINDERS:
        return Icons.location_on;
      case ActivityType.LOADERS:
        return Icons.location_on;
      case ActivityType.COMPONENTS:
        return Icons.location_on;
      case ActivityType.VEHICLE:
        return Icons.directions_car;
      case ActivityType.OUTSIDE_WORK:
        return Icons.exit_to_app;
      case ActivityType.COMMUTE:
        return Icons.airport_shuttle;
      case ActivityType.CONTACT:
        return Icons.people;
      case ActivityType.SECURITY_BOOTH:
        return IcoFontIcons.policeCap;
    }

    return null;
  }

  static String getActivityText({@required ActivityType activityType}) {
    switch (activityType) {
      case ActivityType.CILINDERS:
        return 'Planta Cilindros';
      case ActivityType.LOADERS:
        return 'Planta Loaders';
      case ActivityType.COMPONENTS:
        return 'Planta Componentes';
      case ActivityType.SECURITY_BOOTH:
        return 'Caseta de vigilancia';
      case ActivityType.VEHICLE:
        return 'Uso de vehículo';
      case ActivityType.OUTSIDE_WORK:
        return 'Visita fuera de la planta';
      case ActivityType.COMMUTE:
        return 'Traslado al trabajo';
      case ActivityType.CONTACT:
        return 'Contacto con alguien';
    }

    return null;
  }

  static ActivityType convertStringToActivityType(String string) {
    switch (string) {
      case 'ActivityType.CILINDERS':
        return ActivityType.CILINDERS;
      case 'ActivityType.LOADERS':
        return ActivityType.LOADERS;
      case 'ActivityType.COMPONENTS':
        return ActivityType.COMPONENTS;
      case 'ActivityType.SECURITY_BOOTH':
        return ActivityType.SECURITY_BOOTH;
      case 'ActivityType.VEHICLE':
        return ActivityType.VEHICLE;
      case 'ActivityType.OUTSIDE_WORK':
        return ActivityType.OUTSIDE_WORK;
      case 'ActivityType.COMMUTE':
        return ActivityType.COMMUTE;
      default:
        return ActivityType.CONTACT;
    }
  }
}
