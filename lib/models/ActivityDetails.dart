import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:log_book/models/Activity.dart';
import 'package:log_book/models/ActivityDetail.dart';

class ActivityDetails {
  List<ActivityDetail> detailsInfo;

  ActivityDetails({@required this.detailsInfo});

  String getDetailName({@required int index}) {
    if (index >= this.detailsInfo.length) {
      return null;
    }

    return detailsInfo[index].title;
  }

  static ActivityDetails getActivityDetailsFromJSON(dynamic details) {
    return ActivityDetails(
      detailsInfo: List<ActivityDetail>.from(
        (details as List).map(
          (detail) => ActivityDetail.getActivityDetailFromJSON(detail)
        ),
      ),
    );
  }

  toJSONEncodable() {
    return detailsInfo.map((detail) {
      return detail.toJSONEncodable();
    }).toList();
  }

  String getDetaiValue({@required int index, @required BuildContext context}) {
    if (index >= this.detailsInfo.length) {
      return null;
    }

    if (this.detailsInfo[index] is ActivityDetailDateTime) {
      return DateFormat.yMd(Localizations.localeOf(context).languageCode)
          .add_jm()
          .format((this.detailsInfo[index] as ActivityDetailDateTime).dateTime);
    } else if (this.detailsInfo[index] is ActivityDetailOpenQuestion) {
      return (this.detailsInfo[index] as ActivityDetailOpenQuestion).value;
    }

    return (this.detailsInfo[index] as ActivityDetailValues).selectedValue;
  }

  static List<ActivityDetail> getActivityDetails(
      {@required ActivityType activityType}) {
    switch (activityType) {
      case ActivityType.CILINDERS:
        return [
          ActivityDetailDateTime(title: 'Hora:'),
          ActivityDetailValues(
              title: 'Área:',
              values: [
                'Almacén mro',
                'Almacén productivo',
                'Taller mantenimiento',
                'Taller herramientas',
                'Taller servicios generales',
                'Scrap',
                'Almacén residuos peligrosos',
                'Embarques',
                'Recibos',
                'Oficinas generales',
                'Gimnasio',
                'Central',
                'Laboratorio calidad',
                'Metrología',
                'Servicio médico',
                'Sala de juntas',
                'Recursos humanos',
                'Comedor',
                'Máquina expendedora',
                'Cajero automático',
                'Palapas',
                'Área de fumar',
                'Comedor'
              ],
              hint: 'Selecciona un área:'),
          ActivityDetailOpenQuestion(
              title: '¿Contacto con alguien? (Opcional)',
              placeholder: 'Escribe sus nombres'),
        ];
      case ActivityType.LOADERS:
        return [
          ActivityDetailDateTime(title: 'Hora:'),
          ActivityDetailValues(
              title: 'Área:',
              values: [
                'Almacén mro',
                'Almacén productivo',
                'Taller mantenimiento',
                'Taller herramientas',
                'Taller servicios generales',
                'Scrap',
                'Almacén residuos peligrosos',
                'Embarques',
                'Recibos',
                'Oficinas generales',
                'Gimnasio',
                'Central',
                'Laboratorio calidad',
                'Metrología',
                'Servicio médico',
                'Sala de juntas',
                'Recursos humanos',
                'Comedor',
                'Máquina expendedora',
                'Cajero automático',
                'Palapas',
                'Área de fumar',
                'Comedor'
              ],
              hint: 'Selecciona un área:'),
          ActivityDetailOpenQuestion(
              title: '¿Contacto con alguien? (Opcional)',
              placeholder: 'Escribe sus nombres'),
        ];
      case ActivityType.COMPONENTS:
        return [
          ActivityDetailDateTime(title: 'Hora:'),
          ActivityDetailValues(
              title: 'Área:',
              values: [
                'Almacén mro',
                'Almacén productivo',
                'Taller mantenimiento',
                'Taller herramientas',
                'Taller servicios generales',
                'Scrap',
                'Almacén residuos peligrosos',
                'Embarques',
                'Recibos',
                'Oficinas generales',
                'Gimnasio',
                'Central',
                'Laboratorio calidad',
                'Metrología',
                'Servicio médico',
                'Sala de juntas',
                'Recursos humanos',
                'Comedor',
                'Máquina expendedora',
                'Cajero automático',
                'Palapas',
                'Área de fumar',
                'Comedor'
              ],
              hint: 'Selecciona un área:'),
          ActivityDetailOpenQuestion(
              title: '¿Contacto con alguien? (Opcional)',
              placeholder: 'Escribe sus nombres'),
        ];
      case ActivityType.SECURITY_BOOTH:
        return [
          ActivityDetailDateTime(title: 'Hora:'),
          ActivityDetailValues(
              title: 'Caseta:',
              values: [
                'Caseta 1',
                'Caseta 2',
                'Caseta 3',
                'Caseta 4',
                'Caseta 5'
              ],
              hint: 'Selecciona una caseta:'),
          ActivityDetailOpenQuestion(
              title: '¿Contacto con alguien? (Opcional)',
              placeholder: 'Escribe sus nombres'),
        ];
      case ActivityType.VEHICLE:
        return [
          ActivityDetailDateTime(title: 'Hora:'),
          ActivityDetailValues(
              title: 'Vehículo:',
              values: ['Camioneta', 'Gator', 'Auto de flotilla'],
              hint: 'Selecciona el tipo de vehículo:'),
          ActivityDetailOpenQuestion(
              title: 'Datos del vehículo',
              placeholder: 'Identificador, placas, etc.'),
          ActivityDetailOpenQuestion(
              title: '¿Contacto con alguien? (Opcional)',
              placeholder: 'Escribe sus nombres'),
        ];
      case ActivityType.OUTSIDE_WORK:
        return [
          ActivityDetailDateTime(title: 'Hora:'),
          ActivityDetailOpenQuestion(
              title: '¿En qué lugar estuviste?', placeholder: ''),
          ActivityDetailOpenQuestion(
              title: '¿Contacto con alguien? (Opcional)',
              placeholder: 'Escribe sus nombres'),
        ];
      case ActivityType.COMMUTE:
        return [
          ActivityDetailDateTime(title: 'Hora:'),
          ActivityDetailValues(
              title: 'Medio de transporte:',
              values: ['Transporte de personal', 'Auto particular', 'Ride'],
              hint: 'Selecciona el transporte:'),
          ActivityDetailOpenQuestion(
              title: 'Información del transporte',
              placeholder: 'Número de camión, dueño del carro, etc.'),
          ActivityDetailOpenQuestion(
              title: '¿Contacto con alguien? (Opcional)',
              placeholder: 'Escribe sus nombres'),
        ];
      case ActivityType.CONTACT:
        return [
          ActivityDetailDateTime(title: 'Hora:'),
          ActivityDetailOpenQuestion(
              title: 'Nombre de las personas:',
              placeholder: 'Escribe sus nombres aquí'),
        ];
    }

    return null;
  }
}
