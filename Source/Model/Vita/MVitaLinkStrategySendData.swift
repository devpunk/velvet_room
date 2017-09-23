import Foundation

class MVitaLinkStrategySendData:MVitaLinkStrategyProtocol
{
    private(set) var model:MVitaLink?
    private var bytesSent:Int
    private var data:Data?
    private var status:MVitaLinkStrategySendDataStatusProtocol?
    private let kMaxBlockSize:Int = 32756
    
    required init(model:MVitaLink)
    {
        self.model = model
        bytesSent = 0
    }
    
    //MARK: protocol
    
    func commandWrite()
    {
        status?.commandWrite(strategy:self)
    }
    
    //MARK: private
    
    private func changeStatus(
        status:MVitaLinkStrategySendDataStatusProtocol.Type)
    {
        self.status = status.init()
    }
    
    private func packet(data:Data)
    {
        print("remain: \(remain)")
        
        if remain > maxBlockSize
        {
            print("send data")
            type = 10 //PTPIP_DATA_PACKET
            toWrite = maxBlockSize
        }
        else
        {
            print("end data")
            type = 12 //PTPIP_END_DATA_PACKET
            toWrite = remain
            step = 2
        }
        
        let endIndex:Int = toWrite + totalWritten
        let writingData:Data = dataToWrite.subdata(in:totalWritten..<endIndex)
        let length:UInt32 = UInt32(toWrite + 12)
        var pars:[UInt32] = [length, type, connected!.transactionId]
        
        var data:Data = Data()
        data.append(UnsafeBufferPointer(start:&pars, count:pars.count))
        data.append(writingData)
        
        totalWritten += toWrite
        
        sock.write(data, withTimeout:100, tag:0)
    }
    
    private func packetEnd(
        data:Data,
        remainBytes:Int)
    {
        
    }
    
    //MARK: internal
    
    final func send(
        data:Data,
        code:UInt16)
    {
        self.data = data
        
        changeStatus(
            status:MVitaLinkStrategySendDataStatusHeader.self)
        
        let message:MVitaPtpMessageOutSendData = MVitaPtpMessageOutSendData(
            code:code)
        model?.linkCommand.writeMessage(
            message:message)
    }
    
    final func packetStart()
    {
        guard
            
            let dataSize:Int = data?.count
        
        else
        {
            return
        }
        
        changeStatus(
            status:MVitaLinkStrategySendDataStatusPacketStart.self)
        
        let message:MVitaPtpMessageOutPacketStart = MVitaPtpMessageOutPacketStart(
            dataSize:dataSize)
        model?.linkCommand.writeMessage(
            message:message)
    }
    
    final func packet()
    {
        guard
            
            let data:Data = self.data
            
        else
        {
            return
        }
        
        let size:Int = data.count
        let remainBytes:Int = size - bytesSent
        
        if remainBytes > kMaxBlockSize
        {
            packet(data:data)
        }
        else
        {
            
        }
        
        let type:UInt32
        let toWrite:Int
        
        print("remain: \(remain)")
        
        if remain > maxBlockSize
        {
            print("send data")
            type = 10 //PTPIP_DATA_PACKET
            toWrite = maxBlockSize
        }
        else
        {
            print("end data")
            type = 12 //PTPIP_END_DATA_PACKET
            toWrite = remain
            step = 2
        }
        
        let endIndex:Int = toWrite + totalWritten
        let writingData:Data = dataToWrite.subdata(in:totalWritten..<endIndex)
        let length:UInt32 = UInt32(toWrite + 12)
        var pars:[UInt32] = [length, type, connected!.transactionId]
        
        var data:Data = Data()
        data.append(UnsafeBufferPointer(start:&pars, count:pars.count))
        data.append(writingData)
        
        totalWritten += toWrite
        
        sock.write(data, withTimeout:100, tag:0)
    }
    
    func failed() { }
    func success() { }
}
