import Foundation

extension MVitaXmlItem
{
    //MARK: internal
    
    class func factoyItem(
        directory:DVitaIdentifier) -> Data?
    {
        guard
            
            let pngs:[DVitaItemElementPng] = directory.png?.array as? [
                DVitaItemElementPng],
            let thumbnail:DVitaItemElement = findSmallerImage(
                pngs:pngs),
            let data:Data = MVitaLink.elementData(
                element:thumbnail)
            
            else
        {
            return nil
        }
        
        return data
    }
}
