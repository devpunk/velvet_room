import Foundation

extension MVitaLink
{
    static let kStorageDirectory:String = "storage"
    
    private class func createDirectoryAtPath(
        path:URL)
    {
        var path:URL = path
        path.excludeFromBackup()
        
        do
        {
            try FileManager.default.createDirectory(
                at:path,
                withIntermediateDirectories:true,
                attributes:nil)
        }
        catch
        {
        }
    }
    
    //MARK: internal
    
    class func createDirectory(
        directoryName:String) -> URL
    {
        let path:URL = directoryPath(
            directoryName:directoryName)
        createDirectoryAtPath(path:path)
        
        return path
    }
    
    class func directoryPath(
        directoryName:String) -> URL
    {
        var directoryPath:URL = FileManager.default.appDirectory
        directoryPath.appendPathComponent(
            kStorageDirectory)
        directoryPath.appendPathComponent(
            directoryName)
        
        return directoryPath
    }
    
    class func elementData(
        element:DVitaItemElement) -> Data?
    {
        guard
            
            let localName:String = element.localName,
            let directoryName:String = element.directory?.localName
        
        else
        {
            return nil
        }
        
        let path:URL = directoryPath(
            directoryName:directoryName)
        let dataPath:URL = path.appendingPathComponent(
            localName)
        
        let data:Data
        
        do
        {
            try data = Data(
                contentsOf:dataPath)
        }
        catch
        {
            return nil
        }
        
        return data
    }
    
    class func storeElement(
        localName:String,
        directoryPath:URL,
        data:Data) throws
    {
        let elementPath:URL = directoryPath.appendingPathComponent(
            localName)
        
        try data.write(
            to:elementPath,
            options:
            Data.WritingOptions.atomicWrite)
    }
}
