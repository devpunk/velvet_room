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
            
            let elements:[DVitaItemElement] = item.elements?.array as? [
                DVitaItemElement],
            let thumbnail:DVitaItemElement = findSmallerImage(
                elements:elements),
            let data:Data = MVitaLink.elementData(
                element:thumbnail)
            
        else
        {
            return nil
        }
        
        return data
    }
    
    private class func findSmallerImage(
        elements:[DVitaItemElement]) -> DVitaItemElement?
    {
        var smaller:DVitaItemElement?
        
        for element:DVitaItemElement in elements
        {
            guard
                
                element.fileExtension == MVitaItemInExtension.png
                
            else
            {
                continue
            }
            
            guard
                
                let currentSmaller:DVitaItemElement = smaller,
                element.size > currentSmaller.size
                
            else
            {
                smaller = element
                
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
