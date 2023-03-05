//
//  ClockView.swift
//  Tomatoro
//
//  Created by Łukasz Stachnik on 03/03/2023.
//

import SwiftUI

struct ClockView: View {
    @Binding var remainingSeconds: Int

    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .overlay {
                    Text("\(String(format: "%02d", remainingSeconds / 60))")
                        .fontDesign(.monospaced)
                        .font(.system(size: 72))
                        .foregroundColor(.primary)
                }
                .frame(width: 100, height: 100)
                .foregroundColor(.secondary)

            RoundedRectangle(cornerRadius: 10)
                .overlay {
                    Text("\(String(format: "%02d", remainingSeconds % 60))")
                        .fontDesign(.monospaced)
                        .font(.system(size: 72))
                        .foregroundColor(.primary)
                }
                .frame(width: 100, height: 100)
                .foregroundColor(.secondary)
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(remainingSeconds: .constant(59))
    }
}
