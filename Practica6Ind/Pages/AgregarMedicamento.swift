//
//  EditarPerfil.swift
//  Practica6Ind
//
//  Created by iOS Lab on 12/04/24.
//

import SwiftUI
import Firebase
import FirebaseFirestoreInternal

struct Notificacion {
    var id = UUID()
    var nombreMedicamentoRecordatorio: String
    var notificationDays: [Int] 
    var notificationTimes: [Date]
}

struct Checkbox: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(isChecked ? .blue : .black)
        }
    }
}

struct AgregarMedicamento: View {
    @StateObject var modeloMedicamentos = ViewModelMedicamentos()
    @StateObject var modeloMedicamentosGenerales = ViewModelMedicamentosGenerales()
    @State private var nombre: String = ""
    @State private var sustanciaActiva: String = ""
    @State private var dosis: String = ""
    @State private var tipoMedicamento: String = ""
    @State private var notasAdicionales: String = ""
    @State private var mostrarAnadirMedicamentos = false
    @State private var mostrarEditarMedicamentos = false
    @State private var mostrarNotificaciones = false
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @State private var notificaciones = [Notificacion]()
    @State private var selectedDate = Date()
    @State private var selectedDays: [Int] = []
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                VStack {
                    ZStack {
                        VStack(alignment: .leading) {
                            ForEach(modeloMedicamentos.listaMedicamentos, id: \.id) { medicamento in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .shadow(radius: 3)
                                    .frame(width: 350, height: 200)
                                    .overlay(
                                        VStack(alignment: .leading) {
                                            Spacer()
                                            Text(medicamento.nombre)
                                                .fontWeight(.bold)
                                                .padding(.leading)
                                            
                                            HStack {
                                                Image(systemName: "pill")
                                                Text(medicamento.dosis)
                                            }
                                            .padding(.leading)
                                            
                                            HStack {
                                                Image(systemName: "flask")
                                                Text(medicamento.sustanciaActiva)
                                            }
                                            .padding(.leading)
                                            
                                            HStack {
                                                Image(systemName: "bandage")
                                                Text(medicamento.tipoMedicamento)
                                            }
                                            .padding(.leading)
                                            
                                            HStack {
                                                Image(systemName: "note.text")
                                                Text(medicamento.notasAdicionales)
                                            }
                                            .padding(.leading)
                                            
                                            Spacer()
                                            
                                            HStack {
                                                Button(action: {
                                                    modeloMedicamentos.deleteDataMedicamentos(medicamentosToDelete: medicamento)
                                                }, label: {
                                                    Text("Borrar")
                                                        .foregroundColor(.white)
                                                        .padding(.horizontal, 12)
                                                        .padding(.vertical, 6)
                                                        .background(Color.red)
                                                        .cornerRadius(8)
                                                })
                                                Button(action: {
                                                    mostrarEditarMedicamentos.toggle()
                                                }, label: {
                                                    Text("Editar")
                                                        .foregroundColor(.white)
                                                        .padding(.horizontal, 12)
                                                        .padding(.vertical, 6)
                                                        .background(Color.blue)
                                                        .cornerRadius(8)
                                                })
                                            }
                                            Spacer()
                                        }
                                    )
                                // Editing interface
                                if mostrarEditarMedicamentos {
                                    VStack {
                                        
                                        TextField("Editar Dosis", text: $dosis)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .autocapitalization(.none)
                                            .disableAutocorrection(true)
                                            .frame(width: 300, height: 40)
                                        
                                        TextField("Editar Notas Adicionales", text: $notasAdicionales)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .autocapitalization(.none)
                                            .disableAutocorrection(true)
                                            .frame(width: 300, height: 40)
                                                
                                        // Save button to update medicine data
                                        Button(action: {
                                            modeloMedicamentos.updateDataMedicamentos(medicamentosUpdate: medicamento, nombre: nombre, sustanciaActiva: sustanciaActiva, dosis: dosis, tipoMedicamento: tipoMedicamento, notasAdicionales: notasAdicionales)
                                                    mostrarEditarMedicamentos.toggle()
                                            dosis = ""
                                            notasAdicionales = ""
                                        }) {
                                            Text("Guardar")
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                                .background(Color.blue)
                                                .cornerRadius(8)
                                            }
                                    }
                                    .padding()
                                }
                            }
                        }
                    }
                    .padding()

                    // Contenedor que permite agregar un medicamento
                    if mostrarAnadirMedicamentos {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(radius: 3)
                                .frame(width: 350)
                            VStack {
                                Text("Nombre del Medicamento")
                                    .padding(.vertical, 20)
                                TextField("Buscar Medicamento", text: $searchText, onEditingChanged: { isEditing in
                                    self.isSearching = isEditing
                                })
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 300, height: 40)
                                .onChange(of: searchText, perform: { value in
                                    if isSearching {
                                        modeloMedicamentosGenerales.searchMedicamento(query: value)
                                    }
                                })

                                // Display Search Results
                                if isSearching {
                                    VStack {
                                        ForEach(modeloMedicamentosGenerales.listaMedicamentosGenerales) { medicamento in
                                            Text(medicamento.nombre)
                                                .onTapGesture {
                                                    nombre = medicamento.nombre
                                                    sustanciaActiva = medicamento.sustanciaActiva
                                                    dosis = medicamento.dosis
                                                    tipoMedicamento = medicamento.tipoMedicamento
                                                    searchText = medicamento.nombre
                                                    isSearching = false
                                                }
                                        }
                                    }
                                    .padding(.top, 5)
                                    .frame(width: 300)
                                }
                                
                                HStack {
                                    Text("Medicamento:")
                                        .frame(width: 150)
                                    TextField("Nombre del Medicamento", text: $nombre)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 150)
                                }
                                
                                HStack {
                                    Text("Sustancia Activa:")
                                        .frame(width: 150)
                                    TextField("Sustancia Activa", text: $sustanciaActiva)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 150)
                                }
                                
