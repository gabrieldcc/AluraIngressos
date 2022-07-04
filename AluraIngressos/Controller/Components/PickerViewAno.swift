//
//  PickerViewAno.swift
//  AluraIngressos
//
//  Created by Gabriel de Castro Chaves on 24/05/22.
//

import UIKit

protocol PickerViewAnoSelecionadoDelegate {
    func anoSelecionado(ano: String )
}

class PickerViewAno: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var delegate: PickerViewAnoSelecionadoDelegate?
    
    let anosValidadeCartao = ["2022", "2023", "2024", "2025", "2026", "2027"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return anosValidadeCartao.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return anosValidadeCartao[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            delegate?.anoSelecionado(ano: anosValidadeCartao[row])
        }
    }
}
