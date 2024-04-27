//
//  ComunicationProtocol.swift
//  DietiDeals24
//
//  Created by Francesco Terrecuso on 26/04/24.
//

import Foundation


protocol ProfileUpdateDelegate: AnyObject {
    func didUpdateProfile(_ updatedAccount: Account)
}
