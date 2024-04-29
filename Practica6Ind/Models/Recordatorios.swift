//
//  Medicamentos.swift
//  Practica6Ind
//
//  Created by iOS Lab on 16/04/24.
//

import Foundation

struct Recordatorios: Identifiable {
    var id: String
    var nombreMedicamento: String
    var dosis: String
    var alertaHoras: [Date]
    var alertaDias: [Int]
}
