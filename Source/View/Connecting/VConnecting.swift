import UIKit

class VConnecting:ViewMain
{
    private weak var spinner:VSpinner!
    private weak var layoutCancelLeft:NSLayoutConstraint!
    private let kCancelBottom:CGFloat = -80
    private let kCancelHeight:CGFloat = 45
    private let kCancelWidth:CGFloat = 140
    private let kTitleHeight:CGFloat = 22
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CConnecting = controller as? CConnecting
        
        else
        {
            return
        }
        
        factoryViews(controller:controller)
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
    
    //MARK: private
    
    private func factoryViews(controller:CConnecting)
    {
        let viewGradient:VGradient = VGradient.vertical(
            colourTop:UIColor.colourGradientLight,
            colourBottom:UIColor.colourGradientDark)
        
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
            key:"VConnecting_labelTitle")
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitleColor(
            UIColor(white:1, alpha:0.6),
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonCancel.titleLabel!.font = UIFont.regular(size:17)
        buttonCancel.setTitle(
            String.localizedView(key:"VConnecting_buttonCancel"),
            for:UIControlState.normal)
        
        addSubview(viewGradient)
        addSubview(spinner)
        addSubview(buttonCancel)
        addSubview(labelTitle)
        
        NSLayoutConstraint.equals(
            view:viewGradient,
            toView:self)
        
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
}
