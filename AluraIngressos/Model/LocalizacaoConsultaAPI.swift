//
//  LocalizacaoConsultaAPI.swift
//  AluraIngressos
//
//  Created by Gabriel de Castro Chaves on 16/05/22.
//

import UIKit
import Alamofire

class LocalizacaoConsultaAPI: NSObject {
    
    func consultaViaCepAPI(cep:String, sucesso:@escaping(_ localizacao:Localizacao) -> Void, falha:@escaping(_ error:Error) -> Void) {
        AF.request("https://viacep.com.br/ws/\(cep)/json/").responseJSON { (response) in
            switch response.result {
            case .success:
                if let resultado = response.value as? Dictionary<String, String> {
                    sucesso(Localizacao(resultado))
                }
            case .failure:
                falha(response.error!)
            }
        }
    }
}

