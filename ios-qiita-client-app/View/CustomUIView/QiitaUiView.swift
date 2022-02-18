//
//  QiitaUiView.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/18.
//

import UIKit

class QiitaUiView: UIView {

    @IBOutlet weak var image: UIImageView!

    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var id: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    override func awakeFromNib() {
            super.awakeFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func loadNib() {
        if let view = Bundle(for: type(of:self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}
