import SwiftUI

struct DashboardView: View {
    var title: String
    @State var value: Int
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 3)
                .frame(width: 350)
            VStack {
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.primary)
                    .padding(.top, 8)
                    .multilineTextAlignment(.center)

                Text("\(value)") // Display the state variable
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding(.vertical, 12)

                HStack(spacing: 40) {
                    Button(action: {
                        self.value -= 1 // Decrement action
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.red)
                    }

                    Button(action: {
                        self.value += 1 // Increment action
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.green)
                    }
                }
                .padding(.bottom, 8)
                Image("Medicina")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.all)
                    .clipShape(Circle())
                    .frame(width: 300)
            }
            .padding(.horizontal)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(title: "Medicine taken on time", value: 0)
            .previewLayout(.sizeThatFits)
    }
}
