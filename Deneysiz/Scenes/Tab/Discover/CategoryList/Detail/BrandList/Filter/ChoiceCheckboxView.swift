//
//  ChoiceCheckboxView.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 24.12.2022.
//

import SwiftUI

struct ChoiceCheckboxView: View {
    
    @State var isSelected: Bool
    let title: String
    let action: ((_ isSelected: Bool) -> Void)?
    
    var body: some View {
        Button {
            self.isSelected.toggle()

            action?(isSelected)
        } label: {
            HStack {
                Text(title)
                    .font(.customFont(size: 17))
                    .foregroundColor(.deneysizTextColor)
                
                Spacer()
                Image(self.isSelected ? "checkboxSelected" : "checkboxUnselected")
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 21)
            .background(
                Color.white
            )
        }
    }
}

struct ChoiceCheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceCheckboxView(isSelected: false, title: "", action: nil)
    }
}
