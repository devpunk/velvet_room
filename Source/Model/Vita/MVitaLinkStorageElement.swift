import Foundation

extension MVitaLink
{
    //MARK: private
    
    private class func storeElement(
        vitaItem:MVitaItemInElement,
        directoryPath:URL) throws
    {
        guard
            
            let data:Data = vitaItem.data
            
        else
        {
            throw LocalizedError.init(
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
    
    //MARK: internal
    
    class func createElement(
        vitaItem:MVitaItemInElement,
        directory:DVitaItemDirectory,
        directoryPath:URL,
        database:Database,
        dispatchGroup:DispatchGroup)
    {
        
        
        dispatchGroup.enter()
        
        database.create
            { (element:DVitaItemElement) in
                
                element.directory = directory
                element.config(
                    itemElement:vitaItem)
                
                dispatchGroup.leave()
        }
    }
}
