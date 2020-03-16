//
//  DLog.swift
//
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

func DLog(_ functionName:String = #function, fileName:NSString = #file, line: Int = #line, message:String)
{
    /***** Will only DLog in Debug mode. *****/
    
    /* For this to work, add the "-D DEBUG" flag to the "Swift Compiler - Custom Flags" to Debug mode, under Build Settings.  */
    #if DEBUG
        print("SSLogger: Original_Message = \(message)\n Method_Name = \(functionName)\n File_Name = \(fileName.lastPathComponent) Line: \(line)");
    #endif
}

func DLog(_ items: Any)
{
    /***** Will only DLog in Debug mode. *****/
    
    /* For this to work, add the "-D DEBUG" flag to the "Swift Compiler - Custom Flags" to Debug mode, under Build Settings.  */
    #if DEBUG
        print(items);
    #endif
}
