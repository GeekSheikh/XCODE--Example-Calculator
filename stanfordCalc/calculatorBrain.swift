//
//  calculatorBrain.swift
//  stanfordCalc
//
//  Created by Daniel Tomes on 12/25/16.
//  Copyright © 2016 Daniel Tomes. All rights reserved.
//

import Foundation

func multiply (op1: Double, op2: Double) -> Double {
    return op1 * op2
}

class CalculatorBrain
{
    private var accumulator = 0.0
    
    //Dictionary
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI), // M_PI,
        "e" : Operation.Constant(M_E), // M_E
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOperation({ $0 * $1 }), //Closures - lots of inference; replaces global multiply function in self
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "−" : Operation.BinaryOperation({ $0 - $1 }),
        "=" : Operation.Equals
    ]
    
   private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let op): accumulator = op(accumulator)
            case .BinaryOperation(let op):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: op, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    //Optional because only set it to value after operation (multiple) has been called otherwise, nil
    private var pending: PendingBinaryOperationInfo?
    
    //Struct is passed by value -> Not a reference to value in memory but the actual value
    //Default initializer (constructor) for Struct is all of its vars
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
