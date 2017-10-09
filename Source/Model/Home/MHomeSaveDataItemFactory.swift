import UIKit

extension MHomeSaveDataItem
{
    //MARK: private
    
    private class func factoryGameName(
        identifier:DVitaIdentifier) -> String?
    {
        guard
        
            let directories:[DVitaItemDirectory] = identifier.items?.array as? [
                DVitaItemDirectory],
            let gameName:String = directories.last?.sfoTitle
        
        else
        {
            return nil
        }
        
        return gameName
    }
    
    private class func factoryLastUpdate(
        identifier:DVitaIdentifier,
        dateFormatter:DateFormatter) -> String?
    {
        guard
            
            let directories:[DVitaItemDirectory] = identifier.items?.array as? [
                DVitaItemDirectory],
            let lastUpdate:TimeInterval = directories.last?.dateModified
            
        else
        {
            return nil
        }
        
        let date:Date = Date(timeIntervalSince1970:lastUpdate)
        let dateString:String = dateFormatter.string(from:date)
        
        return dateString
    }
    
    private class func factoryThumbnail(
        identifier:DVitaIdentifier) -> UIImage?
    {
        guard
        
            let directories:[DVitaItemDirectory] = identifier.items?.array as? [
                DVitaItemDirectory],
            let lastDirectory:DVitaItemDirectory = directories.last
        
        else
        {
            return nil
        }
        
        let biggerPng:UIImage? = findBiggerPng(
            directory:lastDirectory)
        
        return biggerPng
    }
    
    private class func findBiggerPng(
        directory:DVitaItemDirectory) -> UIImage?
    {
        guard
        
            let allPng:[DVitaItemElement] = directory.png?.array as? [
                DVitaItemElement]
        
        else
        {
            return nil
        }
        
        var biggerImage:UIImage?
        
        for png:DVitaItemElement in allPng
        {
            guard
            
                let image:UIImage = factoryImage(
                    element:png)
            
            else
            {
                continue
            }
            
            guard
            
                let currentImage:UIImage = biggerImage
            
            else
            {
                biggerImage = image
                
                continue
            }
            
            let currentHeight:CGFloat = currentImage.size.height
            let newHeight:CGFloat = image.size.height
            
            if newHeight > currentHeight
            {
                biggerImage = image
            }
        }
        
        return biggerImage
    }
    
    private class func factoryImage(
        element:DVitaItemElement) -> UIImage?
    {
        guard
        
            let data:Data = MVitaLink.elementData(
                element:element),
            let image:UIImage = UIImage(
                data:data)
        
        else
        {
            return nil
        }
        
        return image
    }
    
    //MARK: internal
    
    class func factoryDateFormatter() -> DateFormatter
    {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        return dateFormatter
    }
    
    class func factoryItem(
        identifier:DVitaIdentifier,
        dateFormatter:DateFormatter) -> MHomeSaveDataItem?
    {
        guard
        
            let gameName:String = factoryGameName(
                identifier:identifier),
            let lastUpdate:String = factoryLastUpdate(
                identifier:identifier,
                dateFormatter:dateFormatter)
        
        else
        {
            return nil
        }
        
        let thumbnail:UIImage? = factoryThumbnail(
            identifier:identifier)
        
        let item:MHomeSaveDataItem = MHomeSaveDataItem(
            coredataModel:identifier,
            gameName:gameName,
            lastUpdated:lastUpdate,
            thumbnail:thumbnail)
        
        return item
    }
}
