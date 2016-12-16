//
//  SwiftGoogleTranslate.swift
//  SwiftGoogleTranslateAPI
//
//  Created by Muh Rusdi on 12/17/16.
//
//

import Foundation

open class SwiftGoogleTranslate {
    public var apiKey = ""
    
    public init() { }
    
    open func translate(translate: Translate, completion: @escaping (_ text: String) -> ()) {
        guard apiKey != "" else {
            print("Warning: You should set the api key before calling the translate method.")
            return
        }
        
        if let url = translate.text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            if let url = URL(string: "https://www.googleapis.com/language/translate/v2?key=\(self.apiKey)&q=\(url)&source=\(translate.from)&target=\(translate.to)&format=text") {
                let request = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard error == nil else {
                        print("Something went wrong: \(error?.localizedDescription)")
                        return
                    }
                    
                    guard (response as! HTTPURLResponse).statusCode == 200 else {
                        print("Something went wrong: \(data)")
                        return
                    }
                    do {
                        if let data = data {
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                                if let jsonData = json["data"] as? [String: Any] {
                                    if let translations = jsonData["translations"] as? [[String: Any]] {
                                        if let translation = translations.first {
                                            if let translatedText = translation["translatedText"] as? String {
                                                completion(translatedText)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } catch {
                        print("Serialization failed: \(error.localizedDescription)")
                    }
                }
                request.resume()
            }
        }
    }
}
