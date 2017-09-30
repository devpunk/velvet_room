import UIKit

extension MVitaItemInDirectory
{
    //MARK: private
    
    private func allImages() -> [Data]
    {
        var images:[Data] = []
        
        for element:MVitaItemInElement in elements
        {
            guard
                
                element.fileExtension == MVitaItemInExtension.png,
                let data:Data = element.data
                
            else
            {
                continue
            }
            
            images.append(data)
        }
        
        return images
    }
    
    private func biggerImage(
        images:[Data]) -> Data?
    {
        var selectedSize:CGFloat?
        var selectedImage:Data?
        
        for image:Data in images
        {
            guard
            
                let size:CGFloat = biggerSize(image:image)
            
            else
            {
                continue
            }
            
            if let currentSize:CGFloat = selectedSize
            {
                if size > currentSize
                {
                    selectedSize = size
                    selectedImage = image
                }
            }
            else
            {
                selectedSize = size
                selectedImage = image
            }
        }
        
        return selectedImage
    }
    
    private func biggerSize(
        image:Data) -> CGFloat?
    {
        guard
        
            let image:UIImage = UIImage(data:image)
        
        else
        {
            return nil
        }
        
        let width:CGFloat = image.size.width
        let height:CGFloat = image.size.height
        let bigger:CGFloat = max(width, height)
        
        return bigger
    }
    
    //MARK: internal
    
    func thumbnail() -> Data?
    {
        let images:[Data] = allImages()
        
        guard
            
            let thumbnail:Data = biggerImage(
                images:images)
            
        else
        {
            return nil
        }
        
        return thumbnail
    }
}
