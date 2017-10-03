import Foundation

extension MVitaLink
{
    static let kStorageDirectory:String = "storage"
    static let kThumbnailName:String = "thumbnail.png"
    
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
    
    class func thumbnail(
        directoryName:String) -> Data?
    {
        let path:URL = directoryPath(
            directoryName:directoryName)
        let thumbnailPath:URL = path.appendingPathComponent(
            kThumbnailName)
        
        let data:Data
        
        do
        {
            try data = Data(
                contentsOf:thumbnailPath)
        }
        catch
        {
            return nil
        }
        
        return data
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
    
    class func storeThumbnail(
        directoryPath:URL,
        directory:MVitaItemInDirectory)
    {
        guard
        
            let data:Data = directory.thumbnail
        
        else
        {
            return
        }
        
        let thumbnailPath:URL = directoryPath.appendingPathComponent(
            kThumbnailName)
        
        do
        {
            try data.write(
                to:thumbnailPath,
                options:
                Data.WritingOptions.atomicWrite)
        }
        catch
        {
        }
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
