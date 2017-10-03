import Foundation
import XmlHero

final class MVitaXmlThumbnail
{
    //MARK: private
    
    private init() { }
    
    private class func findThumbnail(
        item:DVitaItemDirectory) -> Data?
    {
        guard
            
            let pngs:[DVitaItemElementPng] = item.png?.array as? [
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
    
    private class func findSmallerImage(
        pngs:[DVitaItemElementPng]) -> DVitaItemElement?
    {
        var smaller:DVitaItemElement?
        
        for png:DVitaItemElement in pngs
        {
            guard
                
                let currentSmaller:DVitaItemElement = smaller,
                png.size > currentSmaller.size
                
            else
            {
                smaller = png
                
                continue
            }
        }
        
        return smaller
    }
    
    //MARK: internal
    
    class func factoryMetadata(
        item:DVitaItemDirectory,
        completion:@escaping((Data?) -> ()))
    {
        
    }
}
