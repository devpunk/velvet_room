import Foundation

final class MVitaPtpMessageInObjectStatus:MVitaPtpMessageIn
{
    let name:String
    let objectId:UInt32
    private let kParameters:Int = 2
    
    override init?(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        let parameterSize:Int = MemoryLayout<UInt32>.size
        let expectedSize:Int = parameterSize * kParameters
        
        guard
            
            data.count >= expectedSize
            
        else
        {
            return nil
        }
        
        guard
            
            let parameters:[UInt32] = data.arrayFromBytes(
                elements:kParameters),
            let objectId:UInt32 = parameters.first,
            let nameLength:UInt32 = parameters.last
            
        else
        {
            return nil
        }
        
        let nameLengthInt:Int = Int(nameLength)
        let nameEndIndex:Int = expectedSize + nameLengthInt
        let subdataName:Data = data.subdata(
            start:parameterSize,
            endNotIncluding:nameEndIndex)
        
        guard
            
            let name:String = String(
                data:subdataName,
                encoding:String.Encoding.utf8)
        
        else
        {
            return nil
        }
        
        self.name = name
        self.objectId = objectId
        
        super.init(
            header:header,
            data:data)
    }
}
