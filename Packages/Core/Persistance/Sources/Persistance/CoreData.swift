//
//  CoreData.swift
//  Persistance
//
//  Created by Iacob Zanoci on 24.05.2025.
//

import CoreData

public class CoreDataManager {
    
    // MARK: - Properties
    
    @MainActor public static let shared = CoreDataManager()
    public let container: NSPersistentContainer
    public var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    // MARK: - Initializer
    
    public init(inMemory: Bool = false) {
        guard let modelURL = Bundle.module.url(forResource: "Model", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to locate or load Core Data model")
        }
        
        container = NSPersistentContainer(name: "Model", managedObjectModel: model)
        
        if inMemory {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
        }
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data store failed: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Save Context
    
    public func saveContext() throws {
        if context.hasChanges {
            try context.save()
        }
    }
    
    // MARK: - Create Context
    
    public func create<T: NSManagedObject>(type: T.Type) -> T {
        let entityName = String(describing: type)
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! T
    }
    
    // MARK: - Fetch Context
    
    public func fetch<T: NSManagedObject>(
        type: T.Type,
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil
    ) throws -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return try context.fetch(request)
    }
    
    // MARK: - Delete Context
    
    public func delete(_ object: NSManagedObject) {
        context.delete(object)
    }
}
