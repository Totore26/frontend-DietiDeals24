//
//  LoginViewModel.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 03/04/24.
//
import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorBanner: String = ""

}
