package com.example.calculatorsimple;

public class Calculator {
    public Calculator() {
    }
    public double calculate(double a, double b, String operator) throws RuntimeException{
        switch (operator){
            case "+":
                return (a + b);
            case "-":
                return (a - b);
            case "/":
                if (b != 0) return (a / b);
                else throw new ArithmeticException("Lỗi chia cho 0");
            case "*":
                return (a * b);
            default:
                throw new RuntimeException("Phép tính không đúng");
        }

        
    }
}
