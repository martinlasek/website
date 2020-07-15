//
//  ExpressibleByUUID.swift
//  App
//
//  Created by Martin Lasek on 13.07.20.
//
import Foundation

protocol ExpressibleByUUID {
  var uuid: UUID { get set }
  
  init(uuid: UUID)
}
