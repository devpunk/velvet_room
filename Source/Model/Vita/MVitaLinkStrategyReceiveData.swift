import Foundation

class MVitaLinkStrategyReceiveData:MVitaLinkStrategyProtocol
{
    var data:Data
    var payload:Int
    var transactionId:UInt32
    private(set) var model:MVitaLink?
    private let kElementsStart:Int = 2
    
    required init(model:MVitaLink)
    {
        self.model = model
        data = Data()
        payload = 0
        transactionId = 0
    }
    
    //MARK: protocol
    
    func commandReceived(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        switch header.type
        {
        case MVitaPtpType.dataPacketStart:
            
            receivedPacketStart(
                header:header,
                data:data)
            
            break
            
        case MVitaPtpType.dataPacket:
            
            receivedPacket(
                header:header,
                data:data)
            
            break
            
        case MVitaPtpType.dataPacketEnd:
            
            receivedPacketEnd(
                header:header,
                data:data)
            
            break
            
        case MVitaPtpType.commandAccepted:
            
            receivedConfirm(
                header:header,
                data:data)
            
            break
            
        default:
            
            failed()
            
            break
        }
    }
    
    //MARK: private
    
    private func readAgain()
    {
        model?.linkCommand.readData()
    }
    
    private func receivedPacketStart(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        guard
            
            let arrayData:[UInt32] = data.arrayFromBytes(
                elements:kElementsStart),
            let transactionId:UInt32 = arrayData.first,
            let payloadUnsigned:UInt32 = arrayData.last
            
        else
        {
            failed()
            
            return
        }
        
        self.transactionId = transactionId
        payload = Int(payloadUnsigned)
        
        readAgain()
    }
    
    private func receivedPacket(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        let dataMinusTransaction:Data = dataUnheader.subdata(in:4..<dataUnheader.count)
        
        self.dataReceived?.append(dataMinusTransaction)
        
        //[size, response:10 or 12]
        //10:PTPIP_DATA_PACKET
        //12:PTPIP_END_DATA_PACKET
        
        if header.type == 12
        {
            step = 4
            let datareceived:Data = self.dataReceived!
            
            print("total data: \(datareceived.count)")
            
            
            if let receivingString:String = String(
                data:datareceived,
                encoding:String.Encoding.ascii)
            {
                print("data in xml:")
                print(receivingString)
                
                /**
                 
                 <VITAInformation responderVersion="3.65" protocolVersion="01800010" comVersion="190" modelInfo="PCH02006ZA11" timezone="10"><photoThumb type="0" codecType="17" width="213" height="120"/><videoThumb type="1" codecType="5" width="213" height="120" duration="15"/><musicThumb type="0" codecType="17" width="192" height="192"/><gameThumb type="0" codecType="17" width="192" height="192"/></VITAInformation>
                 
                 ***/
            }
            else
            {
                print("can't create string")
            }
            self.dataReceived = nil
        }
        else if header.type == 10
        {
            print("------- read again")
        }
        else
        {
            print("error header type: \(header.type)")
        }
        
        defer
        {
            if readAgain
            {
                DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
                    {
                        self.connected?.readCommand()
                }
            }
        }
    }
    
    private func receivedPacketEnd(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        
    }
    
    private func receivedConfirm(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        
    }
    
    //MARK: internal
    
    func failed()
    {
    }
    
    func success()
    {
    }
}
