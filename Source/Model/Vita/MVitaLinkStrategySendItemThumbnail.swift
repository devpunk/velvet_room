import Foundation

final class MVitaLinkStrategySendItemThumbnail:
    MVitaLinkStrategySendData,
    MVitaLinkStrategyDatabaseProtocol,
    MVitaLinkStrategyEventProtocol
{
    private weak var database:Database?
    private var event:MVitaPtpMessageInEvent?
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategySendItemThumbnail_messageFailed")
        model?.errorCloseConnection(
            message:message)
    }
    
    override func success()
    {
        guard
            
            let event:MVitaPtpMessageInEvent = self.event
            
        else
        {
            failed()
            
            return
        }
        
        model?.sendResultSuccess(event:event)
    }
    
    //MARK: database protocol
    
    func config(database:Database)
    {
        self.database = database
    }
    
    //MARK: event protocol
    
    func config(event:MVitaPtpMessageInEvent)
    {
        self.event = event
        
        guard
            
            let unsignedItemIndex:UInt32 = event.parameters.first,
            let database:Database = self.database
        
        else
        {
            failed()
            
            return
        }
        
        let itemIndex:Int = Int(unsignedItemIndex)
        let sorters:[NSSortDescriptor] = MVitaLink.factorySortersForIdentifier()
        
        print("requesting thumbnail \(event.parameters)")
        
        sendThumbnail(
            itemIndex:itemIndex,
            sorters:sorters,
            database:database,
            event:event)
    }
    
    //MARK: private
    
    private func sendThumbnail(
        itemIndex:Int,
        sorters:[NSSortDescriptor],
        database:Database,
        event:MVitaPtpMessageInEvent)
    {
        database.fetch(sorters:sorters)
        { [weak self] (identifiers:[DVitaIdentifier]) in
            
            let totalIdentifiers:Int = identifiers.count
            
            guard
                
                totalIdentifiers > itemIndex
            
            else
            {
                self?.failed()
                
                return
            }
            
            let identifier:DVitaIdentifier = identifiers[itemIndex]
            
            guard
            
                let directory:DVitaItemDirectory = identifier.items?.lastObject as? DVitaItemDirectory
            
            else
            {
                self?.failed()
                
                return
            }
            
            self?.sendThumbnail(
                directory:directory,
                event:event)
        }
    }
    
    private func sendThumbnail(
        directory:DVitaItemDirectory,
        event:MVitaPtpMessageInEvent)
    {
        MVitaXmlThumbnail.factoryMetadata(directory:directory)
        { (data:Data?) in
            
            guard
            
                let data:Data = data
            
            else
            {
                self.failed()
                
                return
            }
            
            self.sendData(
                data:data,
                event:event)
        }
    }
    
    private func sendData(
        data:Data,
        event:MVitaPtpMessageInEvent)
    {
        let message:MVitaPtpMessageOutEventCommand = MVitaPtpMessageOutEventCommand(
            event:event,
            dataPhase:MVitaPtpDataPhase.send,
            command:MVitaPtpCommand.sendItemThumbnail)
        
        send(
            data:data,
            message:message)
    }
}
