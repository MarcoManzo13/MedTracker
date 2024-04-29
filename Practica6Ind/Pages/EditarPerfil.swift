//
//  EditarPerfil.swift
//  Practica6Ind
//
//  Created by iOS Lab on 12/04/24.
//

import SwiftUI
import Firebase
import FirebaseFirestoreInternal

struct EditarPerfil: View {
    @StateObject var modeloUsuarios = ViewModel()
    @State private var nombre: String = ""
    @State private var apellido: String = ""
    @State private var genero: String = ""
    @State private var fechaNacimiento: String = ""
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(radius: 3)
                            .frame(width: 350, height: 400)
                        VStack {
                            
                            Text("Name")
                            HStack {
                                TextField("Edit Name", text: $nombre)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .frame(width: 150, height: 40)
                                Text(modeloUsuarios.listaUsuarios.first?.nombre ?? "")
                                    .padding()
                                    .frame(width: 150)
                            }
                                
                            Text("Last Name")
                            HStack {
                                TextField("Edit Last Name", text: $apellido)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .frame(width: 150, height: 40)
                                Text(modeloUsuarios.listaUsuarios.first?.apellido ?? "")
                                    .padding()
                                    .frame(width: 150)
                            }
                            
                            
                            Text("Gender")
                            HStack {
                                TextField("Edit Gender", text: $genero)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .frame(width: 150, height: 40)
                                Text(modeloUsuarios.listaUsuarios.first?.genero ?? "")
                                    .padding()
                                    .frame(width: 150)
                            }
                            
                            Text("Date of Birth")
                            HStack {
                                TextField("Edit Date of Birth", text: $fechaNacimiento)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .frame(width: 150, height: 40)
                                Text(modeloUsuarios.listaUsuarios.first?.fechaNacimiento ?? "")
                                    .padding()
                                    .frame(width: 150)
                            }
                        }
                        
                    }
                    
                    Button(action: {
                        addOrModifyData()
                    }) {
                        HStack {
                            Spacer().frame(width: 20)
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .shadow(radius: 3)
                                    .frame(width: 300, height: 60)
                                    
                                Rectangle()
                                        .fill(Color(#colorLiteral(red: 0.6901960784, green: 0.5058823529, blue: 1, alpha: 1))) // #B181FF color
                                        .frame(width: 300, height: 60)
                                        .cornerRadius(20)
                                
                                Text("Save")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    
                            }
                            Spacer().frame(width: 20)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding()
                    
                    
                }
                .navigationBarTitle("Edit Profile")
                .navigationBarTitleDisplayMode(.large)
                .onAppear {
                    modeloUsuarios.getData()
                }
            }
            
        }
    }
    func addOrModifyData() {
            // Revisar si existe la información en la base de datos
            if let existingData = modeloUsuarios.listaUsuarios.first {
                // Se está actualizando la información ya existente
                modeloUsuarios.updateData(
                    medicamentosUpdate: existingData,
                    nombre: nombre,
                    apellido: apellido,
                    genero: genero,
                    fechaNacimiento: fechaNacimiento
                )
            } else {
                // Se está agregando nueva información
                modeloUsuarios.addData(
                    nombre: nombre,
                    apellido: apellido,
                    genero: genero,
                    fechaNacimiento: fechaNacimiento
                )
            }
            
            // Borrar campos cuando se termina la función
            nombre = ""
            apellido = ""
            genero = ""
            fechaNacimiento = ""
    }
}

#Preview {
    EditarPerfil()
}
