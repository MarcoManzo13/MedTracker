//
//  FilaMedicamentos.swift
//  Practica6Ind
//
//  Created by iOS Lab on 12/04/24.
//

import Foundation
import SwiftUI

struct FilaMedicamento: View {
  let time: String
  let name: String
  let dosage: String

  var body: some View {
      VStack {
          HStack {
              Text(name)
                  .font(.headline)
                  .font(.system(size: 15))
                  .frame(alignment: .leading)
              Text("-")
              Text(time)
                  .font(.system(size: 15))
              Spacer()
          }
          .frame(alignment: .leading)
          HStack {
              Text(dosage)
          }
      }
  }
}
