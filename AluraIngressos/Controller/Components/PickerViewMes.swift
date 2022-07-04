//
//  PickerViewMes.swift
//  AluraIngressos
//
//  Created by Gabriel de Castro Chaves on 24/05/22.
//

import UIKit

protocol PickerViewMesSelecionadoDelegate {
    func mesSelecionado(mes: String)
}

class PickerViewMes: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate: PickerViewMesSelecionadoDelegate?
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            delegate?.mesSelecionado(mes: "\(row+1)")
        }
    }
}
