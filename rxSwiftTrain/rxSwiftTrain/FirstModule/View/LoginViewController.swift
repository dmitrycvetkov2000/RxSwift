//
//  ViewController.swift
//  rxSwiftTrain
//
//  Created by Дмитрий Цветков on 28.08.2023.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    var textFieldLogin = UITextField()
    var textFieldPassword = UITextField()
    var button = UIButton()
    var label = UILabel()
    
    var viewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
}

extension LoginViewController {
    func bind() {
        textFieldLogin.rx.text.bind(to: viewModel.loginStr).disposed(by: viewModel.bag)
        textFieldPassword.rx.text.bind(to: viewModel.passwordStr).disposed(by: viewModel.bag)
        
        viewModel.isValidForms.bind(to: button.rx.isEnabled).disposed(by: viewModel.bag)
        
        viewModel.isValidForms.subscribe { valid in
            if valid {
                self.button.backgroundColor = .green
            } else {
                self.button.backgroundColor = .clear
            }
        }.disposed(by: viewModel.bag)
        
        button.rx.tap.asDriver().drive { event in
            if self.textFieldLogin.text == User.logins[0].login && self.textFieldPassword.text == User.logins[0].password {
                self.navigationController?.pushViewController(SecondVC(), animated: true)
            } else {
                self.present(self.createAlert(), animated: true)
            }
        }.disposed(by: viewModel.bag)
    }
    
    func createAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Не удалось выполнить вход", message: "Вы ввели неправильный email или пароль", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .cancel)
        alert.addAction(action)
        return alert
    }
    
    func configureView() {
        createLoginTextField()
        createPasswordTextField()
        createButton()
        createLabel()
        view.backgroundColor = .blue
    }
}

// MARK: - createViews
extension LoginViewController {
    func createLoginTextField() {
        textFieldLogin.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textFieldLogin)
        
        NSLayoutConstraint.activate([
            textFieldLogin.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            textFieldLogin.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            textFieldLogin.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            textFieldLogin.heightAnchor.constraint(equalToConstant: 46)
        ])
        
        textFieldLogin.placeholder = "Login"
        textFieldLogin.borderStyle = .roundedRect
        textFieldLogin.autocorrectionType = .no
        textFieldLogin.autocapitalizationType = .none
    }
    
    func createPasswordTextField() {
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textFieldPassword)
        
        NSLayoutConstraint.activate([
            textFieldPassword.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            textFieldPassword.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            textFieldPassword.topAnchor.constraint(equalTo: textFieldLogin.bottomAnchor, constant: 20),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 46)
        ])
        
        textFieldPassword.placeholder = "Password"
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.autocorrectionType = .no
        textFieldPassword.autocapitalizationType = .none
    }
    
    func createButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            button.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 20),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
        button.isEnabled = false
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .disabled)
        button.setTitle("Вход", for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 14
    }
    
    func createLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 46)
        ])
        
        label.textAlignment = .center
    }
}

