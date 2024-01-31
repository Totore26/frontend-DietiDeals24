//
//  CategoryView.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 10/12/23.
//

import SwiftUI

struct CategoryView: View {
    
    var body: some View {
        NavigationView {
            
            ZStack {
                //SFONDO
                Image("png-sfondo")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .rotationEffect(.degrees(-180))
                    .frame(width: 680, height: 875)
                
                VStack {
                    
                    Spacer()
                    
                    //lista delle categorie
                    //quando clicca su una tipologia crea un oggetto home dove reindirizza
                    //le aste di quella categoria.

                    List {
                        Section {
                            NavigationLink(destination: self) {
                                categoryItem( title: "tecnology")
                            }
                        }.padding(.bottom, -7)
                        
                        Section {
                            NavigationLink(destination: self) {
                                categoryItem( title: "Sport & FreeTime")
                            }
                        }.padding(.bottom, -7)
                        
                        Section {
                            NavigationLink(destination: self) {
                                categoryItem( title: "Home and garden")
                            }
                        }.padding(.bottom, -7)
                        
                        Section {
                            NavigationLink(destination: self) {
                                categoryItem( title: "Vehicle")
                            }
                        }.padding(.bottom, -7)

                        Section {
                            NavigationLink(destination: self) {
                                categoryItem( title: "Service")
                            }
                        }.padding(.bottom, -7)
                        
                        Section {
                            NavigationLink(destination: self) {
                                categoryItem( title: "Other")
                            }
                        }.padding(.bottom, -7)

                    }
                    .frame(width: 350)
                    .listRowSpacing(7)
                    .listStyle(PlainListStyle())
                    .cornerRadius(10)
                    .padding(.top, 20)
                }
                .padding(.top, 150)

                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                    }
                    
                }
                .padding(.top, 40)
            }
        }
    }

}

struct categoryItem : View{
    var title: String

    var body: some View {
            HStack {
                Text(title)
                    .font(Font.custom("SF Pro", size: 17))
                    .lineSpacing(22)
                    .foregroundColor(.black)
            }
        .padding(.bottom, 10)
    }
}



#Preview {
    CategoryView()
}
