//
//  ValidaFormulario.swift
//  AluraIngressos
//
//  Created by Gabriel de Castro Chaves on 13/05/22.
//

import UIKit
import CPF_CNPJ_Validator
import CreditCardValidator


 class ValidaFormulario: NSObject {
    
    enum TiposDeTextField: Int {
    case nomeCompleto = 1
    case email = 2
    case cpf = 3
    case cep = 4
    case endereco = 5
    case bairro = 6
    case numeroDoCartao = 7
    case mesDeVencimento = 8
    case anoDeVencimento = 9
    case codigoDeSeguranca = 10
    case numeroDeParcelas = 11
    }
    
    
    func verificaTextFieldsPreenchidos(_ textFields: [UITextField]) -> Bool{
        for textField in textFields {
            if textField.text == ""{
                return false
            }
            }
        return true
        }
    
    func exibeNotificacaoPreenchimentoTextFields(titulo: String, mensagem: String) -> UIAlertController {
    
        let notificacao = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        notificacao.addAction(okButton)
        
        return notificacao
    }
    
    
    func verificaTextFieldsValidos(listaDeTextFields: [UITextField]) -> Bool {
        var dicionarioDeTextFields: Dictionary<TiposDeTextField, UITextField> = [:]
        
        for textField in listaDeTextFields {
            if let tiposDeTextField = TiposDeTextField(rawValue: textField.tag) {
                dicionarioDeTextFields[tiposDeTextField] = textField
            }
        }
        guard let cpf = dicionarioDeTextFields[.cpf], BooleanValidator().validate(cpf: cpf.text!) else {return false}
        guard let email = dicionarioDeTextFields[.email], self.verificaEmail(email: email.text!) else {return false}
        guard let numeroDoCartao = dicionarioDeTextFields[.numeroDoCartao], CreditCardValidator(numeroDoCartao.text!).isValid else {return false}
            
            return true
        }
    
        func verificaEmail(email:String) -> Bool {
            let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

            let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)

            return emailTest.evaluate(with: email)
        }
    }
    


