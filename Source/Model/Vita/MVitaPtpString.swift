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
    
    private class func factoryString(
        data:Data,
        length:Int) -> String?
    {
        let wrappedData:Data = wrapData(
            data:data,
            length:length)
        
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
    
    private class func wrapData(
        data:Data,
        length:Int) -> Data
    {
        let subdataLength:Int = length - kBytesForSize
        let subData:Data = data.subdata(
            start:kBytesForSize,
            endNotIncluding:subdataLength)
        
        var wrappedData:Data = Data()
        wrappedData.append(value:kWrappingCharacter)
        wrappedData.append(subData)
        
        return wrappedData
    }
    
    //MARK: internal
    
    class func factoryString(
        data:Data) -> String?
    {
        guard
            
            let length:Int = factoryLength(data:data),
            length > 0,
            data.count > length,
            let string:String = factoryString(
                data:data,
                length:length)
        
        else
        {
            return nil
        }
        
        return string
    }
    
    class func factoryData(
        string:String) -> Data?
    {
        guard
            
            let stringData:Data = string.data(
                using:String.Encoding.utf8,
                allowLossyConversion:false)
        
        else
        {
            return nil
        }
        
        let stringDataSize:Int = stringData.count
        let stringUnsignedSize:UInt8 = UInt8(stringDataSize)
        
        var data:Data = Data()
        data.append(stringUnsignedSize)
        data.append(stringData)
        
        return data
    }
}
