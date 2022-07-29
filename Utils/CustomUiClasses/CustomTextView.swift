//
//  CustomTextView.swift
//  CFL
//
//  Created by synchsofthq on 27/07/21.
//

import Foundation
import UIKit
@IBDesignable
public class CustomTextView: UITextView {
    @IBInspectable var AppFontNameBoldRegularMedium:String {
        get {
            return self.font!.fontName
        }
        set( fontValue) {
            if  ( fontValue == "B"){
                self.font = UIFont(name: FONT_BOLD, size: self.font!.pointSize)
            }
            else if  ( fontValue == "R"){
                self.font = UIFont(name: FONT_REG, size: self.font!.pointSize)
            }
            else{
                self.font = UIFont(name: FONT_MEDIUM, size: self.font!.pointSize)
            }
            
        }
    }
    @IBInspectable var GlobalAppTextColor:Bool {
        get {
            return false
        }
        set( value) {
            if value {
                self.textColor = TEXT_UICOLOR
                
            }
            else{
                self.textColor = .label
                
            }
        }
    }
    
    @IBInspectable var RoundCorner:Bool {
        get {
            return false
        }
        set( value) {
            if value {
                self.layer.cornerRadius = self.frame.size.height/2
                
                self.layer.masksToBounds = true
            }
            else{
                self.layer.cornerRadius = 0
                
                self.layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable var border:CGFloat {
        get {
            return 0.0
        }
        set( value) {
            self.layer.borderWidth = value
            self.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    @IBInspectable var setPadding:CGFloat {
        get {
            return 0.0
        }
        set( value) {
            setRightPaddingPoints(value)
        }
    }
    
   
    
       func setRightPaddingPoints(_ amount:CGFloat) {
        self.contentInset = UIEdgeInsets(top: 0, left: amount, bottom: 0, right: amount)
       
       }

}

class HashtagLable: UITextView {

  let hashtagRegex = "#[-_0-9A-Za-z]+"

  private var cachedFrames: [CGRect] = []

  private var backgrounds: [UIView] = []

  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    configureView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configureView()
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    // Redraw highlighted parts if frame is changed
    textUpdated()
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  @objc private func textUpdated() {
    // You can provide whatever ranges needed to be highlighted
    let ranges = resolveHighlightedRanges()

    let frames = ranges.compactMap { frame(ofRange: $0) }.reduce([], +)

    if cachedFrames != frames {
      cachedFrames = frames

      backgrounds.forEach { $0.removeFromSuperview() }
      backgrounds = cachedFrames.map { frame in
        
        let background = UIView()
        background.backgroundColor = PLACEHOLDER_UICOLOR
        background.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: 30)
        background.layer.cornerRadius = 15
        insertSubview(background, at: 0)
        return background
      }
    }
  }

  /// General setup
  private func configureView() {
    NotificationCenter.default.addObserver(self, selector: #selector(textUpdated), name: UITextView.textDidChangeNotification, object: self)
  }

  /// Looks for locations of the string to be highlighted.
  /// The current case - ranges of hashtags.
  private func resolveHighlightedRanges() -> [NSRange] {
    guard text != nil, let regex = try? NSRegularExpression(pattern: hashtagRegex, options: []) else { return [] }

    let matches = regex.matches(in: text, options: [], range: NSRange(text.startIndex..<text.endIndex, in: text))
    let ranges = matches.map { $0.range }
    return ranges
  }
}

extension UITextView {
  func convertRange(_ range: NSRange) -> UITextRange? {
    let beginning = beginningOfDocument
    if let start = position(from: beginning, offset: range.location), let end = position(from: start, offset: range.length) {
      let resultRange = textRange(from: start, to: end)
      return resultRange
    } else {
      return nil
    }
  }

  func frame(ofRange range: NSRange) -> [CGRect]? {
    if let textRange = convertRange(range) {
      let rects = selectionRects(for: textRange)
      return rects.map { $0.rect }
    } else {
      return nil
    }
  }
}

