//
//  File.swift
//  
//
//  Created by Damodar, Namala
//

import Foundation

public enum AnyError: Error {  }
public typealias Handler<Response> = (Result<Response, AnyError>) -> Void

/* Usage::
 struct Post {  }
 struct Book {  }
 
 
 func fetchPost(id: Int, _ completion: Handler<Post>) { … }
 func fetchPosts(_ completion: Handler<[Post]>) { … }
 func fetchBooks(_ completion: Handler<[Book]>) { … }
 */
