import Foundation

extension Data
{
    private static let kDot:String = "."
    
    //MARK: internal
    
    func writeToTemporal(withExtension:String?) -> URL?
    {
        var randomName:String = UUID().uuidString
        
        if let withExtension:String = withExtension
        {
            randomName.append(Data.kDot)
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
    
    func arrayFromBytes<T>(elements:Int) -> [T]?
    {   
        let valueSize:Int = MemoryLayout<T>.size
        let expectedSize:Int = elements * valueSize
        
        guard
            
            count >= expectedSize
        
        else
        {
            return nil
        }
        
        let array:[T] = withUnsafeBytes
        { (pointer:UnsafePointer<T>) -> [T] in
            
            let bufferPointer:UnsafeBufferPointer = UnsafeBufferPointer(
                start:pointer,
                count:elements)
            let array:[T] = Array(bufferPointer)
            
            return array
        }
        
        return array
    }
    
    func valueFromBytes<T>() -> T?
    {
        guard
        
            let array:[T] = arrayFromBytes(elements:1),
            let value:T = array.first
        
        else
        {
            return nil
        }
        
        return value
    }
}
