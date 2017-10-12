import UIKit

final class VSaveDataBar:View<ArchSaveData>
{
    required init(controller:CSaveData)
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
        let viewBackground:VSaveDataBarBackground = VSaveDataBarBackground(
            controller:controller)
        
        addSubview(viewBackground)
        
        NSLayoutConstraint.equals(
            view:viewBackground,
            toView:self)
    }
}
