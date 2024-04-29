//
//  Medicamentos.swift
//  Practica6Ind
//
//  Created by iOS Lab on 16/04/24.
//

import Foundation

struct Medicamentos: Identifiable {
    var id: String
    var nombre: String
    var sustanciaActiva: String
    var dosis: String
    var tipoMedicamento: String
    var notasAdicionales: String
    var editandose: Bool = false
}