                                HStack {
                                    Text("Dosis:")
                                        .frame(width: 150)
                                    TextField("Sustancia Activa", text: $dosis)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 150)
                                }
                                
                                HStack {
                                    Text("Tipo:")
                                        .frame(width: 150)
                                    TextField("Tipo de Medicamento", text: $tipoMedicamento)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 150)
                                }
                                
                                Button(action: {
                                    mostrarNotificaciones.toggle()
                                }) {
                                    HStack {
                                        Spacer().frame(width: 20)
                                        ZStack {
                                            Rectangle()
                                                    .fill(Color(#colorLiteral(red: 0.6901960784, green: 0.5058823529, blue: 1, alpha: 1))) // #B181FF color
                                                    .frame(width: 250, height: 40)
                                                    .cornerRadius(20)
                                            
                                            Text("Añadir Recordatorio")
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                
                                        }
                                        Spacer().frame(width: 20)
                                    }
                                }
                                .padding()
                                
                                
                                if mostrarNotificaciones {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white)
                                            .shadow(radius: 3)
                                            .frame(width: 300)
                                    
                                        VStack {
                                            TextField("Medicamento", text: $nombre)
                                                .padding()
                                                .background(Color(UIColor.systemBackground))
                                                .cornerRadius(8.0)
                                                .padding(.horizontal)
                                            
                                            DatePicker("Hora", selection: $selectedDate, displayedComponents: .hourAndMinute)
                                                .padding()
                                                .background(Color(UIColor.systemBackground))
                                                .cornerRadius(8.0)
                                                .padding(.horizontal)
                                            
                                            VStack {
                                                ForEach(0..<7, id: \.self) { index in
                                                    Checkbox(isChecked: Binding(
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
                                                    ))
                                                    .padding()
                                                    .background(Color(UIColor.systemBackground))
                                                    .cornerRadius(8.0)
                                                    .padding(.horizontal)
                                                    
                                                    Text("\(Calendar.current.weekdaySymbols[index])")
                                                        .padding()
                                                        .background(Color(UIColor.systemBackground))
                                                        .cornerRadius(8.0)
                                                        .padding(.horizontal)
                                                }
                                            }
                                            
                                            
                                            Button(action: {
                                                mostrarNotificaciones = false
                                            }) {
                                                Text("Guardar")
                                                    .padding()
                                                    .foregroundColor(.white)
                                                    .background(Color.blue)
                                                    .cornerRadius(8.0)
                                            }
                                            .padding()
                                        }
                                    .padding()
                                    .frame(width: 300)
                                    }
                                }
                                
                                Text("Notas Adicionales:")
                                HStack {
                                    TextField("Notas Adicionales", text: $notasAdicionales)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .frame(width: 300, height: 40)
                                }
                                Button(action: {
                                    modeloMedicamentos.addDataMedicamentos(nombre: nombre, sustanciaActiva: sustanciaActiva, dosis: dosis, tipoMedicamento: tipoMedicamento, notasAdicionales: notasAdicionales)
                                    let nuevaNotificacion = Notificacion(nombreMedicamentoRecordatorio: nombre, notificationDays: selectedDays, notificationTimes: [selectedDate])
                                    definirNotificacion(for: nuevaNotificacion)
                                    notificaciones.append(nuevaNotificacion)
                                    mostrarAnadirMedicamentos.toggle()
                                    searchText = ""
                                    nombre = ""
                                    sustanciaActiva = ""
                                    dosis = ""
                                    tipoMedicamento = ""
                                    notasAdicionales = ""
                                }) {
                                    HStack {
                                        Spacer().frame(width: 20)
                                        ZStack {
                                            Rectangle()
                                                    .fill(Color(#colorLiteral(red: 0.6901960784, green: 0.5058823529, blue: 1, alpha: 1))) // #B181FF color
                                                    .frame(width: 300, height: 40)
                                                    .cornerRadius(20)
                                            
                                            Text("Guardar")
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                
                                        }
                                        Spacer().frame(width: 20)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding()
                            }
                        }
                        .padding()
                    }
                    
                    // Botón que muestra el contenedor donde se agregan los medicamentos
                    Button(action: {
                        mostrarAnadirMedicamentos.toggle()
                    }) {
                        HStack {
                            Spacer().frame(width: 20)
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .shadow(radius: 3)
                                    .frame(width: 300, height: 40)
                                    
                                Rectangle()
                                        .fill(Color(#colorLiteral(red: 0.6901960784, green: 0.5058823529, blue: 1, alpha: 1))) // #B181FF color
                                        .frame(width: 300, height: 40)
                                        .cornerRadius(20)
                                
                                HStack {
                                    if mostrarAnadirMedicamentos {
                                        Text("Cancelar")
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        Image(systemName: "minus")
                                            .foregroundColor(.white)
                                    } else {
                                        Text("Añadir Medicamento")
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            Spacer().frame(width: 20)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding()
                }
                .navigationBarTitle("Agregar Medicamento")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    modeloMedicamentos.getDataMedicamentos()
                    permisoNotificaciones()
                }
            }
            }
        }
    }
    func permisoNotificaciones() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
            if success {
                print("Authorization granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    func definirNotificacion(for notificacion: Notificacion) {
        let content = UNMutableNotificationContent()
        content.title = "Recordatorio de medicamento"
        content.body = "Es hora de tomar \(notificacion.nombreMedicamentoRecordatorio)"
        content.sound = UNNotificationSound.default
            
        for day in notificacion.notificationDays {
            for time in notificacion.notificationTimes {
                var dateComponents = Calendar.current.dateComponents([.hour, .minute, .weekday], from: time)
                dateComponents.weekday = day + 1
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
    
}

#Preview {
    AgregarMedicamento()
}
