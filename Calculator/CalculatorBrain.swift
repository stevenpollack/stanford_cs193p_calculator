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
        "log₁₀" : Operation.UnaryOperation(log10),
        "ln" : Operation.UnaryOperation(log),
        "Rand": Operation.UnaryOperation(float(arc4random() % 10)),
        "%" : Operation.UnaryOperation { $0 / 100.0 },
        "⁺⁄-" : Operation.UnaryOperation { -$0 },
        "sin" : Operation.UnaryOperation(sin),
        "cos" : Operation.UnaryOperation(cos),
        "tan" : Operation.UnaryOperation(tan),
        "sinh" : Operation.UnaryOperation(sinh),
        "cosh" : Operation.UnaryOperation(cosh),
        "tanh" : Operation.UnaryOperation(tanh),
        "eˣ" : Operation.UnaryOperation(exp),
        "10ˣ" : Operation.UnaryOperation { pow(10, $0) },
        "EE" : Operation.BinaryOperation { $0 * pow(10, $1) },
        "ʸ√" : Operation.BinaryOperation { pow($0, 1/$1) },
        "xʸ" : Operation.BinaryOperation { pow($0, $1) },
        "+": Operation.BinaryOperation { $0 + $1 },
        "-": Operation.BinaryOperation { $0 + $1 },
        "×": Operation.BinaryOperation { $0 * $1 },
        "÷": Operation.BinaryOperation { $0 / $1 },
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
