//
//  ViewController.swift
//  AluraIngressos
//
//  Created by Gabriel de Castro Chaves on 12/05/22.
//

import UIKit
import UniformTypeIdentifiers


class ViewController: UIViewController, PickerViewMesSelecionadoDelegate, PickerViewAnoSelecionadoDelegate, PickerViewParcelasDelegate {
    
    
    
    var precoDoIngresso:Int = 199
    var pickerViewMes = PickerViewMes()
    var pickerViewAno = PickerViewAno()
    var pickerViewParcelas = PickerViewParcelas()
    
    //MARK: IBOutlets
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var scrollViewPrincipal: UIScrollView!
    @IBOutlet weak var numeroDeParcelasSelecionadoTextField: UITextField!
    @IBOutlet weak var numeroDeParcelasEscolhidoLabel: UILabel!
        
    //MARK: PickerViewDelegate
    func mesSelecionado(mes: String) {
        self.buscaTextField(tipoDeTextField: .mesDeVencimento) { textFieldSolicitado in
            textFieldSolicitado.text = mes
        }
    }
    
    func anoSelecionado(ano: String) {
        self.buscaTextField(tipoDeTextField: .anoDeVencimento) { textFieldSolicitado in
            textFieldSolicitado.text = ano
        }
    }
    
    func parcelaSelecionada(parcela: String) {
        self.buscaTextField(tipoDeTextField: .numeroDeParcelas) { textFieldSolicitado in
            textFieldSolicitado.text = parcela
            let calculoDaParcela = "\(precoDoIngresso/Int(parcela)!)x"
            self.numeroDeParcelasEscolhidoLabel.text = String(format: "%@x R$%@ (ou R$199,00 à vista", parcela, calculoDaParcela)
    }
    }
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bannerImage.layer.cornerRadius = 10
        self.bannerImage.layer.masksToBounds = true
        pickerViewMes.delegate = self
        pickerViewAno.delegate = self
        pickerViewParcelas.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(aumentarScrollView(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        
    
    
        
    //MARK: IBActions
    
    
   
    
    @IBAction func textFieldCodigoDeSeguranca(_ sender: UITextField) {
        
        guard let texto = sender.text else {return}
        if texto.count > 3 {
            let codigo = texto.suffix(3)
            self.buscaTextField(tipoDeTextField: .codigoDeSeguranca) { textFieldSolicitado in
                textFieldSolicitado.text = String(codigo)
            }
        } else {
            self.buscaTextField(tipoDeTextField: .codigoDeSeguranca) { textFieldCodigoDeSeguranca in
                textFieldCodigoDeSeguranca.text = texto
            }
        }
    }
    
    @IBAction func textFieldParcelasEntrouEmFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewParcelas
        pickerView.dataSource = pickerViewParcelas
        sender.inputView = pickerView
        
        
        
        
    }
    
    
    
    @IBAction func textFieldMesEntrouEmFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewMes
        pickerView.dataSource = pickerViewMes
        sender.inputView = pickerView
    }
    
    
    @IBAction func textFieldAnoEntrouEmFoco(_ sender: UITextField) {
        
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewAno
        pickerView.dataSource = pickerViewAno
        sender.inputView = pickerView
    }
    
    @IBAction func comprarButton(_ sender: UIButton) {
        
        let textFieldsEstaoValidos = ValidaFormulario().verificaTextFieldsValidos(listaDeTextFields: textFields)
        
        let textFieldsEstaoPreenchidos = ValidaFormulario().verificaTextFieldsPreenchidos(textFields)

        if textFieldsEstaoPreenchidos && textFieldsEstaoValidos {
            let alerta = ValidaFormulario().exibeNotificacaoPreenchimentoTextFields(titulo: "Parabéns", mensagem: "Compra realizada com sucesso")
            present(alerta, animated: true)
        } else {
            let alerta = ValidaFormulario().exibeNotificacaoPreenchimentoTextFields(titulo: "Erro", mensagem: "Preencha todos os campos corretamente")
            present(alerta, animated: true)
        }
    }
    
    
    @IBAction func textFieldCepAlterouValor(_ sender: UITextField) {
        guard let cep = sender.text else {return}
        LocalizacaoConsultaAPI().consultaViaCepAPI(cep: cep, sucesso: { (localizacao) in
            self.buscaTextField(tipoDeTextField: .endereco, completion: { (textFieldEndereco) in
                textFieldEndereco.text = localizacao.logradouro
            })
            self.buscaTextField(tipoDeTextField: .bairro, completion: { (textFieldBairro) in
                textFieldBairro.text = localizacao.bairro
            })

        }) { (error) in
            print(error)
        }
    }
    
    //MARK: Metodos
    
    
    func buscaTextField(tipoDeTextField:ValidaFormulario.TiposDeTextField, completion:(_ textFieldSolicitado:UITextField) -> Void) {
        for textField in textFields {
            if let textFieldAtual = ValidaFormulario.TiposDeTextField(rawValue: textField.tag) {
                if textFieldAtual == tipoDeTextField {
                    completion(textField)
                }
            }
        }
    }
    
    @objc func aumentarScrollView(notification: Notification) {
        self.scrollViewPrincipal.contentSize = CGSize(width: self.scrollViewPrincipal.frame.width, height: scrollViewPrincipal.frame.height + 450)
    }
    
    
   
    
    
}
