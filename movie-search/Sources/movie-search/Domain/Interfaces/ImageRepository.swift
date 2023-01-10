//
//  ImageRepository.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/10.
//

import Foundation
import UIKit

protocol ImageRepository: WebRepository  {
    func loadImage(url: String) async throws -> UIImage
}
