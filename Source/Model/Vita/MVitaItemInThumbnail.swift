import Foundation

extension MVitaItemIn
{
    //MARK: private
    
    private func asyncFindThumbnail(
        elements:[MVitaItemIn],
        dispatchGroup:DispatchGroup)
    {
        for element:MVitaItemIn in elements
        {
            guard
            
                element.format == MVitaItemFormat.element
            
            else
            {
                continue
            }
            
            
        }
    }
    
    //MARK: internal
    
    func findThumbnail(dispatchGroup:DispatchGroup)
    {
        guard
            
            let elements:[MVitaItemIn] = self.elements
        
        else
        {
            return
        }
        
        dispatchGroup.enter()
        
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncFindThumbnail(
                elements:elements,
                dispatchGroup:dispatchGroup)
        }
    }
}
