import UIKit

final class VConnectLoading:View<ArchConnect>
{
    private weak var spinner:VSpinner!
    
    required init(controller:CConnect)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        addSubview(spinner)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        spinner.stopAnimating()
    }
}
