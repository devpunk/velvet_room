import Foundation

extension Data
{
    //MARK: internal
    
    func writeToTemporal(withExtension:String?) -> URL?
    {
        var randomName:String = UUID().uuidString
        
        if let withExtension:String = withExtension
        {
            randomName.append(".")
            randomName.append(withExtension)
        }
        
        let directoryUrl:URL = URL(fileURLWithPath:NSTemporaryDirectory())
        let fileUrl:URL = directoryUrl.appendingPathComponent(randomName)
        
        do
        {
            try write(
                to:fileUrl,
                options:Data.WritingOptions.atomicWrite)
        }
        catch
        {
            return nil
        }
        
        return fileUrl
    }
    
    func arrayFromBytes<T>(count:Int) -> [T]
    {
        let array:[T] = withUnsafeBytes
        { (pointer:UnsafePointer<T>) -> [T] in
            
            let bufferPointer:UnsafeBufferPointer = UnsafeBufferPointer(
                start:pointer,
                count:count)
            let array:[T] = Array(bufferPointer)
            
            return array
        }
        
        return array
    }
}
