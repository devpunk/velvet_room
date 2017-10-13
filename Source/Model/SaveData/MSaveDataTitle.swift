import UIKit

struct MSaveDataTitle:MSaveDataProtocol
{
    let height:CGFloat = 50
    let reusableIdentifier:String = VSaveDataListCellTitle.reusableIdentifier
    let title:String
    
    init?(coredataModel:DVitaIdentifier)
    {
        guard
            
            let directories:[DVitaItemDirectory] = coredataModel.items?.array as? [DVitaItemDirectory],
            let title:String = directories.last?.sfoTitle
            
        else
        {
            return nil
        }
        
        self.title = title
    }
}
