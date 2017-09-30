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
}
