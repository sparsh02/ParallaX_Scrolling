//
//
//  ContentView.swift
//  Firewatch-Parallax-Effect
//
//  Created by Haipp on 02.06.21.
//  


import SwiftUI

struct ContentView: View {
	
	let images = [
		"img-1",
		"img-2",
		"img-3",
		"img-4",
		"img-5",
		"img-6",
		"img-7",
		"img-8",
		"img-9",
	]
	
	@State private var scrollOffsetY: CGFloat = 0
	
	var body: some View {
		ScrollView(showsIndicators: false) {
			VStack(spacing: -1) {
				// HACK to get current offset of the scrollView!
				GeometryReader { reader -> Color in
					DispatchQueue.main.async {
						scrollOffsetY = reader.frame(in: .named("scrollView")).minY
					}
					return Color.clear
				}
				.frame(height: 0)
				
				ZStack {
					ForEach(images.indices, id: \.self) { i in
						let img = images[i]
						Image(img)
							.resizable()
							.scaledToFit()
							.offset(y: getImageOffsetY(index: i))
					}
				}
				.clipped()
				
				VStack(alignment: .leading, spacing: 20) {
					mainText
				}
				.foregroundColor(Color(hue: 0.114, saturation: 1.0, brightness: 1.0))
				.padding(.horizontal)
				.padding(.vertical, 150)
				.frame(maxWidth: .infinity)
				.background(Color(hue: 0.99, saturation: 1.0, brightness: 0.129))
			}
		}
		.coordinateSpace(name: "scrollView")
		.background(backgroundView)
		.ignoresSafeArea(edges: .bottom)
		.statusBar(hidden: true)
	}
	
	
	var mainText: some View {
		Group {
			Text("Firewatch is a mystery set in the Wyoming wilderness, where your only emotional lifeline is the person on the other end of a handheld radio.")
				.font(.system(size: 22, weight: .heavy, design: .serif))
			
			Group {
				Text("The year is 1989.")
				Text("You are a man named Henry who has retreated from your messy life to work as a fire lookout in the Wyoming wilderness. Perched atop a mountain, it's your job to find smoke and keep the wilderness safe.")
				Text("An especially hot, dry summer has everyone on edge. Your supervisor, a woman named Delilah, is available to you at all times over a small, handheld radio—and is your only contact with the world you've left behind.")
				Text("But when something strange draws you out of your lookout tower and into the world below, you'll explore a wild and unknown environment, facing questions and making interpersonal choices that can build or destroy the only meaningful relationship you have.")
			}
			.font(.system(size: 19, weight: .regular, design: .serif))
		}
	}
	
	
	func getImageOffsetY(index: Int) -> CGFloat {
		if index == 8 { return 0 }
		var multiplier: CGFloat = 5
		if scrollOffsetY > 0 {
			multiplier = 2
		}
		return -scrollOffsetY / (CGFloat(index) / 9 * multiplier + 1)
	}
	
	
	var backgroundView: some View {
		VStack(spacing: 0) {
			Color(hue: 0.108, saturation: 0.894, brightness: 1.0)
			Color(hue: 0.99, saturation: 1.0, brightness: 0.129)
		}
		.ignoresSafeArea()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
