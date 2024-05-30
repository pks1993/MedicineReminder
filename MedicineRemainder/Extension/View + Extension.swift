//
//  View + Extension.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 28/05/2024.
//

import Foundation
import SwiftUI

extension View {
    func makeCustomBackgroundView() -> some View {
            self
                .background(
                    LinearGradient(
                        colors: [.blue.opacity(0.2) , .pink.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .edgesIgnoringSafeArea(.all)
                )
        }
}
