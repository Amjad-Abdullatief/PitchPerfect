//
//  ColorsOfNavigationBar.swift
//  PitchPerfect
//
//  Created by AMJAD - on 19/01/1441 AH.
//  Copyright © 1441 Udacity. All rights reserved.
//

class ColorsOfNavigationBar {
    func TransparentNavigationBar (){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
}
