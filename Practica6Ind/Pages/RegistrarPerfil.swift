//
//  RegistrarPerfil.swift
//  Practica6Ind
//
//  Created by iOS Lab on 12/04/24.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct RegistrarPerfil: View {
    @State var succ: Bool = false
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(radius: 3)
                            .frame(width: 350, height: 300)
                            .padding(9)
                        VStack {
                            Text("Correo")
                                .padding(.top)
                            TextField("Correo", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .frame(width: 300, height: 40)
                            
                            Text("Contraseña")
                                .padding(.top)
                            TextField("Contraseña", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .frame(width: 300, height: 40)
                        }
                    }
                    
                    Button(action: {
                        regis()
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
                                
                                Text("Registrarme")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                            }
                            Spacer().frame(width: 20)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    
                    Button(action: {
                        // Add action for the button here
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
                                
                                NavigationLink(destination: ContentView()) {
                                    Text("Ya tienes cuenta? Inicia Sesión")
                                        .padding()
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .cornerRadius(8)
                                }
                                .padding()
                                
                            }
                            Spacer().frame(width: 20)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                }
                .navigationBarTitle("Registro")
                .navigationBarTitleDisplayMode(.large)
            }
        }
        
    }
    // Función para registrar con correo y contraseña
    func regis() {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
                succ = true
                
                // Ir a ContentView()
                navigateToLoginView()
            }
        }
    }

    // Función para ir a Iniciar Sesion (ContentView)
    func navigateToLoginView() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                let iniciarSesionView = ContentView()
                window.rootViewController = UIHostingController(rootView: iniciarSesionView)
                window.makeKeyAndVisible()
            }
        }
    }
}

#Preview {
  RegistrarPerfil(email: .constant(""), password: .constant(""))
}


/*

NavigationLink(destination: NavigationView {
    EditarPerfil()
        .navigationBarBackButtonHidden(true)
}) {
    Text("Editar Perfil")
        .padding()
        .foregroundColor(.black)
        .fontWeight(.bold)
        .cornerRadius(8)
}
.padding()
 
 */
