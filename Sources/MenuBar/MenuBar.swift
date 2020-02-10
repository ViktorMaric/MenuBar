//
//  MenuBar.swift
//  MenuBar
//
//  Created by Viktor Maric on 2020. 02. 09..
//  Copyright © 2020. Viktor Maric. All rights reserved.
//
import SwiftUI

@available(OSX 10.15, *)
@available(iOS 13.0, *)

/// Custom bar showing up to four different Views, works similary to segmented picker.
public struct MenuBar: View {
    
//    MARK: - variables
    /// Title for the first item.
    var firstTitle: String
    /// Title for the secondt item.
    var secondTitle: String
    /// Title for the third item.
    var thirdTitle: String?
    /// Title for the fourth item.
    var fourthTitle: String?
    
    /// Width of the MenuBar. For the full width use the GeometryReader.
    var width: CGFloat
    
    /// Color for the items.
    var textColor: Color
    /// Color for the line under the items.
    var lineColor: Color
    
    @State private var selectedValue: Int = 0
    
    @State private var lineOffset: CGFloat = 0
    
    var numberOfItems: CGFloat {
        if thirdView == nil && fourthView == nil {
            return 2
        } else if (thirdView != nil && fourthView == nil) || (thirdView == nil && fourthView != nil) {
            return 3
        } else if thirdView != nil && fourthView != nil {
            return 4
        } else {
            return 4
        }
    }
    
    /// The View for the first item.
    var firstView: AnyView
    /// The View for the second item.
    var secondView: AnyView
    /// The View for the third item. It is optional.
    var thirdView: AnyView?
    /// The View for the fourth item. It is optional.
    var fourthView: AnyView?
    
    public init(firstTitle: String, secondTitle: String, thirdTitle: String?, fourthTitle: String?, width: CGFloat, textColor: Color, lineColor: Color, firstView: AnyView, secondView: AnyView, thirdView: AnyView?, fourthView: AnyView?) {
        self.firstTitle = firstTitle
        self.secondTitle = secondTitle
        self.thirdTitle = thirdTitle
        self.fourthTitle = fourthTitle
        self.width = width
        self.textColor = textColor
        self.lineColor = lineColor
        self.firstView = firstView
        self.secondView = secondView
        self.thirdView = thirdView
        self.fourthView = fourthView
    }
    
//    MARK: - UI
    public var body: some View {
        
        VStack {
            HStack {
                
                Button(action: {
                    withAnimation {
                        self.selectedValue = 0
                        self.lineOffset = 0
                    }
                }) {
                    Text(firstTitle)
                        .foregroundColor(selectedValue == 0 ? textColor : textColor.opacity(0.8))
                }
                .frame(width: width/numberOfItems)
                
                Button(action: {
                    withAnimation {
                        self.selectedValue = 1
                        self.lineOffset = self.width / self.numberOfItems
                    }
                }) {
                    Text(secondTitle)
                        .foregroundColor(selectedValue == 1 ? textColor : textColor.opacity(0.8))
                }
                .frame(width: width/numberOfItems)
                
                if thirdView != nil {
                    Button(action: {
                        withAnimation {
                            self.selectedValue = 2
                            self.lineOffset = self.width / self.numberOfItems * 2
                        }
                    }) {
                        Text(thirdTitle ?? "nil")
                            .foregroundColor(selectedValue == 2 ? textColor : textColor.opacity(0.8))
                    }
                    .frame(width: width/numberOfItems)
                }
                
                if fourthView != nil {
                    Button(action: {
                        withAnimation {
                            self.selectedValue = 3
                            self.lineOffset = self.width / self.numberOfItems * 3
                        }
                    }) {
                        Text(fourthTitle ?? "nil")
                            .foregroundColor(selectedValue == 3 ? textColor : textColor.opacity(0.8))
                    }
                    .frame(width: width/numberOfItems)
                }
                
            }
            
            lineColor
                .frame(width: width*2, height: 2.5)
                .opacity(0.5)
                
            ZStack(alignment: .leading) {
                Color.clear
                    .frame(width: width, height: 2.5)
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.horizontal)
                lineColor
                    .frame(width: width/numberOfItems, height: 3)
                    .cornerRadius(1.5)
                    .offset(x: lineOffset)
            }
            .offset(y: -11)
            
            if selectedValue == 0 {
                firstView
                    .padding(.top, -19)
                    .edgesIgnoringSafeArea(.all)
            } else if selectedValue == 1 {
                secondView
                    .padding(.top, -19)
                    .edgesIgnoringSafeArea(.all)
            } else if selectedValue == 2 {
                thirdView
                    .padding(.top, -19)
                    .edgesIgnoringSafeArea(.all)
            } else if selectedValue == 3 {
                fourthView
                    .padding(.top, -19)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        
    }
    
}

//  MARK: - preview
@available(OSX 10.15, *)
@available(iOS 13.0, *)
struct MenuBar_Previews: PreviewProvider {
    
    static var previews: some View {
        MenuBar(firstTitle: "first", secondTitle: "second", thirdTitle: "third", fourthTitle: "fourth", width: 300, textColor: .primary, lineColor: .primary, firstView: AnyView(Text("1")), secondView: AnyView(Text("2")), thirdView: AnyView(Text("3")), fourthView: AnyView(Text("4")))
    }
    
}
