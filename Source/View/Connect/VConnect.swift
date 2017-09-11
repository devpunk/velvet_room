import UIKit

class VConnect:ViewMain
{
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Connect", for:UIControlState.normal)
        button.setTitleColor(
            UIColor.black,
            for:UIControlState.normal)
        button.addTarget(
            self,
            action:#selector(selectorActionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(button)
        
        NSLayoutConstraint.equals(
            view:button,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: selectors
    
    @objc
    private func selectorActionButton(sender button:UIButton)
    {
        guard
        
            let controller:CConnect = self.controller as? CConnect
        
        else
        {
            return
        }
        
//        controller.model.startWireless()
    }
}
