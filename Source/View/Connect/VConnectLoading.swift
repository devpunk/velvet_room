import UIKit

final class VConnectLoading:View<ArchConnect>
{
    private weak var spinner:VSpinner!
    private weak var layoutCancelLeft:NSLayoutConstraint!
    private let kCancelBottom:CGFloat = -200
    private let kCancelHeight:CGFloat = 60
    private let kCancelWidth:CGFloat = 140
    private let kTitleHeight:CGFloat = 50
    
    required init(controller:CConnect)
    {
        super.init(controller:controller)
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.medium(size:15)
        labelTitle.textColor = UIColor.colourBackgroundDark
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.text = String.localizedView(
            key:"VConnectLoading_labelTitle")
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitleColor(
            UIColor.colourBackgroundDark.withAlphaComponent(0.5),
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor.colourBackgroundGray,
            for:UIControlState.highlighted)
        buttonCancel.titleLabel!.font = UIFont.regular(size:15)
        buttonCancel.setTitle(
            String.localizedView(key:"VConnectLoading_buttonCancel"),
            for:UIControlState.normal)
        
        addSubview(spinner)
        addSubview(buttonCancel)
        addSubview(labelTitle)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonCancel,
            toView:self,
            constant:kCancelBottom)
        NSLayoutConstraint.height(
            view:buttonCancel,
            constant:kCancelHeight)
        NSLayoutConstraint.width(
            view:buttonCancel,
            constant:kCancelWidth)
        layoutCancelLeft = NSLayoutConstraint.leftToLeft(
            view:buttonCancel,
            toView:self)
        
        NSLayoutConstraint.bottomToTop(
            view:labelTitle,
            toView:buttonCancel)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kCancelHeight)
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
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let remainCancel:CGFloat = width - kCancelWidth
        let cancelLeft:CGFloat = remainCancel / 2.0
        layoutCancelLeft.constant = cancelLeft
        
        super.layoutSubviews()
    }
}
