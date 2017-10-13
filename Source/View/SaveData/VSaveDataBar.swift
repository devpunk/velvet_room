import UIKit

final class VSaveDataBar:View<ArchSaveData>
{
    weak var layoutHeight:NSLayoutConstraint!
    private weak var viewThumbnail:VSaveDataBarThumbnail!
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
        let thumbnailRemainWidth:CGFloat = width - kThumbnailSize
        let thumbnailRemainHeight:CGFloat = height - kThumbnailSize
        let thumbnailMarginLeft:CGFloat = thumbnailRemainWidth / 2.0
        let thumbnailMarginTop:CGFloat = thumbnailRemainHeight / 2.0
        
        viewThumbnail.layoutLeft.constant = thumbnailMarginLeft
        viewThumbnail.layoutTop.constant = thumbnailMarginTop
        
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
        self.viewThumbnail = viewThumbnail
        
        addSubview(viewBackground)
        addSubview(viewThumbnail)
        
        NSLayoutConstraint.equals(
            view:viewBackground,
            toView:self)
        
        viewThumbnail.layoutTop = NSLayoutConstraint.topToTop(
            view:viewThumbnail,
            toView:self)
        viewThumbnail.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:viewThumbnail,
            toView:self)
        NSLayoutConstraint.size(
            view:viewThumbnail,
            constant:kThumbnailSize)
    }
}
