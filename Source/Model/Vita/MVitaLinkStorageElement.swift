import Foundation

extension MVitaLink
{
    //MARK: private
    
    private class func factoryElementStoringRouter() -> [
        MVitaItemInExtension:
        ((MVitaItemInElement,
        DVitaItemDirectory,
        Database,
        DispatchGroup) -> ())]
    {
        let map:[MVitaItemInExtension:((MVitaItemInElement,
            DVitaItemDirectory,
            Database,
            DispatchGroup)->())] = [
                MVitaItemInExtension.png:createElementPng,
                MVitaItemInExtension.sfo:createElementSfo,
                MVitaItemInExtension.sav:createElementGeneric,
                MVitaItemInExtension.unknown:createElementGeneric]
        
        return map
    }
    
    private class func routerForExtension() -> 
    
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
            { (element:DVitaItemElement) in
                
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
            { (element:DVitaItemElement) in
                
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
        
        
        
        
        
        dispatchGroup.enter()
        createElement(
            vitaItem:vitaItem,
            directory:directoryPath,
            database:database,
            dispatchGroup:dispatchGroup)
    }
}
