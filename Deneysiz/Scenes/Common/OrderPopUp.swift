//
//  OrderPopUp.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 7.12.2021.
//

import SwiftUI

struct OrderPopUp: View, Alertable {
    var onDismiss: (() -> Void)?
    var onUpdate: ((OrderConfig) -> Void)

    @State var selected: OrderConfig
    private let orderTypes: [OrderConfig] = [
        .point(.asc),
        .point(.desc),
        .name(.asc),
        .name(.desc)
    ]
    
    init(_ current: OrderConfig, onUpdate: @escaping ((OrderConfig) -> Void), onDismiss: (() -> Void)?) {
        self.onUpdate = onUpdate
        _selected = State(initialValue: current)
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                
                ZStack {
                    Image("orderpopup")
                        .frame(width: 96, height: 96)
                }
                .offset(y: -(96 / 2))
                .zIndex(1.0)
                
                VStack(spacing: 0) {
                    Text("brand-detail-order-title")
                        .multilineTextAlignment(.center)
                        .font(.customFont(size: 20, type: .fontBold))
                        .foregroundColor(.deneysizTextColor)
                        .padding(.top, 56)
                    
                    ForEach(orderTypes) { detail in
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: self.selected == detail ? "largecircle.fill.circle" : "circle")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(self.selected == detail ? .orderFilterTextColor : .deneysizText2Color)
              
                                Text(detail.title)
                                    .font(.customFont(size: 17))
                                    .foregroundColor(.deneysizTextColor)
                                Spacer()
                            }
                            
                            Divider()
                        }
                        .padding(.top, 10)
                        .onTapGesture {
                            self.selected = detail
                        }
                    }
                    
                    Button(
                        action: {
                            onUpdate(selected)
                            onDismiss?()
                        },
                        label: {
                        Text("apply")
                            .foregroundColor(.white)
                            .padding()
                            .frame(height: 42)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color.deneysizOrange
                                    .cornerRadius(8)
                            )
                    })
                        .padding(.top, 20)
                        .padding(.bottom, 24)

                }
                .padding(.horizontal, 24)
                .frame(width: geo.size.width - 96)
                .background(Color.white.cornerRadius(12))
            }
            .frame(width: geo.size.width,
                   height: geo.size.height,
                   alignment: .center)
        }
        
    }
}

struct OrderPopUp_Previews: PreviewProvider {
    static var previews: some View {
        OrderPopUp(.point(.asc), onUpdate: { _ in
            
        }, onDismiss: nil)
    }
}
