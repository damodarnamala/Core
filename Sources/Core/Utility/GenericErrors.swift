//
//  File.swift
//  
//
//  Created by Damodar, Namala
//

import Foundation

enum AnyError: Error {  }
typealias Handler<Response> = (Result<Response, AnyError>) -> Void

/* Usage::
 struct Post {  }
 struct Book {  }
 
 
 func fetchPost(id: Int, _ completion: Handler<Post>) { … }
 func fetchPosts(_ completion: Handler<[Post]>) { … }
 func fetchBooks(_ completion: Handler<[Book]>) { … }
 */
