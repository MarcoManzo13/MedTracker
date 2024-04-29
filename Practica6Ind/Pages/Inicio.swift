//
//  Inicio.swift
//  Practica6Ind
//
//  Created by iOS Lab on 12/04/24.
//

import SwiftUI

struct Inicio: View {
    @Binding var succ: Bool
    @StateObject var modeloUsuarios = ViewModel()
    
    var body: some View {
        ScrollView {
        VStack {
        Image(systemName: "person.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
        
        Text(modeloUsuarios.listaUsuarios.first?.nombre ?? "Edita tu perfil...")
            .padding()
            .frame(width: 150)
        
        VStack {
            NavigationLink(destination: EditarPerfil()) {
                HStack {
                    Spacer().frame(width: 20)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(radius: 3)
                            .frame(width: 360, height: 60)
                        
                        HStack {
                            Image(systemName: "person.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Text("Editar Perfil")
                                .padding()
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .cornerRadius(8)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 25)
                    }
                    Spacer().frame(width: 20)
                }
            }
            .padding(.horizontal, 20)
            .padding()
        }
        
        Text("Mis medicamentos")
            .fontWeight(.bold)
            .font(.system(size: 25))
        
        
        FilaMedicamentos(time: "3:00pm", name: "Advil", dosage: "1 pill, after meal, daily")
        FilaMedicamentos(time: "7:00pm, 3:00pm, 11:00pm", name: "Paracetamol", dosage: "1 pill, three times a day, daily")
        
        VStack {
            NavigationLink(destination: AgregarMedicamento()) {
                HStack {
                    Spacer().frame(width: 20)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(radius: 3)
                            .frame(width: 360, height: 60)
                        
                        HStack {
                            Image(systemName: "person.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Text("Administrar Medicamentos")
                                .padding()
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .cornerRadius(8)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 25)
                    }
                    Spacer().frame(width: 20)
                }
            }
            .padding(.horizontal, 20)
            .padding()
            
            NavigationLink(destination: DashboardView(title: "Medicamentos tomados a tiempo", value: 0)) {
                HStack {
                    Spacer().frame(width: 20)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(radius: 3)
                            .frame(width: 360, height: 60)
                        
                        HStack {
                            Image(systemName: "checkmark.square.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Text("Historial de Cumplimiento")
                                .padding()
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .cornerRadius(8)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 25)
                    }
                    Spacer().frame(width: 20)
                }
            }
            .padding(.horizontal, 20)
            .padding()
        }
        
        Button(action: {
            succ = false
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
                    
                    Text("Cerrar Sesión")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                }
                Spacer().frame(width: 20)
            }
        }
        .padding(.horizontal, 20)
    }
        .onAppear {
            modeloUsuarios.getData()
        }
        }
}
}

struct FilaMedicamentos: View {
    let time: String
    let name: String
    let dosage: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 3)
                .padding()
                .frame(width: 390, height: 90)
            
            Rectangle()
                .fill(Color(#colorLiteral(red: 0.6901960784, green: 0.5058823529, blue: 1, alpha: 1)))
                .frame(width: 5, height: 70)
                .offset(x: -177)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("\(name) - \(time)")
                    .font(.headline)
                    .font(.system(size: 15))
                
                Text(dosage)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    Inicio(succ: .constant(true))
}
