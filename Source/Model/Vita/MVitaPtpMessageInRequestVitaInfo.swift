import Foundation

final class MVitaPtpMessageInRequestVitaInfo:MVitaPtpMessageIn
{
    let transactionId:UInt32
    let payload:UInt32
    private let kElements:Int = 2
    
    override init?(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        guard
            
            let arrayData:[UInt32] = data.arrayFromBytes(
                elements:kElements),
            let transactionId:UInt32 = arrayData.first,
            let payload:UInt32 = arrayData.last
            
        else
        {
            return nil
        }
        
        self.transactionId = transactionId
        self.payload = payload
        
        super.init(
            header:header,
            data:data)
    }
}
