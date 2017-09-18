# AnimatableTabBarItem

## Create an animatable tab bar item

```swift
func playBounceAnimation(_ icon: UIImageView)
	{
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
		
		// During the animation, Core Animation generates intermediate values by interpolating between the values you provide.
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
		//bounceAnimation.values = [1.0, 2.0, 3.0, 2.0, 1.0]	// just for test HZ
		
		bounceAnimation.duration = TimeInterval(duration)
		
		// Specifies how intermediate keyframe values are calculated by the receiver.
        bounceAnimation.calculationMode = kCAAnimationCubic
        
        icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
        
        if let iconImage = icon.image {
            icon.image = iconImage.withRenderingMode(.alwaysOriginal)
            icon.tintColor = iconSelectedColor
        }
    }
```

Happy coding! :+1:  :sparkles:
