/*
 
 import SwiftUI
 import UserNotifications
 
 struct Notificacion {
 var id = UUID()
 var nombreMedicamentoRecordatorio: String
 var notificationDays: [Int] // Array representing days of the week (0 for Sunday, 1 for Monday, ..., 6 for Saturday)
 var notificationTimes: [Date]
 }
 
 struct Notificaciones: View {
 @StateObject var modeloMedicamentos = ViewModelMedicamentos()
 @Binding var notificaciones: [Notificacion]
 var quitarNotificaciones: () -> Void
 @State private var nombreMedicamentoRecordatorio = ""
 @Binding var nombre: String
 @State private var selectedDate = Date()
 @State private var selectedDays: [Int] = []
 @State private var showAgregarMedicamento = false
 
 
 var body: some View {
 NavigationView {
 Form {
 Section(header: Text("Detalles")) {
 TextField("Medicamento", text: $nombreMedicamentoRecordatorio)
 }
 
 Section(header: Text("Seleccionar hora")) {
 DatePicker("Hora", selection: $selectedDate, displayedComponents: .hourAndMinute)
 }
 
 Section(header: Text("Dias")) {
 ForEach(0..<7, id: \.self) { index in
 Toggle(isOn: Binding(
 get: {
 self.selectedDays.contains(index)
 },
 set: { _ in
 if self.selectedDays.contains(index) {
 self.selectedDays.removeAll(where: { $0 == index })
 } else {
 self.selectedDays.append(index)
 }
 }
 )) {
 Text("\(Calendar.current.weekdaySymbols[index])")
 }
 }
 }
 
 Button(action: {
 let nuevaNotificacion = Notificacion(nombreMedicamentoRecordatorio: nombreMedicamentoRecordatorio, notificationDays: selectedDays, notificationTimes: [selectedDate])
 scheduleNotification(for: nuevaNotificacion)
 notificaciones.append(nuevaNotificacion)
 showAgregarMedicamento = true
 }) {
 Text("Guardar")
 }
 .background(
 NavigationLink(
 destination: AgregarMedicamento(),
 isActive: $showAgregarMedicamento,
 label: {
 EmptyView()
 }
 )
 )
 }
 .navigationBarTitle("Añadir recordatorio")
 }
 .onAppear {
 modeloMedicamentos.getDataMedicamentos()
 nombreMedicamentoRecordatorio = nombre
 }
 }
 
 func scheduleNotification(for notificaciones: Notificacion) {
 let content = UNMutableNotificationContent()
 content.title = "Recordatorio de medicamento"
 content.body = "Es hora de tomar \(notificaciones.nombreMedicamentoRecordatorio)"
 content.sound = UNNotificationSound.default
 
 for day in notificaciones.notificationDays {
 for time in notificaciones.notificationTimes {
 var dateComponents = Calendar.current.dateComponents([.hour, .minute, .weekday], from: time)
 dateComponents.weekday = day + 1 // Adding 1 because Calendar weekday starts from Sunday (0) but UNCalendarNotificationTrigger starts from Monday (1)
 let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
 let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
 UNUserNotificationCenter.current().add(request)
 }
 }
 }
 
 }
 */
