import Foundation

final class MVitaPtpString
{
    private static let kBytesForSize:Int = 1
    private static let kBytesPerCharacter:Int = 2
    private static let kWrappingCharacter:UInt8 = 0
    
    //MARK: private
    
    private init() { }
    
    private class func factoryLength(
        data:Data) -> Int?
    {
        guard
            
            let size:UInt8 = data.valueFromBytes()
            
        else
        {
            return nil
        }
        
        let sizeInt:Int = Int(size)
        let totalSize:Int = sizeInt * kBytesPerCharacter
        
        return totalSize
    }
    
    private class func factoryStringConfirm(
        data:Data) -> String?
    {
        let wrappedData:Data = wrapData(data:data)
        
        guard
            
            let string:String = String(
                data:wrappedData,
                encoding:String.Encoding.utf16)
            
        else
        {
            return nil
        }
        
        return string
    }
    
    private class func wrapData(data:Data) -> Data
    {
        let subData:Data = data.subdata(
            start:kBytesForSize)
        
        var wrappedData:Data = Data()
        wrappedData.append(value:kWrappingCharacter)
        wrappedData.append(subData)
        wrappedData.append(value:kWrappingCharacter)
        
        return data
    }
    
    //MARK: internal
    
    class func factoryString(
        data:Data) -> String?
    {
        guard
            
            let length:Int = factoryLength(data:data),
            data.count > length,
            let string:String = factoryStringConfirm(
                data:data)
        
        else
        {
            return nil
        }
        
        return string
    }
}
