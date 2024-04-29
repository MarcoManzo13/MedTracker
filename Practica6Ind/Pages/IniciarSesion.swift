import SwiftUI
import FirebaseAuth
import Firebase

struct ContentView: View {
    @State var succ: Bool = false
    @State var email = UserDefaults.standard.string(forKey: "email") ?? ""
    @State var password = UserDefaults.standard.string(forKey: "password") ?? ""

    var body: some View {
        NavigationView {
            if succ {
                Inicio(succ: $succ)
            } else {
                Login(succ: $succ, email: $email, password: $password)
            }
        }
    }
}

struct Login: View {
    @Binding var succ: Bool
    @Binding var email: String
    @Binding var password: String

    var body: some View {
        VStack {
            Image("LogoRegistroMedicamentos")
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: 3)
                    .frame(width: 350, height: 150)
                VStack {
                    HStack {
                        Text("Email: ")
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .frame(width: 150, height: 40)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 70)

                    HStack {
                        Text("Password: ")
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .frame(width: 150, height: 40)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // Align to the start (left) of the VStack
                    .padding(.leading, 70)
                }
                
            }
            
            Button(action: {
                login()
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
                        
                        Text("Log In")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            
                    }
                    Spacer().frame(width: 20)
                }
            }
            .padding(.horizontal, 20)
            .padding()
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(radius: 3)
                    .frame(width: 300, height: 60)
                    
                Rectangle()
                        .fill(Color(#colorLiteral(red: 0.6901960784, green: 0.5058823529, blue: 1, alpha: 1))) // #B181FF color
                        .frame(width: 300, height: 60)
                        .cornerRadius(20)
                
                NavigationLink(destination: NavigationView {
                    RegistrarPerfil(email: $email, password: $password)
                        .navigationBarBackButtonHidden(true)
                }) {
                    Text("Don't have an account? Register")
                        .padding()
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .cornerRadius(8)
                }
                .padding()
                    
            }

        }
        .padding()
    }

    // Function to login with email and password
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                // handle error
            } else {
                print("success")
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(password, forKey: "password")
                succ = true
            }
        }
    }
}


#Preview {
  ContentView()
}
