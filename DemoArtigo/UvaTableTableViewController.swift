//
//  UvaTableTableViewController.swift
//  DemoArtigo
//
//  Created by Guilherme Paciulli on 25/07/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreData

class UvaTableTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @IBAction func createGrape(_ sender: Any) {
        
        //Criamos o primeiro alerta
        let firstAlert = UIAlertController(title: "Nova uva",
                                           message: "Nome da uva",
                                           preferredStyle: .alert)
        
        //Criamos o botão de cancelar do primeiro alerta
        let firstAlertCancelButton = UIAlertAction(title: "Cancelar",
                                                   style: .default)
        //Criamos o botão de avançar do primeiro alerta
        let firstAlertNextButton = UIAlertAction(title: "Próximo", style: .default) { [unowned self] action in
            
            //Criamos o segundo alerta
            let secondAlert = UIAlertController(title: "Nova uva",
                                                message: "Tipo da uva",
                                                preferredStyle: .alert)
            
            //Criamos o botão de cancelar do segundo alerta
            let secondAlertCancelButton = UIAlertAction(title: "Cancelar",
                                                        style: .default)
            
            //Criamos o botão de terminar do segundo alerta
            let secondAlertFinishButton = UIAlertAction(title: "Terminar", style: .default) { [unowned self] action in
                
                
                //Aqui capturamos os valores inseridos
                if let grapeName = firstAlert.textFields?.first?.text {
                    if let grapeType = secondAlert.textFields?.first?.text {
                        
                        if let grape = NSEntityDescription.insertNewObject(forEntityName: "Uva", into: DatabaseController.persistentContainer.viewContext) as? Uva {
                            grape.nome = grapeName
                            grape.tipo = grapeType
                            DatabaseController.saveContext()
                            self.reloadGrapeData()
                        }
                        
                        
                    }
                }
                
                
            }
            
            //Adicionamos os botões e o TextField do segundo alerta
            secondAlert.addAction(secondAlertCancelButton)
            secondAlert.addAction(secondAlertFinishButton)
            secondAlert.addTextField()
            
            //Apresentamos o segundo alerta
            self.present(secondAlert, animated: true)
        }
        
        //Adicionamos os botões e o TextField do primeiro alerta
        firstAlert.addTextField()
        firstAlert.addAction(firstAlertCancelButton)
        firstAlert.addAction(firstAlertNextButton)
        
        //Apresentamos o primeiro alerta
        self.present(firstAlert, animated: true)
        
    }
    
    var grapes: [Uva] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadGrapeData()
    }
    
    func reloadGrapeData() {
        do {
            if let grapes = try DatabaseController.persistentContainer.viewContext.fetch(Uva.fetchRequest()) as? [Uva] {
                self.grapes = grapes
            }
        } catch {
            print("Erro no banco, não conseguiu realizar a busca")
        }
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //Só teremos uma seção
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Queremos quantas células tem na lista das uvas
        return grapes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Vamos usar a célula padrão mesmo
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let grape = grapes[indexPath.row] //Qual uva você está falando
        
        cell.textLabel?.text = grape.nome //Título colocamos como o nome da uva
        cell.detailTextLabel?.text = grape.tipo //Subtítulo colocamos como o tipo da uva
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let grapeToBeDeleted = grapes[indexPath.row]
            self.grapes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            DatabaseController.persistentContainer.viewContext.delete(grapeToBeDeleted)
            DatabaseController.saveContext()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //O sender nada mais é a célula que ele clicou:
        if let chosenCell = sender as? UITableViewCell {
            //Sabemos a célula sabemos o índice da célula:
            if let indexPath = self.tableView.indexPath(for: chosenCell) {
                //O destino dessa Segue nada mais é que a Lista de Vinhos:
                if let vinhoTableView = segue.destination as? VinhoTableViewController {
                    //Sabendo o índice da célula clicada sabemos a uva:
                    vinhoTableView.grape = grapes[indexPath.row]
                }
            }
        }
        
    }
    
}
