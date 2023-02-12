//
//  String + Extension.swift
//  ProjectAlarm
//
//  Created by Антон Кирилюк on 22.01.2023.
//

import Foundation

extension DefaultStringInterpolation {
    // чтобы не появлялось предупреждение при интерполяции строки
  mutating func appendInterpolation<T>(_ optional: T?) {
    appendInterpolation(String(describing: optional))
  }
}
