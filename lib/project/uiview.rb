
class UIView
	def zoom_out_to(args={})
		vw = args[:view] || self
		scale=args[:scale] || 1.0
		alpha=args[:alpha] || 1.0
		duration=args[:duration] || 0.5
		UIView.animateWithDuration(duration, delay:0, options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut, animations: lambda{vw.transform = CGAffineTransform.make(scale: scale); vw.alpha=alpha}, completion:nil)
	end
	def appear
		fade_in(duration:0.1+rand,delay:(0.1+rand)/2,options:UIViewAnimationOptionCurveEaseIn,opacity:1.0)
	end
	def vanish
		fade_out(duration:0.1+rand,delay:(0.1+rand)/2,options:UIViewAnimationOptionCurveEaseOut,opacity:0.0)
	end

	def views
		subviews
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
	def lift
		removeFromSuperview
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
	def bcolor=(uicolor)
		self.backgroundColor = uicolor
	end
	def tack(uiview)
		paste(uiview)
	end
	def join(uiview)
		paste(uiview)
	end
	def paste(uiview)
		self.addSubview(uiview)
		uiview
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
