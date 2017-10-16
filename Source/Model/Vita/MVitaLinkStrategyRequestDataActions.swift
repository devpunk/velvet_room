import Foundation

extension MVitaLinkStrategyRequestData
{
    //MARK: internal
    
    final func readAgain()
    {
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
                
            self?.model?.linkCommand.readData()
        }
    }
    
    final func removeTransaction(data:Data) -> Data?
    {
        guard
            
            let transactionId:UInt32 = data.valueFromBytes(),
            self.transactionId == transactionId
            
        else
        {
            return nil
        }
        
        let transactionSize:Int = MemoryLayout<UInt32>.size
        let subdata:Data = data.subdata(start:transactionSize)
        
        return subdata
    }
    
    final func restart()
    {
        data = Data()
        payload = 0
        transactionId = 0
    }
}
