import Foundation

extension MVitaXmlThumbnail
{
    //MARK: private
    
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
    
    class func factoyThumbnailData(
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
}
