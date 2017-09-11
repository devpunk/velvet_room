import UIKit

class VConnectStandby:View<ArchConnect>
{
    required init(controller:CConnect)
    {
        super.init(controller:controller)
        factoryViews()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
