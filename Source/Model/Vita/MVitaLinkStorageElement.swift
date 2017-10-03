import Foundation

extension MVitaLink
{
    private typealias Router = ((MVitaItemInElement,
        DVitaItemDirectory,
        Database,
        DispatchGroup) -> ())
    private static let kRouterMap:[
        MVitaItemInExtension:Router] = [
            MVitaItemInExtension.png:createElementPng,
            MVitaItemInExtension.sfo:createElementSfo,
            MVitaItemInExtension.sav:createElementGeneric,
            MVitaItemInExtension.unknown:createElementGeneric]
    
    //MARK: private
    
    private class func routerForExtension(
        fileExtension:MVitaItemInExtension) -> Router
    {
        guard
        
            let router:Router = kRouterMap[fileExtension]
        
        else
        {
            return createElementGeneric
        }
        
        return router
    }
    
    private class func storeElement(
        vitaItem:MVitaItemInElement,
        directoryPath:URL) throws
    {
        guard
            
            let data:Data = vitaItem.data
            
        else
        {
            let error:MError = MError.factoryDataNotFound()
            
            throw error
        }
        
        do
        {
            try storeElement(
                localName:vitaItem.localName,
                directoryPath:directoryPath,
                data:data)
        }
        catch
        {
            return
        }
    }
    
    private class func createElementGeneric(
        vitaItem:MVitaItemInElement,
        directory:DVitaItemDirectory,
        database:Database,
        dispatchGroup:DispatchGroup)
    {
        database.create
        { (element:DVitaItemElement) in
            
            element.directory = directory
            element.config(
                itemElement:vitaItem)
            
            dispatchGroup.leave()
        }
    }
    
    private class func createElementSfo(
        vitaItem:MVitaItemInElement,
        directory:DVitaItemDirectory,
        database:Database,
        dispatchGroup:DispatchGroup)
    {
        database.create
        { (element:DVitaItemElementSfo) in
            
            element.directorySfo = directory
            element.directory = directory
            element.config(
                itemElement:vitaItem)
            
            dispatchGroup.leave()
        }
    }
    
    private class func createElementPng(
        vitaItem:MVitaItemInElement,
        directory:DVitaItemDirectory,
        database:Database,
        dispatchGroup:DispatchGroup)
    {
        database.create
        { (element:DVitaItemElementPng) in
            
            element.directoryPng = directory
            element.directory = directory
            element.config(
                itemElement:vitaItem)
            
            dispatchGroup.leave()
        }
    }
    
    //MARK: internal
    
    class func createElement(
        vitaItem:MVitaItemInElement,
        directory:DVitaItemDirectory,
        directoryPath:URL,
        database:Database,
        dispatchGroup:DispatchGroup)
    {
        do
        {
            try storeElement(
                    vitaItem:vitaItem,
                    directoryPath:directoryPath)
        }
        catch
        {
            return
        }
        
        let router:Router = routerForExtension(
            fileExtension:vitaItem.fileExtension)
        
        dispatchGroup.enter()
        
        router(
            vitaItem,
            directory,
            database,
            dispatchGroup)
    }
}
