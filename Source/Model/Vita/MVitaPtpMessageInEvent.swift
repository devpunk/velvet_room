import Foundation

final class MVitaPtpMessageInEvent:MVitaPtpMessageIn
{
    let code:MVitaPtpCommand
    let transactionId:UInt32
    
    override init?(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        let codeSize:Int = MemoryLayout<UInt16>.size
        let parameterSize:Int = MemoryLayout<UInt32>.size
        let expectedSize:Int = codeSize + parameterSize
        
        guard
            
            data.count >= expectedSize
            
        else
        {
            return nil
        }
        
        let subdataTransaction:Data = data.subdata(
            start:codeSize)
        let subdataParameters:Data = data.subdata(
            start:expectedSize)
        
        guard
            
            let rawCode:UInt16 = data.valueFromBytes(),
            let transactionId:UInt32 = subdataTransaction.valueFromBytes()
            
        else
        {
            return nil
        }
        
        if let code:MVitaPtpCommand = MVitaPtpCommand(
            rawValue:rawCode)
        {
            self.code = code
        }
        else
        {
            self.code = MVitaPtpCommand.unknown
        }
        
        self.transactionId = transactionId
        
        super.init(
            header:header,
            data:data)
        
        
        
        
        let arrCode = dataUnheader.withUnsafeBytes {
            
            Array(UnsafeBufferPointer<UInt16>(start: $0, count: 1))
        }
        
        let subData1:Data = dataUnheader.subdata(in:2..<dataUnheader.count)
        
        let arrTrans = subData1.withUnsafeBytes {
            
            Array(UnsafeBufferPointer<UInt32>(start: $0, count: 1))
        }
        
        let subData2:Data = dataUnheader.subdata(in:6..<dataUnheader.count)
        let count:Int = subData2.count / 4
        
        let arrParameters = subData2.withUnsafeBytes {
            
            Array(UnsafeBufferPointer<UInt32>(start: $0, count:count))
        }
        
        print("------- event \(arrCode[0]) trans \(arrTrans[0]) pars:\(arrParameters)")
        // opencma.c
        if arrCode[0] == 49426
        {
            carriedData = nil
            dataReceived = nil
            getSettingInfo(eventId:arrParameters[0])
        }
    }
}

