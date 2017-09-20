import Foundation

final class MVitaPtpMessageInReceiveData:MVitaPtpMessageIn
{
    let payload:Int
    let transactionId:UInt32
    private let kElements:Int = 2
    
    override init?(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        guard
            
            let arrayData:[UInt32] = data.arrayFromBytes(
                elements:kElements),
            let transactionId:UInt32 = arrayData.first,
            let payloadUnsigned:UInt32 = arrayData.last
            
        else
        {
            return nil
        }
        
        self.transactionId = transactionId
        payload = Int(payloadUnsigned)
        
        super.init(
            header:header,
            data:data)
    }
}
