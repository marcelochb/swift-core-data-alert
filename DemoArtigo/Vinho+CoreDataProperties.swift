//
//  Vinho+CoreDataProperties.swift
//  DemoArtigo
//
//  Created by Guilherme Paciulli on 26/07/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import CoreData


extension Vinho {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vinho> {
        return NSFetchRequest<Vinho>(entityName: "Vinho")
    }

    @NSManaged public var nome: String?
    @NSManaged public var pais: String?
    @NSManaged public var vinicola: String?

}
