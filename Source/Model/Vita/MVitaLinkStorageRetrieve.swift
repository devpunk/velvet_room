import Foundation

extension MVitaLink
{
    //MARK: internal
    
    class func storagePath(
        element:DVitaItemElement) -> URL?
    {
        guard
        
            let directoryName:String = element.directory?.localName,
            let localName:String = element.localName
        
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
