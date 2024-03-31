import Cocoa



enum Unite : Int {
    case seconds = 1, minutes = 60, hours = 3600, days = 86400
}
print(Unite.days.rawValue)







/*
enum GameError : Error {
    case NumberTooHigh
    case NumberTooSmall
}

func squareNumber(number: Int) throws ->  String{
    if(number > 10000){
        throw GameError.NumberTooHigh
    }
    if (number<1){
        throw GameError.NumberTooSmall
    }
    for i in 1...Int(number/2) {
        if i*i == number {
            return "square of \(number) is : \(i)"
        }
    }
    return "square is not an integer"
}

do{
    let squareNumberValue = try squareNumber(number: 0)
    print(squareNumberValue)
}catch GameError.NumberTooHigh{
    print("The input value is too high")
}catch GameError.NumberTooSmall{
    print("The input value is too small")
}

*/
