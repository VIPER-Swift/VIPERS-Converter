//
//  Converter.swift
//  Pods
//
//  Created by Jan Bartel on 14.04.16.
//
//

import Foundation
import VIPERS_Converter_Protocol

public enum ComposedConverterError : Error{
    case noConverterForInputFound(input: Any)
}

open class ComposedConverter : ComposedConverterProtocol{
    
    var converters : [ConverterProtocol] = [ConverterProtocol]()
    
    public init(){}
    
    open func isResponibleForOutputType<T>(_ type:T) -> Bool{
        for converter in converters{
            if converter.isResponibleForOutputType(T){
                return true
            }
        }
        return false
    }
    
    open func isResponsible(_ input: Any) throws -> Bool {
        for converter in converters{
            if try converter.isResponsible(input){
                return true
            }
        }
        return false
    }
    
    open func addConverter(_ converter: ConverterProtocol){
        self.converters.append(converter)
    }
    
    open func convert<O>(_ input: Any) throws -> O{
    
        for converter in self.converters.reversed(){
            if(try converter.isResponsible(input) && converter.isResponibleForOutputType(O)){
                return try converter.convert(input) as! O
            }
        }
        
        throw ComposedConverterError.noConverterForInputFound(input: input)
    }
}

