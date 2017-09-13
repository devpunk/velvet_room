import UIKit

final class VConnectingPinList:VCollection<
    ArchConnecting,
    VConnectingPinListCell>
{
    required init(controller:CConnecting)
    {
        super.init(controller:controller)
        
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
