//
//  AccountAPI.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 03/02/24.
//

protocol AccountAPI {
    
    func getAccountById(accountId: String) -> Account?
    
    func addAccount(account: Account) 
    
    func updateAccount(account: Account)
    
}
