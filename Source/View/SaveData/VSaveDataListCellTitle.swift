import UIKit

final class VSaveDataListCellTitle:VSaveDataListCell
{
    private weak var label:UILabel!
    private let kMarginHorizontal:CGFloat = 10
    private let kFontSize:CGFloat = 17
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.isUserInteractionEnabled = false
        label.numberOfLines = 0
        label.font = UIFont.medium(
            size:kFontSize)
        label.textColor = UIColor.colourBackgroundDark
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kMarginHorizontal)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(controller:CSaveData)
    {
        super.config(controller:controller)
        
        guard
            
            let directories:[DVitaItemDirectory] = controller.model.item?.coredataModel?.items?.array as? [DVitaItemDirectory],
            let name:String = directories.last?.sfoTitle
        
        else
        {
            return
        }
        
        label.text = name
    }
}
