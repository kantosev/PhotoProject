//
//  String + Extension.swift
//  ProjectAlarm
//
//  Created by Anton Kirilyuk on 22.01.2023.
//

import Foundation

extension DefaultStringInterpolation {
    /// Чтобы не появлялось предупреждение при интерполяции строки
    mutating func appendInterpolation<T>(_ optional: T?) {
        appendInterpolation(String(describing: optional))
    }
}


extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
                        
