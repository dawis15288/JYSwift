import UIKit

import CoreImage

@IBDesignable class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let image = imageView?.image, cgimg = image.CGImage else {
            
            print("imageView doesn't have an image!")
            
            return
            
        }
        
        let openGLContext = EAGLContext(API: .OpenGLES2)
        
        let context = CIContext(EAGLContext: openGLContext)
        
        let coreImage = CIImage(CGImage: cgimg)
        
        let sepiaFilter = CIFilter(name: "CISepiaTone")
        
        sepiaFilter?.setValue(coreImage, forKey: kCIInputImageKey)
        
        //filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        
        sepiaFilter?.setValue(1, forKey: kCIInputIntensityKey)
        
        if let output = sepiaFilter?.valueForKey(kCIOutputImageKey) as? CIImage {
            
            let exposureFilter = CIFilter(name: "CIExposureAdjust")
            
            exposureFilter?.setValue(output, forKey: kCIInputImageKey)
            
            exposureFilter?.setValue(1, forKey: kCIInputEVKey)
            
            if let exposureOutput = exposureFilter?.valueForKey(kCIOutputImageKey) as? CIImage {
                
                let cgimgresult = context.createCGImage(exposureOutput, fromRect: output.extent)
                
                let result = UIImage(CGImage: cgimgresult)
                
                imageView.image = result
            
            }
            
            
        
        } else {
            
            print("image filtering failed")
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

