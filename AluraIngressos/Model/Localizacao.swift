//
//  Localizacao.swift
//  AluraIngressos
//
//  Created by Gabriel de Castro Chaves on 16/05/22.
//

import UIKit

class Localizacao: NSObject {
    
    var logradouro = ""
    var bairro = ""
    var cidade = ""
    var uf = ""

    init(_ dicionario: Dictionary<String, String>) {
        
        logradouro = dicionario["logradouro"] ?? ""
        bairro = dicionario["bairro"] ?? ""
        cidade = dicionario["localidade"] ?? ""
        uf = dicionario["uf"] ?? ""
    }
    
    
}
