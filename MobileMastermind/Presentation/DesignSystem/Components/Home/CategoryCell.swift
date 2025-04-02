//
//  CategoryCell.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/4/25.
//

import SwiftUI

struct CategoryModel: Identifiable, Hashable {
    let id: String
    let name: String
    let image: String
    let type: String
    let numberQuizzess: Int
}

struct CategoryCell: View {
    var category: CategoryModel
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: URL(string: category.image)) { image in
                image.resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(.rect(topLeadingRadius: 10, bottomLeadingRadius: 10))
            } placeholder: {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
            
            
            VStack(alignment: .leading) {
                Text(category.name)
                    .boldStyle(size: 15, color: .black)
                
                Text("\(category.type) - \(category.numberQuizzess) preguntas")
                    .regularStyle(size: 15, color: .black)
            }
            
            Spacer()
            
            Button(action: {}, label: {
                Image("RightArrow")
                    .padding(.trailing, 20)
            })
        }
        .frame(minHeight: 80)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
        )
    }
}

#Preview {
    CategoryCell(category: Utils.shared.categories[0])
}
