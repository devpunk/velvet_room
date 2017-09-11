import UIKit

class VConnectStandby:View<ArchConnect>
{
    let kStartHeight:CGFloat = 64
    
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
