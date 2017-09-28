import UIKit

final class VConnectedError:View<ArchConnected>
{
    required init(controller:CConnected)
    {
        super.init(controller:controller)
        
        factoryViews()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func factoryViews()
    {
        
    }
}
