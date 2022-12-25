//
//  FilterView.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 12.12.2022.
//

import SwiftUI

struct FilterView: View {
    
    var onDismiss: (() -> Void)?
    var onUpdate: ((FilterModel) -> Void)
    
    @State var filterModel: FilterModel
    @State private var viewId = 0

    init(_ current: FilterModel, onUpdate: @escaping ((FilterModel) -> Void), onDismiss: (() -> Void)?) {
        self.onUpdate = onUpdate
        _filterModel = State(initialValue: current)
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Button(
                    action: {
                        filterModel = FilterModel()
                        // Give viewId to views and increase that id to replace current view with a new one
                        viewId += 1
                    },
                    label: {
                        Text("Sıfırla")
                            .font(.customFont(size: 17))
                            .foregroundColor(
                                Color.deneysizOrange
                            )
                    })
                Spacer()
                
                Text("Filtre")
                    .font(.customFont(size: 17, type: .fontSemiBold))
                    .foregroundColor(.deneysizTextColor)
                
                Spacer()

                Button(
                    action: {
                        onUpdate(filterModel)
                        onDismiss?()
                    },
                    label: {
                        Text("Kapat")
                            .font(.customFont(size: 17))
                            .foregroundColor(
                                Color.deneysizOrange
                            )
                    })
            }
            .padding(.vertical)
            
            VStack(alignment: .leading) {
                Text("Lorem")
                    .font(.customFont(size: 20, type: .fontBold))
                    .foregroundColor(.deneysizTextColor)
                Text("Deutsches Ipsum Dolor quoc Freude schöner")
                    .font(.customFont(size: 14, type: .fontRegular))
                    .foregroundColor(.deneysizTextColor)
            }
            .padding()
            
            CheckboxSelections
                .id(viewId)
            
            VStack(alignment: .leading) {
                Text("Sertifikalar")
                    .font(.customFont(size: 20, type: .fontBold))
                    .foregroundColor(.deneysizTextColor)
                Text("Deutsches Ipsum Dolor quo lucilius Freude schöner")
                    .font(.customFont(size: 14, type: .fontRegular))
                    .foregroundColor(.deneysizTextColor)
            }
            .padding()
            
            Certificates
                .id(viewId)

            Spacer()
        }
        .padding(.horizontal)
    }
    
    private var CheckboxSelections: some View {
        VStack {
            ChoiceCheckboxView(isSelected: filterModel.isVegan, title: "Vegan ürün") { isSelected in
                filterModel.isVegan = isSelected
            }
            ChoiceCheckboxView(isSelected: filterModel.isOfferInChina, title: "Çin’de satış yapmayanlar") { isSelected in
                filterModel.isOfferInChina = isSelected
            }
            ChoiceCheckboxView(isSelected: filterModel.isParentSafe, title: "Çatı markası deneysiz olanlar") { isSelected in
                filterModel.isParentSafe = isSelected
            }
        }
    }
    
    private var Certificates: some View {
        HStack(alignment: .center, spacing: 12) {
            FilterCertificateView(isSelected: filterModel.leapingBunnyCert, cert: .leapingBunnyCert) { isSelected in
                filterModel.leapingBunnyCert = isSelected
            }
            FilterCertificateView(isSelected: filterModel.vlabelCert, cert: .vlabelCert) { isSelected in
                filterModel.vlabelCert = isSelected
            }
            FilterCertificateView(isSelected: filterModel.beautyWithoutBunniesCert, cert: .beautyWithoutBunniesCert) { isSelected in
                filterModel.beautyWithoutBunniesCert = isSelected
            }
            FilterCertificateView(isSelected: filterModel.veganSocietyCert, cert: .veganSocietyCert) { isSelected in
                filterModel.veganSocietyCert = isSelected
            }
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(FilterModel.init(), onUpdate: { _ in
            
        }, onDismiss: nil)
    }
}
