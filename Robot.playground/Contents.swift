import UIKit

let validCommands = ["MOVE", "LEFT", "RIGHT", "REPORT"]
let validDirections = ["NORTH", "EAST", "SOUTH", "WEST"]
var robotCordinates = [Int]()


// Handing 'PLACE' Command

func setPosition(_ place:String){
    let placeArray = place.components(separatedBy: ",")
    if placeArray.count == 3{
        if placeArray[0].isValidMove && placeArray[1].isValidMove{
            if let direction = validDirections.firstIndex(of: placeArray[2]){
               robotCordinates = [Int(placeArray[0])!, Int(placeArray[1])!, direction]
            }
        }
    }
}

// Handing these commands: "MOVE", "LEFT", "RIGHT", "REPORT"

func executeCommand(_ value:Int){
    let currentDirection = robotCordinates[2]
    switch value {
    case 0:
        if (currentDirection == 0 && robotCordinates[1] < 4){
            robotCordinates[1] = robotCordinates[1]+1
        }else if (currentDirection == 1 && robotCordinates[0] < 4){
            robotCordinates[0] = robotCordinates[0]+1
        }else if (currentDirection == 2 && robotCordinates[1] > 0){
            robotCordinates[1] = robotCordinates[1]-1
        }else if (currentDirection == 3 && robotCordinates[0] > 0){
            robotCordinates[0] = robotCordinates[0]-1
        }
    case 1:
        if currentDirection > 0{
            robotCordinates[2] = currentDirection-1
        }else{
            robotCordinates[2] = 3
        }
    case 2:
        if currentDirection < 4{
            robotCordinates[2] = currentDirection+1
        }else{
            robotCordinates[2] = 0
        }
    default:
        var printableArray:[Any] = robotCordinates
        printableArray[2] = validDirections[robotCordinates[2]]
        print(printableArray)
    }
}

// Reading commands from text file

let fileURL = Bundle.main.url(forResource: "moves", withExtension: "txt")
let moves = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8).uppercased()
let movesArray = moves.components(separatedBy: .newlines)

for command in movesArray{
    if command.contains("PLACE"){
        let newPlace = command.trimmingCharacters(in: CharacterSet(charactersIn: "PLACE")).trimmingCharacters(in: .whitespaces)
        setPosition(newPlace)
    } else if !(robotCordinates.isEmpty){
        if let commandType = validCommands.firstIndex(of: command.trimmingCharacters(in: .whitespaces)){
            executeCommand(commandType)
        }
    }
}

// Validating move

extension String {
    var isValidMove: Bool {
        return (Int(self) != nil && Int(self)! >= 0 && Int(self)! <= 4)
    }
}
// Click Play button on left to run :) Thanks
