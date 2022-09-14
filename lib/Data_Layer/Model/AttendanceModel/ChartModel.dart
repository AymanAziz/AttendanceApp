// const tableReminder = 'Chart';
//
// class ChartModel {
//   static const List<String> values = [
//
//     'count',
//     'attend',
//   ];
//
//   static const String id = 'reminderId';
//   static const String MedicineName = 'MedicineName';
//   static const String dosage = 'dosage';
//   static const String reminderDate = 'reminderDate';
//   static const String isDone = 'isDone';
//   static const String Frequency = 'Frequency';
// }
//
// class Reminder {
//   final int? id;
//   final String MedicineName;
//   final String dosage;
//   DateTime reminderDate;
//   bool isDone;
//   final int Frequency;
//
//   //contructor model
//   Reminder({
//     this.id,
//     required this.MedicineName,
//     required this.dosage,
//     required this.reminderDate,
//     required this.isDone,
//     required this.Frequency,
//   });
//
//   Reminder copy({
//     int? id,
//     String? MedicineName,
//     String? Dosage,
//     DateTime? reminderDate,
//     bool? isDone,
//     int? Frequency,
//   }) =>
//       Reminder(
//         id: id ?? this.id,
//         MedicineName: MedicineName ?? this.MedicineName,
//         dosage: Dosage ?? this.dosage,
//         reminderDate: reminderDate ?? this.reminderDate,
//         isDone: isDone ?? this.isDone,
//         Frequency: Frequency ?? this.Frequency,
//       );
//
//   //retrieve data from
//   static Reminder fromJson(Map<String, Object?> json) => Reminder(
//     id: json[ReminderFields.id] as int?,
//     MedicineName: json[ReminderFields.MedicineName] as String,
//     dosage: json[ReminderFields.dosage] as String,
//     reminderDate:
//     DateTime.parse(json[ReminderFields.reminderDate] as String),
//     isDone: json[ReminderFields.isDone] == 1,
//     Frequency: json[ReminderFields.Frequency] as int,
//   );
//
//
//   //save data to Repository (model)
//   Map<String, Object?> toJson() => {
//     ReminderFields.id: id,
//     ReminderFields.MedicineName: MedicineName,
//     ReminderFields.dosage: dosage,
//     ReminderFields.reminderDate: reminderDate.toIso8601String(),
//     ReminderFields.isDone: isDone ? 1 : 0,
//     ReminderFields.Frequency: Frequency,
//   };
// }