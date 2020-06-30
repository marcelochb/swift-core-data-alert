//
//  VinhoTableViewController.swift
//  DemoArtigo
//
//  Created by Guilherme Paciulli on 25/07/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreData

class VinhoTableViewController: UITableViewController {
    
    var grape: Uva?
    
    var vinhos: [Vinho] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = false
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addWine))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadWineData()
    }
    
	@objc func addWine() {
        
        let firstAlert = UIAlertController(title: "Adicionar vinho",
                                           message: "Nome do vinho",
                                           preferredStyle: .alert)
        
        let firstAlertCancelButton = UIAlertAction(title: "Cancelar",
                                                   style: .default)
        
        let firstAlertNextButton = UIAlertAction(title: "Próximo", style: .default) { [unowned self] action in
            
            let secondAlert = UIAlertController(title: "Adicionar vinho",
                                                message: "País de origem",
                                                preferredStyle: .alert)
            
            let secondAlertCancelButton = UIAlertAction(title: "Cancelar",
                                                        style: .default)
            
            let secondAlertNextButton = UIAlertAction(title: "Próximo", style: .default) { [unowned self] action in
                
                let thirdAlert = UIAlertController(title: "Adicionar vinho",
                                                   message: "Vinícola",
                                                   preferredStyle: .alert)
                
                let thirdAlertCancelButton = UIAlertAction(title: "Cancelar",
                                                           style: .default)
                
                let thirdAlertFinishButton = UIAlertAction(title: "Terminar", style: .default) { [unowned self] action in
                    
                    if let wineName = firstAlert.textFields?.first?.text {
                        if let wineCountry = secondAlert.textFields?.first?.text {
                            if let winery = thirdAlert.textFields?.first?.text {
                                if let wine = NSEntityDescription.insertNewObject(forEntityName: "Vinho", into: DatabaseController.persistentContainer.viewContext) as? Vinho {
                                    wine.nome = wineName
                                    wine.pais = wineCountry
                                    wine.vinicola = winery
                                    self.grape?.addToVinhos(wine)
                                    DatabaseController.saveContext()
                                    self.reloadWineData()
                                }
                            }
                        }
                    }
                    
                }
                thirdAlert.addAction(thirdAlertCancelButton)
                thirdAlert.addAction(thirdAlertFinishButton)
                thirdAlert.addTextField()
                
                self.present(thirdAlert, animated: true)
            }
            
            secondAlert.addAction(secondAlertCancelButton)
            secondAlert.addAction(secondAlertNextButton)
            secondAlert.addTextField()
            
            self.present(secondAlert, animated: true)
        }
        
        firstAlert.addTextField()
        firstAlert.addAction(firstAlertCancelButton)
        firstAlert.addAction(firstAlertNextButton)
        
        self.present(firstAlert, animated: true)
        
    }
    
    @IBAction func editGrape() {
        let firstAlert = UIAlertController(title: "Editar uva",
                                           message: "Nome da uva",
                                           preferredStyle: .alert)
        
        let firstAlertCancelButton = UIAlertAction(title: "Cancelar",
                                                   style: .default)
        
        let firstAlertNextButton = UIAlertAction(title: "Próximo", style: .default) { [unowned self] action in
            
            let secondAlert = UIAlertController(title: "Editar uva",
                                                message: "Tipo da uva",
                                                preferredStyle: .alert)
            
            let secondAlertCancelButton = UIAlertAction(title: "Cancelar",
                                                        style: .default)
            
            let secondAlertFinishButton = UIAlertAction(title: "Terminar", style: .default) { [unowned self] action in
                
                
                if let grapeName = firstAlert.textFields?.first?.text {
                    if let grapeType = secondAlert.textFields?.first?.text {
                        //Só mudou isso:
                        self.grape?.nome = grapeName
                        self.grape?.tipo = grapeType
                        DatabaseController.saveContext()
                    }
                }
                
                
            }
            
            secondAlert.addAction(secondAlertCancelButton)
            secondAlert.addAction(secondAlertFinishButton)
            secondAlert.addTextField()
            
            self.present(secondAlert, animated: true)
        }
        
        firstAlert.addTextField()
        firstAlert.addAction(firstAlertCancelButton)
        firstAlert.addAction(firstAlertNextButton)
        
        self.present(firstAlert, animated: true)
    }
    
    @IBAction func removeWine(_ sender: Any) {
        self.tableView.setEditing(true, animated: true)
    }
    func reloadWineData() {
        if let vinhos = grape?.vinhos {
            self.vinhos.removeAll()
            self.vinhos = vinhos.map({ $0 as! Vinho })
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vinhos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let wine = vinhos[indexPath.row]
        
        cell.textLabel?.text = wine.nome
        cell.detailTextLabel?.text = wine.pais
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            self.vinhos.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            if let vinho = self.grape?.vinhos?.allObjects[indexPath.row] as? Vinho{
//                self.grape?.removeFromVinhos(vinho)
//                DatabaseController.persistentContainer.viewContext.delete(vinho)
//            }
//            DatabaseController.saveContext()
//            self.reloadWineData()
//        }
//    }
    
}
