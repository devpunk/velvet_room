import Foundation

extension MVitaLink
{
    //MARK: internal
    
    class func storagePath(
        item:DVitaItemElement) -> URL?
    {
        guard
        
            let directoryName:String = item.directory?.localName,
            let localName:String = item.localName
        
        else
        {
            return nil
        }
        
        var path:URL = directoryPath(
            directoryName:directoryName)
        path.appendPathComponent(
            localName)
        
        return path
    }
}
