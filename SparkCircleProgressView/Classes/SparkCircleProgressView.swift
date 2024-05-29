//
//  SparkCircleProgressView.swift
//  SparkCircleProgressView
//
//  Created by sfh on 2024/5/29.
//

import UIKit

public class SparkCircleProgressView: UIView {
    
    /// 点击播放按钮的回调
    public var playCallBack:((Bool) -> ())?
    
    /// 进度
    @IBInspectable public var progress: CGFloat = 0 {
        didSet {
            circleView.progress = progress
        }
    }
    
    /// 背景线宽
    @IBInspectable public var lineWith: CGFloat = 2.0 {
        didSet {
            circleView.lineWith = lineWith
        }
    }
    
    /// 背景线色
    @IBInspectable public var lineColor: UIColor = .blue{
        didSet {
            circleView.lineColor = lineColor
        }
    }
    
    /// 进度线宽
    @IBInspectable public var proLineWith: CGFloat = 2.0 {
        didSet {
            circleView.proLineWith = proLineWith
        }
    }
    
    /// 进度线色，支持渐变
    @IBInspectable public var proColors: [Any] = [UIColor.red.cgColor, UIColor.systemTeal.cgColor]{
        didSet {
            circleView.proColors = proColors
        }
    }
    
    /// 播放状态
    @IBInspectable public var isPlaying: Bool = false {
        didSet {
            playBtn.isSelected = isPlaying
        }
    }
    
    /// 按钮默认图片
    @IBInspectable public var normalImg: UIImage? = nil {
        didSet {
            playBtn.setImage(normalImg, for: .normal)
        }
    }
    
    /// 按钮选中图片
    @IBInspectable public var selectedImg: UIImage?  = nil  {
        didSet {
            playBtn.setImage(selectedImg, for: .selected)
        }
    }
    
    /// 文字内容
    @IBInspectable public var text: String = "" {
        didSet {
            alphaLabel.text = text
        }
    }
    
    /// 文字颜色
    @IBInspectable public var textColor: UIColor = .blue {
        didSet {
            alphaLabel.textColor = textColor
        }
    }
    
    /// 文字对齐方式
    @IBInspectable public var align: NSTextAlignment = .left {
        didSet {
            alphaLabel.textAlignment = align
        }
    }
    
    /// 文字字体
    @IBInspectable public var textFont: UIFont = UIFont.systemFont(ofSize: 12, weight: .medium) {
        didSet {
            alphaLabel.font = textFont
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.9687491059, green: 0.9721953273, blue: 0.9813622832, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        loadViews()
    }
    
    func loadViews() {
        self.addSubview(circleView)
        self.addSubview(playBtn)
        self.addSubview(alphaLabel)
        
        let btnWH: CGFloat = self.bounds.height / 2
        
        circleView.frame = CGRect(x: 0, y: 0, width: self.bounds.height, height: self.bounds.height)
        playBtn.frame = CGRect(x: (self.bounds.height - btnWH) / 2, y: (self.bounds.height - btnWH) / 2, width: btnWH, height: btnWH)
        alphaLabel.frame = CGRect(x: self.bounds.height + 5, y: 0, width: self.bounds.width - self.bounds.height - 5 - 8, height: self.bounds.height)
    }
    
    //MARK: - click event
    
    @objc func playClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.playCallBack?(sender.isSelected)
    }
    
    //MARK: - lazyload
    
    lazy var circleView: SparkCircleView = {
        let circle = SparkCircleView()
        circle.lineWith = 2.0
        circle.lineColor = #colorLiteral(red: 0, green: 0.6233735085, blue: 1, alpha: 1)
        circle.progress = 0.5
        return circle
    }()
    
    lazy var playBtn: UIButton = {
        let path = Bundle.main.path(forResource: "SparkCircleProgressView", ofType: "bundle")
        let bundle = Bundle(path: path!)
        let playImg = UIImage(named: "play.png", in: bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        let pauseImg = UIImage(named: "pause.png", in: bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        
        let btn = UIButton(type: .custom)
        btn.setImage(playImg, for: .normal)
        btn.setImage(pauseImg, for: .selected)
        btn.addTarget(self, action: #selector(playClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var alphaLabel: UILabel = {
        let label = UILabel()
        label.text = "播放音频"
        label.textColor = #colorLiteral(red: 0, green: 0.6233735085, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .left
        return label
    }()

}
