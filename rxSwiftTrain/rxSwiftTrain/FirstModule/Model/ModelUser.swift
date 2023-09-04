//
//  ModelUser.swift
//  rxSwiftTrain
//
//  Created by Дмитрий Цветков on 28.08.2023.
//

import Foundation

struct User {
    let login: String?
    let password: String?
}

extension User {
    static var logins = [User(login: "test@mail.ru", password: "12345")]
}
