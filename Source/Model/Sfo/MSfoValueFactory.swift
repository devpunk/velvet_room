import Foundation

extension MSfo
{
    //MARK: private
    
    private static func factoryText(
        item:MSfoItem,
        header:MSfoHeader,
        data:Data) -> MSfoValueProtocol?
    {
        
    }
    
    //MARK: internal
    
    static func factoryValue(
        item:MSfoItem,
        header:MSfoHeader,
        data:Data) -> MSfoValueProtocol?
    {
        let value:MSfoValueProtocol?
        
        switch item.format
        {
        case MSfoItemFormat.text:
            
            value = factoryText(
                item:item,
                header:header,
                data:data)
            
            break
        }
        
        return value
    }
}
