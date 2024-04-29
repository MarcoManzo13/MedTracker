import Foundation
import Firebase
import FirebaseFirestoreInternal

class ViewModelMedicamentos: ObservableObject {
    
    @Published var listaMedicamentos = [Medicamentos]()
    
    func updateDataMedicamentos(medicamentosUpdate: Medicamentos, nombre: String, sustanciaActiva: String, dosis: String, tipoMedicamento: String, notasAdicionales: String) {
        // Se agregó la autentificación que da Firebase, con la función auth() se puede verificar el currentUser con su uid, que se genera automáticamente en Firebase, esto se agregó a todas las funciones.
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            // No se autenticó al usario
            return
        }
        
        let db = Firestore.firestore()
        
        // Aquí se crea una referencia al documento de Firebase que se crea, esta referencia entra a la colección "users" y de ahí a la colección "medicamentos", antes de hacer las pruebas pensaba que a fuerzas se tenía que llamar users por la documentación, pero nop. Pero ya no quise cambiarlo para no hacer todas las pruebas de nuevo. Esto se agregó a todas las funciones.
        let documentRef = db.collection("usuarios").document(currentUserUID).collection("medicamentos").document(medicamentosUpdate.id)
        
        // Esto era lo mismo que ya estaba, pero lo hice que corriera en menos líneas.
        var updateData: [String: Any] = [:]
        if !nombre.isEmpty {
            updateData["nombre"] = nombre
        }
        if !sustanciaActiva.isEmpty {
            updateData["sustanciaActiva"] = sustanciaActiva
        }
        if !dosis.isEmpty {
            updateData["dosis"] = dosis
        }
        if !tipoMedicamento.isEmpty {
            updateData["tipoMedicamento"] = tipoMedicamento
        }
        if !notasAdicionales.isEmpty {
            updateData["notasAdicionales"] = notasAdicionales
        }
        
        documentRef.setData(updateData, merge: true) { error in
            if error == nil {
                self.getDataMedicamentos()
            }
        }
    }
    
    
    func deleteDataMedicamentos(medicamentosToDelete: Medicamentos) {
        // Se agregó la autentificación que da Firebase, con la función auth() se puede verificar el currentUser con su uid, que se genera automáticamente en Firebase, esto se agregó a todas las funciones.
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            // No se autenticó al usario
            return
        }
        
        let db = Firestore.firestore()
        // Aquí se crea una referencia al documento de Firebase que se crea, esta referencia entra a la colección "users" y de ahí a la colección "medicamentos", antes de hacer las pruebas pensaba que a fuerzas se tenía que llamar users por la documentación, pero nop. Pero ya no quise cambiarlo para no hacer todas las pruebas de nuevo. Esto se agregó a todas las funciones.
        db.collection("usuarios").document(currentUserUID).collection("medicamentos").document(medicamentosToDelete.id).delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.listaMedicamentos.removeAll { medicamentos in
                        return medicamentos.id == medicamentosToDelete.id
                    }
                }
            }
        }
    }
    
    func addDataMedicamentos(nombre: String, sustanciaActiva: String, dosis: String, tipoMedicamento: String, notasAdicionales: String) {
        // Se agregó la autentificación que da Firebase, con la función auth() se puede verificar el currentUser con su uid, que se genera automáticamente en Firebase, esto se agregó a todas las funciones.
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            // No se autenticó al usario
            return
        }
        
        let db = Firestore.firestore()
        // Aquí se crea una referencia al documento de Firebase que se crea, esta referencia entra a la colección "users" y de ahí a la colección "medicamentos", antes de hacer las pruebas pensaba que a fuerzas se tenía que llamar users por la documentación, pero nop. Pero ya no quise cambiarlo para no hacer todas las pruebas de nuevo. Esto se agregó a todas las funciones.
        db.collection("usuarios").document(currentUserUID).collection("medicamentos").addDocument(data: [
            "nombre": nombre,
            "sustanciaActiva": sustanciaActiva,
            "dosis": dosis,
            "tipoMedicamento": tipoMedicamento,
            "notasAdicionales": notasAdicionales,
        ]) { error in
            if error == nil {
                self.getDataMedicamentos()
            } else {
                // Error
            }
        }
    }
    
    func getDataMedicamentos() {
        // Se agregó la autentificación que da Firebase, con la función auth() se puede verificar el currentUser con su uid, que se genera automáticamente en Firebase, esto se agregó a todas las funciones.
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            // No se autenticó al usario
            return
        }
        
        let db = Firestore.firestore()
        // Aquí se crea una referencia al documento de Firebase que se crea, esta referencia entra a la colección "users" y de ahí a la colección "medicamentos", antes de hacer las pruebas pensaba que a fuerzas se tenía que llamar users por la documentación, pero nop. Pero ya no quise cambiarlo para no hacer todas las pruebas de nuevo. Esto se agregó a todas las funciones.
        db.collection("usuarios").document(currentUserUID).collection("medicamentos").getDocuments { snapshot, error in
            if error == nil, let snapshot = snapshot {
                DispatchQueue.main.async {
                    self.listaMedicamentos = snapshot.documents.map { d in
                        return Medicamentos(id: d.documentID,
                                    nombre: d["nombre"] as? String ?? "",
                                    sustanciaActiva: d["sustanciaActiva"] as? String ?? "",
                                    dosis: d["dosis"] as? String ?? "",
                                    tipoMedicamento: d["tipoMedicamento"] as? String ?? "",
                                    notasAdicionales: d["notasAdicionales"] as? String ?? ""
                        )
                    }
                }
            } else {
                // Error
            }
        }
    }
}
