import UIKit

final class VSaveDataBar:View<ArchSaveData>
{
    weak var layoutHeight:NSLayoutConstraint!
    private weak var layoutThumbnailTop:NSLayoutConstraint!
    private weak var layoutThumbnailLeft:NSLayoutConstraint!
    private let kThumbnailSize:CGFloat = 134
    
    required init(controller:CSaveData)
    {
        super.init(controller:controller)
        
        factoryViews()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let height:CGFloat = bounds.height
        let remainWidth:CGFloat = width - kThumbnailSize
        let remainHeight:CGFloat = height - kThumbnailSize
        let marginLeft:CGFloat = remainWidth / 2.0
        let marginTop:CGFloat = remainHeight / 2.0
        layoutThumbnailLeft.constant = marginLeft
        layoutThumbnailTop.constant = marginTop
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func factoryViews()
    {
        let cornerRadius:CGFloat = kThumbnailSize / 2.0
        
        let viewBackground:VSaveDataBarBackground = VSaveDataBarBackground(
            controller:controller)
        
        let viewThumbnail:VSaveDataBarThumbnail = VSaveDataBarThumbnail(
            controller:controller)
        viewThumbnail.layer.cornerRadius = cornerRadius
        
        addSubview(viewBackground)
        addSubview(viewThumbnail)
        
        NSLayoutConstraint.equals(
            view:viewBackground,
            toView:self)
        
        layoutThumbnailTop = NSLayoutConstraint.topToTop(
            view:viewThumbnail,
            toView:self)
        layoutThumbnailLeft = NSLayoutConstraint.leftToLeft(
            view:viewThumbnail,
            toView:self)
        NSLayoutConstraint.size(
            view:viewThumbnail,
            constant:kThumbnailSize)
    }
}
