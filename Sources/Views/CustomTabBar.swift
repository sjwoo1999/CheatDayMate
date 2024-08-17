import SwiftUI

struct CustomTabBar: View {
    @ObservedObject var viewModel: CustomTabBarViewModel
    var onPlusButtonTap: () -> Void
    
    // New constant for padding
    private let horizontalPadding: CGFloat = 16
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Tab bar body
                TabBarShape()
                    .fill(Color.white)
                    .overlay(
                        TabBarShape()
                            .stroke(Color(hex: "#FC6A03"), lineWidth: 2)
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
                    .frame(height: 60)
                
                // Icons
                HStack(spacing: 0) {
                    ForEach(0..<5) { index in
                        if index == 2 {
                            Spacer().frame(width: (geometry.size.width - 2 * horizontalPadding) / 5)
                        } else {
                            tabIcon(index: index < 2 ? index : index - 1)
                                .frame(width: (geometry.size.width - 2 * horizontalPadding) / 5)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        viewModel.selectTab(index < 2 ? index : index - 1)
                                    }
                                }
                        }
                    }
                }
                
                // Center '+' button
                Button(action: onPlusButtonTap) {
                    ZStack {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 56, height: 56)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                        
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .offset(y: -50)
            }
            .padding(.horizontal, horizontalPadding)
        }
        .frame(height: 60)
    }
    
    private func tabIcon(index: Int) -> some View {
        let icons = ["calendar", "doc.text", "person.2", "person.crop.circle"]
        return VStack(spacing: 4) {
            Image(systemName: icons[index])
                .foregroundColor(viewModel.selectedTab == index ? .orange : .gray)
                .font(.system(size: 20))
            
            Circle()
                .fill(viewModel.selectedTab == index ? Color.orange : Color.clear)
                .frame(width: 4, height: 4)
        }
        .frame(height: 60)
    }
}

struct TabBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        let cornerRadius: CGFloat = 20
        let archHeight: CGFloat = 30 // Reduced arch height
        let archWidth: CGFloat = 80 // Reduced arch width
        let archCenterX = width / 2
        
        // Start point (top left)
        path.move(to: CGPoint(x: 0, y: cornerRadius))
        
        // Top left corner
        path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 270),
                    clockwise: false)
        
        // From top left to arch start
        path.addLine(to: CGPoint(x: archCenterX - archWidth/2, y: 0))
        
        // U-shaped arch (using cubic Bezier curve)
        let controlPoint1 = CGPoint(x: archCenterX - archWidth/4, y: archHeight)
        let controlPoint2 = CGPoint(x: archCenterX + archWidth/4, y: archHeight)
        path.addCurve(to: CGPoint(x: archCenterX + archWidth/2, y: 0),
                      control1: controlPoint1,
                      control2: controlPoint2)
        
        // From arch end to top right
        path.addLine(to: CGPoint(x: width - cornerRadius, y: 0))
        
        // Top right corner
        path.addArc(center: CGPoint(x: width - cornerRadius, y: cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 270),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        
        // Right edge
        path.addLine(to: CGPoint(x: width, y: height - cornerRadius))
        
        // Bottom right corner
        path.addArc(center: CGPoint(x: width - cornerRadius, y: height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)
        
        // Bottom edge
        path.addLine(to: CGPoint(x: cornerRadius, y: height))
        
        // Bottom left corner
        path.addArc(center: CGPoint(x: cornerRadius, y: height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)
        
        // Back to left edge
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
        
        return path
    }
}
