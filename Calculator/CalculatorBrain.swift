//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by user on 30/06/16.
//  Copyright © 2016 gnobel. All rights reserved.
//

import Foundation

func multiply(x: Double, y: Double) -> Double {
    return x * y
}

func divide(x: Double, y:Double) -> Double  {
    return x / y
}

class CalculatorBrain  {
    
    private var accumulator = 0.0
    
    func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    private var operations = [ // <String,Operation>
        "π" : Operation.Constant(M_PI), //M_PI,
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "log" : Operation.UnaryOperation(log),
        "+": Operation.BinaryOperation(+),
        "-": Operation.BinaryOperation(-),
        "×": Operation.BinaryOperation(multiply),
        "÷": Operation.BinaryOperation(divide),
        "=": Operation.Equals
    ]
    
    // both enum and struct are PASSED-BY-VALUE (not reference)
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        
        
    }

    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let unaryOp):
                accumulator = unaryOp(accumulator)
            case .BinaryOperation: break
            case .Equals: break // don't need default since enum is full specified.
            }
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
