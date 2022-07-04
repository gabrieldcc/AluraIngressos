//
//  PickerViewParcelas.swift
//  AluraIngressos
//
//  Created by Gabriel de Castro Chaves on 25/05/22.
//

import UIKit

protocol PickerViewParcelasDelegate {
    func parcelaSelecionada(parcela: String )
}

class PickerViewParcelas: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
   
    var delegate: PickerViewParcelasDelegate?
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row+1)x"

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            delegate?.parcelaSelecionada(parcela: "\(row+1)")
            
            
            
            
        }
    }
    
    
    
}
