//
//  ImageDownloader.swift
//  Agrume
//

import Foundation

final class ImageDownloader {

  class func downloadImage(_ url: URL, completion: (image: UIImage?) -> Void) -> URLSessionDataTask? {
    let session = URLSession.shared()
    let request = URLRequest(url: url)
    let dataTask = session.dataTask(with: request) { data, _, error in
      guard error == nil else {
        completion(image: nil)
        return
      }
      DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes.qosUserInitiated).async {
        guard let data = data, image = UIImage(data: data) else {
          completion(image: nil)
          return
        }
        DispatchQueue.main.async {
          completion(image: image)
        }
      }
    }
    dataTask.resume()
    return dataTask
  }

}
