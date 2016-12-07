import UIKit
import XCTest
import VIPERS_Converter
import VIPERS_Converter_Protocol


class StringToOtherStringConverter : ConverterProtocol{
    
    func isResponibleForOutputType<T>(_ type:T.Type) -> Bool{
        if type is String.Type {
            return true
        }
        return false
    }
    
    func isResponsible(_ input:Any) throws -> Bool{
        
        if input is String{
            return true
        }
        
        return false
    }
    
    func convert(_ input: Any) throws -> Any{
        if let string = input as? String{
            return "modified " + string
        }
        return "Hey dude give me a string man"
    }

}

class DateToNextDayConverter : ConverterProtocol{
    
    func isResponibleForOutputType<T>(_ type:T.Type) -> Bool{
        if type is Date.Type {
            return true
        }
        return false
    }
    
    func isResponsible(_ input:Any) throws -> Bool{
        
        if input is Date{
            return true
        }
        
        return false
    }
    
    func convert(_ input: Any) throws -> Any{
        if let date = input as? Date{
            return date.addingTimeInterval(60*60*24)
        }
        return Date()
    }
    
}




class ComposedConverterTests: XCTestCase {
    
    func testValidConversions() {
    
        do{
        
            let composedConverter = ComposedConverter()
            
            let stringConverter = StringToOtherStringConverter()
            composedConverter.addConverter(stringConverter)
            
            let dateConverter = DateToNextDayConverter()
            composedConverter.addConverter(dateConverter)
            
            let newString : String = try composedConverter.convert("TestString")
            XCTAssertEqual(newString, "modified TestString")
            
            let date = Date()
            let newDate : Date = try composedConverter.convert(date)
            XCTAssertEqual(newDate, date.addingTimeInterval(60*60*24))
            
        }catch _ {
            XCTFail()
        }
    }
    
    func testInValidConversion(){
        
        do{
            
            let composedConverter = ComposedConverter()
        
            let _ : String = try composedConverter.convert("TestString")
            XCTFail("convert should throw an error with this configuration")
            
        } catch ComposedConverterError.noConverterForInputFound{
            XCTAssertTrue(true, "There should be an ComposedConverterError.noConverterForInputFound error")
        } catch _ {
            XCTFail()
        }
    }
    
}
