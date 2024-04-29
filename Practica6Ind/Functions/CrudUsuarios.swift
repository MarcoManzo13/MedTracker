import Foundation
import Firebase
import FirebaseFirestoreInternal

class ViewModel: ObservableObject {
    
    @Published var listaUsuarios = [Usuario]()
    
    func updateData(medicamentosUpdate: Usuario, nombre: String, apellido: String, genero: String, fechaNacimiento: String) {
        // Se agregó la autentificación que da Firebase, con la función auth() se puede verificar el currentUser con su uid, que se genera automáticamente en Firebase, esto se agregó a todas las funciones.
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            // No se autenticó al usario
            return
        }
        
        let db = Firestore.firestore()
        
        // Aquí se crea una referencia al documento de Firebase que se crea, esta referencia entra a la colección "users" y de ahí a la colección "medicamentos", antes de hacer las pruebas pensaba que a fuerzas se tenía que llamar users por la documentación, pero nop. Pero ya no quise cambiarlo para no hacer todas las pruebas de nuevo. Esto se agregó a todas las funciones.
        let documentRef = db.collection("usuarios").document(currentUserUID).collection("datos").document(medicamentosUpdate.id)
        
        // Esto era lo mismo que ya estaba, pero lo hice que corriera en menos líneas.
        var updateData: [String: Any] = [:]
        if !nombre.isEmpty {
            updateData["nombre"] = nombre
        }
        if !apellido.isEmpty {
            updateData["apellido"] = apellido
        }
        if !genero.isEmpty {
            updateData["genero"] = genero
        }
        if !fechaNacimiento.isEmpty {
            updateData["fechaNacimiento"] = fechaNacimiento
        }
        
        documentRef.setData(updateData, merge: true) { error in
            if error == nil {
                self.getData()
            }
        }
    }
    
    func addData(nombre: String, apellido: String, genero: String, fechaNacimiento: String) {
        // Se agregó la autentificación que da Firebase, con la función auth() se puede verificar el currentUser con su uid, que se genera automáticamente en Firebase, esto se agregó a todas las funciones.
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            // No se autenticó al usario
            return
        }
        
        let db = Firestore.firestore()
        // Aquí se crea una referencia al documento de Firebase que se crea, esta referencia entra a la colección "users" y de ahí a la colección "medicamentos", antes de hacer las pruebas pensaba que a fuerzas se tenía que llamar users por la documentación, pero nop. Pero ya no quise cambiarlo para no hacer todas las pruebas de nuevo. Esto se agregó a todas las funciones.
        db.collection("usuarios").document(currentUserUID).collection("datos").addDocument(data: [
            "nombre": nombre,
            "apellido": apellido,
            "genero": genero,
            "fechaNacimiento": fechaNacimiento,
        ]) { error in
            if error == nil {
                self.getData()
            } else {
                // Error
            }
        }
    }
    
    func getData() {
        // Se agregó la autentificación que da Firebase, con la función auth() se puede verificar el currentUser con su uid, que se genera automáticamente en Firebase, esto se agregó a todas las funciones.
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            // No se autenticó al usario
            return
        }
        
        let db = Firestore.firestore()
        // Aquí se crea una referencia al documento de Firebase que se crea, esta referencia entra a la colección "users" y de ahí a la colección "medicamentos", antes de hacer las pruebas pensaba que a fuerzas se tenía que llamar users por la documentación, pero nop. Pero ya no quise cambiarlo para no hacer todas las pruebas de nuevo. Esto se agregó a todas las funciones.
        db.collection("usuarios").document(currentUserUID).collection("datos").getDocuments { snapshot, error in
            if error == nil, let snapshot = snapshot {
                DispatchQueue.main.async {
                    self.listaUsuarios = snapshot.documents.map { d in
                        return Usuario(id: d.documentID,
                                    nombre: d["nombre"] as? String ?? "",
                                    apellido: d["apellido"] as? String ?? "",
                                    genero: d["genero"] as? String ?? "",
                                    fechaNacimiento: d["fechaNacimiento"] as? String ?? ""
                        )
                    }
                }
            } else {
                // Error
            }
        }
    }
}
