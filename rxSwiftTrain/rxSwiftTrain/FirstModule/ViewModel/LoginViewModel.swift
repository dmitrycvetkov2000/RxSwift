//
//  LoginViewModel.swift
//  rxSwiftTrain
//
//  Created by Дмитрий Цветков on 28.08.2023.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    let bag = DisposeBag()
    var loginStr = PublishSubject<String?>()
    var passwordStr = PublishSubject<String?>()
    
    var isValidForms: Observable<Bool> {
        return PublishSubject.combineLatest(loginStr, passwordStr) {login, password in
            guard let login = login, let password = password else { return false }
            
            return login.isEmail() && !password.isEmpty
        }
    }
}
