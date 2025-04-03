//
//  Utils.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 2/4/25.
//

struct UserModel: Identifiable {
    var id: Int
    var username: String
    var userImage: String
    var points: Int
}

struct Utils {
    
    static let shared = Utils()
    
    var categories: [CategoryModel] = [
        CategoryModel(id: "0", name: "Kotlin", image: "https://upload.wikimedia.org/wikipedia/commons/7/74/Kotlin_Icon.png", type: "Language", numberQuizzess: 10),
        CategoryModel(id: "1", name: "Swift", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRP-NmkQzBEJWMHZiu12EQpS7jQ5LrblCcMFDCDZUzVgbvmJ9LzCukslXuaSdFw7pPqCVk&usqp=CAU", type: "Language", numberQuizzess: 10),
        CategoryModel(id: "2", name: "Android Studio", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Android_Studio_icon_%282023%29.svg/2048px-Android_Studio_icon_%282023%29.svg.png",  type: "IDE", numberQuizzess: 10),
        CategoryModel(id: "3", name: "Xcode", image: "https://w7.pngwing.com/pngs/505/718/png-transparent-xcode-macos-bigsur-icon-thumbnail.png",  type: "IDE", numberQuizzess: 10),
    ]
    
    var stats: [CategoryStatsModel] = [
        CategoryStatsModel(
            id: 0,
            categoryName: "Kotlin",
            categoryImage: "https://upload.wikimedia.org/wikipedia/commons/7/74/Kotlin_Icon.png",
            bestGameValue: 700,
            betterQuestionValue: 82,
            totalGames: 2,
            correctAnswers: 15,
            wrongAnswers: 5,
            categoryColor: .Colors.orangeTimer
        ),
        CategoryStatsModel(
            id: 1,
            categoryName: "Swift",
            categoryImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRP-NmkQzBEJWMHZiu12EQpS7jQ5LrblCcMFDCDZUzVgbvmJ9LzCukslXuaSdFw7pPqCVk&usqp=CAU",
            bestGameValue: 300,
            betterQuestionValue: 40,
            totalGames: 4,
            correctAnswers: 25,
            wrongAnswers: 15,
            categoryColor: .Colors.principalGreen
        ),
       CategoryStatsModel(
            id: 2,
            categoryName: "Android Studio",
            categoryImage: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Android_Studio_icon_%282023%29.svg/2048px-Android_Studio_icon_%282023%29.svg.png",
            bestGameValue: 100,
            betterQuestionValue: 20,
            totalGames: 1,
            correctAnswers: 4,
            wrongAnswers: 6,
            categoryColor: .Colors.questionErrorRed
        ),
    ]
    
    
   
    
    var users: [UserModel] = [
        UserModel(
            id: 1,
            username: "Lunaa",
            userImage: "https://res.cloudinary.com/dnuejyham/image/upload/v1729684310/bbxys1il4cppc2c6w0wo.jpg",
            points: 1200
        ),
        UserModel(
            id: 4,
            username: "Eric",
            userImage: "https://res.cloudinary.com/dnuejyham/image/upload/v1732275567/gtb1brrs4zqagyturppz.png",
            points: 1000
        ),
        UserModel(
            id: 5,
            username: "Clara",
            userImage: "https://res.cloudinary.com/dnuejyham/image/upload/v1732275720/zjyld4l96gsktgxhazsd.png",
            points: 900
        ),
        UserModel(
            id: 3,
            username: "David",
            userImage: "https://res.cloudinary.com/dnuejyham/image/upload/v1732275272/dnpsvqwfhj7suoklzmty.png",
            points: 600
        ),
        UserModel(
            id: 2,
            username: "Claudia",
            userImage: "https://res.cloudinary.com/dnuejyham/image/upload/v1729686912/zy7pdrporqxfdjwy5pcd.jpg",
            points: 500
        ),
        UserModel(
            id: 0,
            username: "Andres",
            userImage: "https://res.cloudinary.com/dnuejyham/image/upload/v1729874344/fe9db982af7848e2fe9851a9b838951f_hllslr.jpg",
            points: 300
        ),
        UserModel(
            id: 3,
            username: "Carlos",
            userImage: "https://res.cloudinary.com/dnuejyham/image/upload/v1732275272/dnpsvqwfhj7suoklzmty.png",
            points: 200
        ),
    ]
    
    var questions = [
        QuestionModel(id: "0", title: "¿Cuál es el resultado?", options: [], correctAnswer: "1,2"),
        QuestionModel(id: "1", title: "Kotlin es totalmente compatible con el código Java y puede usarse junto a él en el mismo proyecto", options: [OptionModel(value: "Verdadero", state: OptionState.Success), OptionModel(value: "Falso", state: OptionState.Error)], correctAnswer: "0"),
        QuestionModel(id: "2", title: "¿Cuál de las siguientes opciones es la forma correcta de declarar una variable inmutable en Kotlin?", options: [OptionModel(value: "val nombre = 'Kotlin'", state: OptionState.Default)], correctAnswer: "0"),
        QuestionModel(id: "3", title: "¿Quién es este jugador?", options: [OptionModel(value: "Andres", state: OptionState.Default)], correctAnswer: "0")
    ]
    
}
