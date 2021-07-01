//
//  CategoryDetailView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 30.06.2021.
//

import SwiftUI

struct CategoryDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: CategoryDetailViewModel

    var body: some View {
        VStack {
            navBar
                .padding()
            
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    Text("\(viewModel.brands.count) tane bulundu")
                        .padding(.horizontal, 16)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(viewModel.brands, id: \.name) {
                            BrandCell(brand: $0)
                        }
                    }
                    .frame(maxWidth: geo.size.width)
                }
            }
            Spacer()
        }
        .navigationBarHidden(true)
        .modifier(
            PopUpHelper(
                    popUpView: DummyAlert(onDismiss: {
                        
                    }),
                    isPresented: viewModel.isLoading)
        )
    }
    
    var navBar: some View {
        CustomNavBar(
            left: {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image("back")
                }
            },
            center: {
                Text("who_are_we-title")
                    .font(.title)
                    .bold()
            },
            right: {
            })
    }
}

private struct BrandCell: View {
    let brand: Brand
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(brand.name ?? "")
                        .font(.customFont(size: 20, type: .fontBold))
                        .foregroundColor(Color(UIColor(red: 0.173, green: 0.243, blue: 0.314, alpha: 1)))
                    Text(brand.parentCompany ?? "")
                        .font(.customFont(size: 17))
                        .foregroundColor(Color(UIColor(red: 0.498, green: 0.549, blue: 0.553, alpha: 1)))
                }
                
                Spacer()
                
                Text(brand.point)
                    .frame(width: 50)
                    .padding(8)
                    .background(Color.red.cornerRadius(8))
            }
            .padding(16)
            
            Divider()
        }
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(viewModel: DiscoverDependencyContainer().makeCategoryDetailViewModel(categoryEnum: .hairDye))
    }
}
