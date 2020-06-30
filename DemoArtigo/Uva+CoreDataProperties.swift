//
//  Uva+CoreDataProperties.swift
//  DemoArtigo
//
//  Created by Guilherme Paciulli on 26/07/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import CoreData


extension Uva {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Uva> {
        return NSFetchRequest<Uva>(entityName: "Uva")
    }

    @NSManaged public var nome: String?
    @NSManaged public var tipo: String?
    @NSManaged public var vinhos: NSSet?

}

// MARK: Generated accessors for vinhos
extension Uva {

    @objc(addVinhosObject:)
    @NSManaged public func addToVinhos(_ value: Vinho)

    @objc(removeVinhosObject:)
    @NSManaged public func removeFromVinhos(_ value: Vinho)

    @objc(addVinhos:)
    @NSManaged public func addToVinhos(_ values: NSSet)

    @objc(removeVinhos:)
    @NSManaged public func removeFromVinhos(_ values: NSSet)

}
