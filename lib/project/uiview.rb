
# scrollViewWillEndDragging:withVelocity:targetContentOffset:
# Tells the delegate when the user finishes scrolling the content.

# - (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
# Parameters
# scrollView
# The scroll-view object where the user ended the touch..
# velocity
# The velocity of the scroll view (in points) at the moment the touch was released.
# targetContentOffset
# The expected offset when the scrolling action decelerates to a stop.
# Discussion
# This method is not called when the value of the scroll view’s pagingEnabled property is YES. Your application can change the value of the targetContentOffset parameter to adjust where the scrollview finishes its scrolling animation.

# Availability
# Available in iOS 5.0 and later.
# Declared In
# UIScrollView.h


# scrollViewDidScroll:
# Tells the delegate when the user scrolls the content view within the receiver.

# - (void)scrollViewDidScroll:(UIScrollView *)scrollView
# Parameters
# scrollView
# The scroll-view object in which the scrolling occurred.
# Discussion
# The delegate typically implements this method to obtain the change in content offset from scrollView and draw the affected portion of the content view.

# Availability
# Available in iOS 2.0 and later.
# See Also
# – scrollViewWillBeginDragging:
# – scrollViewDidEndDragging:willDecelerate:
# Declared In
# UIScrollView.h





class UIView
    def shrink(args={})
        scale=args[:scale] || 0.1
        scale=args[:alpha] || 0
        zoom_out_to scale:scale, alpha:alpha
    end
    def explode
        zoom_out_to scale:4, alpha:0
    end
    def restore
        zoom_out_to scale:1, alpha:1
    end
#from https://github.com/colinta/sugarcube/blob/1.0
      def back_fiend!(options={})
    scale = options[:scale] || 0.5
    perspective = options[:perspective] || -0.0005
    size = options[:size] || -140

    UIView.animation_chain(duration:200.millisecs, options:UIViewAnimationOptionCurveLinear) {
      self.layer.transform = CATransform3DTranslate(CATransform3DScale(CATransform3D.new(1,0,0,0, 0,1,0,perspective, 0,0,1,0, 0,0,0,1), scale, scale, scale), 0, size, 0)
    }.and_then(duration:300.millisecs, options:UIViewAnimationOptionCurveLinear) {
      self.layer.transform = CATransform3DTranslate(CATransform3DScale(CATransform3DIdentity, scale, scale, scale), 0, size, 0)
    }.start
  end
#from https://github.com/colinta/sugarcube/blob/1.0
  # restores the layer after a call to 'back_fiend!'
  def forward_fiend!(options={})
    UIView.animate(options) do
      self.layer.transform = CATransform3DIdentity
    end
  end

    def zoom(args={})
        vw = args[:view] || self
        scale=args[:scale] || 1.0
        alpha=args[:alpha] || 1.0
        duration=args[:duration] || 0.5
        UIView.animateWithDuration(duration, delay:0, options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut, animations: lambda{vw.transform = CGAffineTransform.make(scale: scale); vw.alpha=alpha}, completion:nil)
    end
    def zoom_out_to(args={})
        zoom args
    end
    def perspective(args={})
        
        vw = args[:view] || self
        scale=args[:scale] || 1.0
        alpha=args[:alpha] || 1.0
        duration=args[:duration] || 0.5
        p = args[:amount] || [0,0.0004]
        UIView.animateWithDuration(duration, delay:0, options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut, animations: lambda{vw.layer.transform = CATransform3D.identity.perspective(p[0],p[1])}, completion:nil)
    end
    def perspective_and_grow(args={})

        
        vw = args[:view] || self
        scale=args[:scale] || 2.0
        alpha=args[:alpha] || 1.0
        duration=args[:duration] || 0.5
        p = args[:amount] || [0,0.0004]
        UIView.animateWithDuration(duration, delay:0, options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut, animations: lambda{vw.layer.transform = CATransform3D.identity.scale(scale).perspective(p[0],p[1])}, completion:nil)
    end
    def gradient(a,b=nil)
        if b.nil?
            b = a[1]
            a = a[0]
        end

        gradient = CAGradientLayer.layer
        gradient.frame = self.bounds
        gradient.colors = [a.uicolor.CGColor,b.uicolor.CGColor]
        self.layer.addSublayer(gradient) 
    end
    def gradient2(locs,colors)
        

        gradient = CAGradientLayer.layer
        gradient.frame = self.bounds
        gradient.colors = colors.map{|c|c.uicolor.CGColor}
        gradient.locations = locs
        self.layer.addSublayer(gradient) 
    end
    def appear
        fade_in(duration:0.1+rand,delay:(0.1+rand)/2,options:UIViewAnimationOptionCurveEaseIn,opacity:1.0)
    end
    def vanish
        fade_out(duration:0.1+rand,delay:(0.1+rand)/2,options:UIViewAnimationOptionCurveEaseOut,opacity:0.0)
    end

    
    def kill
        destroy
    end
    def destroy
        #dealloc?
        removeFromSuperview
    end
    def cut
        lift
    end
    
    def wiggle
        shake offset: 0.1, repeat: 2, duration: 0.5, keypath: 'transform.rotation'
    end
    def shake_up_down
        shake offset: 5, repeat: 4, duration: 0.78, keypath: 'transform.translation.y'
    end
    def shake_left_right
        shake #offset: 5, repeat: 4, duration: 0.78, keypath: 'transform.translation.x'
    end
    
    def join(uiview)
        paste(uiview)
    end
    
    def inset!(ei=EdgeInsets(10))
        self.frame = self.frame.inset(ei)
    end
    def shadow!(args={})
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = args[:radius] || 5
        self.layer.shadowOffset = [0,0]
        self.layer.shadowColor = :black.uicolor.CGColor
        # self.layer.shouldRasterize = true
    end
    def round!(rad=5)
        self.layer.cornerRadius = rad
        self.layer.masksToBounds = true
    end
    def height
        frame.height
    end
    def width
        frame.width
    end
end



