//
//  CrudMedicamentosGenerales.swift
//  Practica6Ind
//
//  Created by iOS Lab on 17/04/24.
//

import Foundation
import Firebase
import FirebaseFirestoreInternal

class ViewModelMedicamentosGenerales: ObservableObject {
    
    @Published var listaMedicamentosGenerales = [MedicamentosGenerales]()
    
    func getDataMedicamentos() {
        let db = Firestore.firestore()
        // Aquí se crea una referencia al documento de Firebase que se crea, esta referencia entra a la colección "users" y de ahí a la colección "medicamentos", antes de hacer las pruebas pensaba que a fuerzas se tenía que llamar users por la documentación, pero nop. Pero ya no quise cambiarlo para no hacer todas las pruebas de nuevo. Esto se agregó a todas las funciones.
        db.collection("generalMedicine").getDocuments { snapshot, error in
            if error == nil, let snapshot = snapshot {
                DispatchQueue.main.async {
                    self.listaMedicamentosGenerales = snapshot.documents.map { d in
                        return MedicamentosGenerales(id: d.documentID,
                                    nombre: d["nombre"] as? String ?? "",
                                    sustanciaActiva: d["sustanciaActiva"] as? String ?? "",
                                    dosis: d["dosis"] as? String ?? "",
                                    tipoMedicamento: d["tipoMedicamento"] as? String ?? ""
                        )
                    }
                }
            } else {
                // Error
            }
        }
    }
    
    func searchMedicamento(query: String) {
            let db = Firestore.firestore()
            db.collection("generalMedicine")
                .whereField("nombre", isGreaterThanOrEqualTo: query)
                .getDocuments { snapshot, error in
                    if let error = error {
                        print("Error getting documents: \(error)")
                    } else {
                        DispatchQueue.main.async {
                            self.listaMedicamentosGenerales = snapshot?.documents.compactMap { document in
                                let data = document.data()
                                guard let nombre = data["nombre"] as? String,
                                      let sustanciaActiva = data["sustanciaActiva"] as? String,
                                      let dosis = data["dosis"] as? String,
                                      let tipoMedicamento = data["tipoMedicamento"] as? String else {
                                    return nil
                                }
                                return MedicamentosGenerales(id: document.documentID,
                                                             nombre: nombre,
                                                             sustanciaActiva: sustanciaActiva,
                                                             dosis: dosis,
                                                             tipoMedicamento: tipoMedicamento)
                            } ?? []
                        }
                    }
                }
        }
}

