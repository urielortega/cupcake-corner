//
//  String-EmptyChecking.swift
//  CupcakeCorner
//
//  Created by Uriel Ortega on 29/05/23.
//

import Foundation

extension String {
    var isPureWhitespace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
