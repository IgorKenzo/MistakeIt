//
//  FaseLampada.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 27/10/20.
//

import SpriteKit

class FaseLampada: SKScene {
    
    var apertado = false
    var fundo = SKEffectNode()

    
    override func didMove(to view: SKView) {
        
        let teste = RotateNode(imageNamed: "fila1")
        self.addChild(teste)
        
        
        let blurBackground = SKSpriteNode(imageNamed: "blur")
        let hintPopUp = SKSpriteNode(imageNamed: "hint-bubble")
        let filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius" : NSNumber(value:200.0)])
        fundo = SKEffectNode()
        fundo.filter = filter
        fundo.shouldRasterize = true
        fundo.shouldEnableEffects = false
        fundo.addChild(blurBackground)
        fundo.zPosition = -1
        self.addChild(fundo)
//        let pause = BlurCropNode(size: CGSize(width: self.size.width * 2, height: self.size.height * 2))
//        pause.blurNode.texture = SKTexture(imageNamed: "background")
//        pause.position = CGPoint(x: 0, y: 0)
        
        let btnHint = GameButtonNode(image: SKTexture(imageNamed: "hint"), onTap: {})
        btnHint.position = CGPoint(x: -270, y: -510)
        self.addChild(btnHint)
        
        hintPopUp.position = CGPoint(x: btnHint.position.x + hintPopUp.size.width/2, y: btnHint.position.y + hintPopUp.size.height/2)
        btnHint.onTap = {
            //self.loadPauseBGScreen()
//            self.addChild(pause)
            if !btnHint.pressed {
                self.blurBackground()
                self.addChild(hintPopUp)
            }
            else {
                self.blurBackground()
                hintPopUp.removeFromParent()
            }
        }
        
        
        //btnHint.zPosition = 1
        
        let btnSettings = GameButtonNode(image: SKTexture(imageNamed: "settings"), onTap: {
            self.run(SKAction.rotate(byAngle: -.pi/2, duration: 1))
            
        })
        btnSettings.position = CGPoint(x: 270, y: -510)
        self.addChild(btnSettings)
        
        //btnSettings.zPosition = 1
        
        let btnRetry = GameButtonNode(image: SKTexture(imageNamed: "retry"), onTap: {})
        let btnHome = GameButtonNode(image: SKTexture(imageNamed: "home"), onTap: {})
        let btnMusic = GameButtonNode(image: SKTexture(imageNamed: "music"), onTap: {})

        let settingsButtons = [btnRetry, btnHome, btnMusic]

        var animationsFw : [SKAction] = []
        let animationBack : SKAction = SKAction.move(to: btnSettings.position, duration: 0.3)
//
        for i in 0 ..< settingsButtons.count {
            settingsButtons[i].position = btnSettings.position
            settingsButtons[i].zPosition = 1
            animationsFw.append(SKAction.move(to: CGPoint(x: btnSettings.position.x, y: btnSettings.position.y + (CGFloat(i + 1) * (settingsButtons[i].size.height + 30))), duration: 0.3))
        }
    
        
        btnSettings.onTap = {
            
            if !btnSettings.pressed {
                self.blurBackground()
                btnSettings.run(SKAction.rotate(byAngle: -.pi/2, duration: 0.3))
                
                for i in 0..<settingsButtons.count {
                    self.addChild(settingsButtons[i])
                    settingsButtons[i].run(animationsFw[i])
                }
            }
            else{
                self.blurBackground()
                btnSettings.run(SKAction.rotate(byAngle: .pi/2, duration: 0.3))
                
                for i in 0..<settingsButtons.count {
                    settingsButtons[i].run(animationBack,completion: {
                        settingsButtons[i].removeFromParent()
                    })
                }
            }
            
        }
    }
    
    
    //MARK: test 1
    func getBluredScreenshot() -> SKSpriteNode{

        //create the graphics context
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.view!.frame.size.width, height: self.view!.frame.size.height), true, 1)

        self.view!.drawHierarchy(in: self.view!.frame, afterScreenUpdates: true)

        // retrieve graphics context
        _ = UIGraphicsGetCurrentContext()

        // query image from it
        let image = UIGraphicsGetImageFromCurrentImageContext()

        // create Core Image context
        let ciContext = CIContext(options: nil)
        // create a CIImage, think of a CIImage as image data for processing, nothing is displayed or can be displayed at this point
        let coreImage = CIImage(image: image!)
        // pick the filter we want
        let filter = CIFilter(name: "CIGaussianBlur")
        // pass our image as input
        filter?.setValue(coreImage, forKey: kCIInputImageKey)

        //edit the amount of blur
        filter?.setValue(3, forKey: kCIInputRadiusKey)

        //retrieve the processed image
        let filteredImageData = filter?.value(forKey: kCIOutputImageKey) as! CIImage
        // return a Quartz image from the Core Image context
        let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
        // final UIImage
        let filteredImage = UIImage(cgImage: filteredImageRef!)

        // create a texture, pass the UIImage
        let texture = SKTexture(image: filteredImage)
        // wrap it inside a sprite node
        let sprite = SKSpriteNode(texture:texture)
        
        // make image the position in the center
        sprite.position = CGPoint(x: self.frame.midX, y: self.frame.midY)

        //let scale:CGFloat = UIScreen.main.scale
        
        //sprite.size.width  *= scale

        //sprite.size.height *= scale

        return sprite


    }

    func loadPauseBGScreen(){

        let duration = 1.0

        let pauseBG:SKSpriteNode = self.getBluredScreenshot()

        pauseBG.alpha = 0
        pauseBG.zPosition = self.zPosition + 1
        pauseBG.run(SKAction.fadeAlpha(to: 1, duration: duration))

        self.addChild(pauseBG)
        
    }
    
    //MARK: test 2 -> https://stackoverflow.com/questions/24980353/uivisualeffectview-doesnt-blur-its-skview-superview/24999885#24999885
    class BlurCropNode: SKCropNode {
        var blurNode: BlurNode
        var size: CGSize
        init(size: CGSize) {
            self.size = size
            blurNode = BlurNode(radius: 10)
            super.init()
            addChild(blurNode)
            let mask = SKSpriteNode (color: UIColor.black, size: size)
            mask.anchorPoint = CGPoint.zero
            maskNode = mask
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    class BlurNode: SKEffectNode {
        var sprite: SKSpriteNode
        var texture: SKTexture {
            get { return sprite.texture! }
            set {
                sprite.texture = newValue
                let scale = UIScreen.main.scale
                let textureSize = newValue.size()
                sprite.size = CGSize(width: textureSize.width/scale, height: textureSize.height/scale)
                //sprite.size = CGSize(width: textureSize.width * 2, height: textureSize.height * 2)
            }
        }
        init(radius: CGFloat) {
            sprite = SKSpriteNode()
            super.init()
            sprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            addChild(sprite)
            filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": radius])
            shouldEnableEffects = true
            shouldRasterize = true
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    func blurBackground(){
        self.fundo.shouldEnableEffects = !self.fundo.shouldEnableEffects
    }
    
}
