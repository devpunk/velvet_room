import UIKit

final class VConnectingLoading:View<ArchConnecting>
{
    private weak var spinner:VSpinner!
    private let kTitleBottom:CGFloat = -135
    private let kTitleHeight:CGFloat = 22
    
    required init(controller:CConnecting)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.medium(size:15)
        labelTitle.textColor = UIColor.white
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.text = String.localizedView(
            key:"VConnectingLoading_labelTitle")
        
        addSubview(spinner)
        addSubview(labelTitle)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelTitle,
            toView:self,
            constant:kTitleBottom)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
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
