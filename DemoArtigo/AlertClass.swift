//
//  AlertClass.swift
//  DemoArtigo
//
//  Created by Marcelo Block Teixeira on 29/06/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class AlertClass {
    
    func configAlert(firstTextInput: String, secondTextInput: String, thirdTextInput: String) -> UIAlertController {
        let Alert = UIAlertController(title: "Adicionar vinho",
        message: "Nome do vinho",
        preferredStyle: .alert)
        
        let AlertCancelButton = NextAction(title: "Cancelar")
        let AlertNextButton = NextAction(title: "Proximo")
        
        Alert.addTextField()
            Alert.addAction(AlertCancelButton)
            Alert.addAction(AlertNextButton)
            
            self.present(Alert, animated: true)
        
        return Alert
    }
    
    func NextAction (title: String) -> UIAlertAction {
        var AlertAction: UIAlertAction?
        if (title == "Cancelar") {
            AlertAction = UIAlertAction(title: title,
            style: .default)
        }
        if (title == "Proximo") {
            AlertAction = UIAlertAction(title: "Terminar", style: .default) { [unowned self] action in
                
                
            }
        }
        
        return AlertAction!
        
    }
}
