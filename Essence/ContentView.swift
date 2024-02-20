//
//  ContentView.swift
//  Essence
//
//  Created by user248952 on 2/12/24.
//

import SwiftUI

struct ContentView: View {
    
    // Declaration de mes proprietes
    let city: [String] = ["Bathurst", "Moncton", "Saint-Jean", "Fredericton", "Edmundston"]
    
    @State private var selectCityFirstMenu = ""
    @State private var selectCitySecondMenu = ""
    @State var distanceKm:String = ""
    @State private var isSwitched = true;
    @State var consoMoy = ""
    @State var prixEssence = ""
    @State var DISTANCE_MOYENNE = 100;
    @State private var distance: Double = 0.0
    @State private var results: (consommation: Double, cout: Double) = (0.0, 0.0)
    
    var body: some View {
        
        // Partie Navigation
        
        NavigationView {
            // Stack principale
            VStack {
                // Premiere Stack
                VStack {
                    // 1er Menu
                    Menu {
                        ForEach(city, id: \.self) {
                            cities in Button(cities) {
                                selectCityFirstMenu = cities
                            }
                        }
                        
                    } label: {
                        Text("Ville de depart :")
                        Text(selectCityFirstMenu)
                    }
                    .frame(width: 300, height: 30)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(10)
                    .padding(21)
                    
                    // 2eme Menu
                    Menu {
                        ForEach(city, id: \.self) {
                            cities in Button(cities) {
                                selectCitySecondMenu = cities
                            }
                        }
                        
                    } label: {
                        Text("Ville de destination :")
                        Text(selectCitySecondMenu)
                    }
                    .frame(width: 300, height: 30)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(10)
                    
                    VStack(alignment: .leading) {
                        Text("Distance parcouru (en km)")
                            .font(.system(size: 14, weight: .medium, design: .default))
                            .foregroundColor(.white)
                            .padding(1)
                    }
                    
                    TextField("Km", text: $distanceKm)
                        .padding()
                        .frame(width: 300, height: 30)
                        .background(Color(.white))
                        .cornerRadius(10)
                    
                }
                .padding(.bottom)
                .frame(width: 350, height: 200)
                .background(.gray)
                .cornerRadius(20)
                
                // Deuxieme Stack
                VStack {
                    Text("Moy de cons. d'essence du vehicule")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(.black)
                        .padding(1)
                    
                    TextField("L/100km", text: $consoMoy)
                        .padding()
                        .frame(width: 300, height: 30)
                        .background(Color(.white))
                        .cornerRadius(10)
                    
                    Text("Prix du litre d'essence")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(.black)
                        .padding(1)
                    
                    TextField("$", text: $prixEssence)
                        .padding()
                        .frame(width: 300, height: 30)
                        .background(Color(.white))
                        .cornerRadius(10)
                }
                .frame(width: 350, height: 200)
                .background(.gray)
                .cornerRadius(20)
                
                // Troisieme VStack
                VStack {
                    // first HStack
                    HStack {
                        // VStack ??
                        VStack {
                            Text("RESULTATS")
                                .font(.system(size: 14, weight: .bold, design: .default))
                                .padding(.bottom, 5)
                            
                            // une autre stack encore ??
                            HStack {
                                Image(systemName: "flame")
                                Text(String(format: "%.2f L", results.consommation))
                            }
                            // Stack horizontale pour ma lettre et mon n
                            HStack {
                                Image(systemName: "trash.circle")
                                Text(String(format: "%.2f $", results.cout))
                            }
                        }
                        .frame(width: 150, height: 110)
                        .background(.gray)
                        .cornerRadius(20)
                        .padding(.leading, 25)
                        .padding(.bottom)
                        // Button
                        VStack {
                            Button(action: {
                                results = calculateResults(distance: Double(distanceKm)!, consommationMoyenne: Double(consoMoy)!, prixEssence: Double(prixEssence)!)
                            }) {
                                   Text("Calculate results")
                            .foregroundColor(.white)
                            .frame(width: 130, height: 20, alignment: .topLeading)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(30)
                            }
                            
                            Toggle("Allez-retour?", isOn: $isSwitched)
                        .padding()
                        }
                        
                        
                    }
                    
                    
                }
            }
            .padding(.bottom, 130)
            .navigationTitle("Essence")
            
        }
        
        // Partie barre d'outils
        //        ToolbarItem {
        //
        //        }
    }
}
    // Declaration de mes fonctions
    
//    func selectedCity(cityValue: String) -> String {
//    case "Bathurst":
//        return
//    }

func calculateResults(distance: Double, consommationMoyenne: Double, prixEssence: Double) -> (consommation: Double, cout: Double) {
    // Calcul de la consommation totale d'essence (en litres)
    let consommation = (distance * consommationMoyenne) / 100
    
    // Calcul du coût total du carburant
    let cout = consommation * prixEssence
    
    return (consommation, cout)
}

#Preview {
    ContentView()
}

// hide a keyboard
//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
