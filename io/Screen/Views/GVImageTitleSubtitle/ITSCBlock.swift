//
//  GVImageTitleSubtitle.swift
//  io
//
//  Created by gv on 31/08/2023.
//

import UIKit

class ITSCBlock: UIView, NibLoadableView {
    
    @IBOutlet private weak var imageStack: UIStackView!
    @IBOutlet weak var leftImage: UIImageView!
    
    @IBOutlet private weak var textStack: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var captionLabel: UILabel!
    
    var leftViewAlignment: UIStackView.Alignment = .top {
        willSet {
            imageStack.alignment = newValue
        }
    }
    
    // MARK: - Spacing
    var imageStackSpacing: CGFloat = 0 {
        willSet {
            imageStack.spacing = newValue
        }
    }
    
    var textStackSpacing: CGFloat = 0 {
        willSet {
            textStack.spacing = newValue
        }
    }
    
    // MARK: - Content
    var titleContent: NSAttributedString = .init() {
        willSet {
            titleLabel.attributedText = newValue
        }
    }
    
    var subtitleContent: NSAttributedString = .init() {
        willSet {
            subtitleLabel.attributedText = newValue
        }
    }
    
    var captionContent: NSAttributedString = .init() {
        willSet {
            captionLabel.attributedText = newValue
        }
    }
    
    // MARK: - Show/Hide
    var isHideLeftImage: Bool = true {
        willSet {
            leftImage.isHidden = newValue
        }
    }
    
    var isHideSubtitle: Bool = true {
        willSet {
            subtitleLabel.isHidden = newValue
        }
    }
    
    var isHideCaption: Bool = true {
        willSet {
            captionLabel.isHidden = newValue
        }
    }
    
    var didTapImageAction: EmptyHandler?
    var didTapTitleAction: EmptyHandler?
    var didTapSubtitleAction: EmptyHandler?
    var didTapCaptionAction: EmptyHandler?
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepare()
    }
    
    func prepare() {
        loadViewFromNib()
        
        textStack.alignment = .leading
        
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        leftImage.isUserInteractionEnabled = true
        leftImage.addGestureRecognizer(tapImage)
        
        let tapTitle = UITapGestureRecognizer(target: self, action: #selector(didTapTitle))
        titleLabel.isUserInteractionEnabled = true
        titleLabel.addGestureRecognizer(tapTitle)
        
        let tapSubtitle = UITapGestureRecognizer(target: self, action: #selector(didTapSubtitle))
        subtitleLabel.isUserInteractionEnabled = true
        subtitleLabel.addGestureRecognizer(tapSubtitle)
        
        let tapCaption = UITapGestureRecognizer(target: self, action: #selector(didTapCaption))
        captionLabel.isUserInteractionEnabled = true
        captionLabel.addGestureRecognizer(tapCaption)
    }

    // MARK: - Action
    @objc private func didTapImage() {
        didTapImageAction?()
    }
    
    @objc private func didTapTitle() {
        didTapTitleAction?()
    }
    
    @objc private func didTapSubtitle() {
        didTapSubtitleAction?()
    }
    
    @objc private func didTapCaption() {
        didTapCaptionAction?()
    }
}
