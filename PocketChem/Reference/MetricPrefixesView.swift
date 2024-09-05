//
//  MetricPrefixesView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Data
import Design
import Tools
import SwiftUI

struct MetricPrefixesView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    metricListItem(prefix: "giga- (G)", value: "1.0 x 10^{9}")
                    metricListItem(prefix: "mega- (M)", value: "1.0 x 10^{6}")
                    metricListItem(prefix: "kilo- (k)", value: "1.0 x 10^{3}")
                    metricListItem(prefix: "hecto- (h)", value: "1.0 x 10^{2}")
                    metricListItem(prefix: "deka- (da)", value: "1.0 x 10^{1}")
                    metricListItem(prefix: "BASE UNIT", value: "1.0 x 10^{0}")
                    metricListItem(prefix: "deci- (d)", value: "1.0 x 10^{-1}")
                    metricListItem(prefix: "centi- (c)", value: "1.0 x 10^{-2}")
                    metricListItem(prefix: "milli- (m)", value: "1.0 x 10^{-3}")
                    metricListItem(prefix: "micro- (μ)", value: "1.0 x 10^{-6}")
                    metricListItem(prefix: "nano- (n)", value: "1.0 x 10^{-9}")
                    metricListItem(prefix: "pico- (p)", value: "1.0 x 10^{-12}")
                } header: {
                    Label("All Prefixes", systemImage: "ruler")
                }
            }
            .navigationTitle("Metrix Prefixes")
        }
    }

    @ViewBuilder
    private func metricListItem(prefix: String, value: String) -> some View {
        HStack {
            Text(prefix)
            Spacer()
            SubSuperScriptText(value)
                .foregroundStyle(Color.secondary)
        }
    }
}

#Preview {
    MetricPrefixesView()
}

/*
 
 (
 title: "pico- (p)",
 value: "1.0 x 10^{-12}"
 ),
 (
 title: "nano- (n)",
 value: "1.0 x 10^{-9}"
 ),
 (
 title: "micro- (μ)",
 value: "1.0 x 10^{-6}"
 ),
 (
 title: "milli- (m)",
 value: "1.0 x 10^{-3}"
 ),
 (
 title: "centi- (c)",
 value: "1.0 x 10^{-2}"
 ),
 (
 title: "deci- (d)",
 value: "1.0 x 10^{-1}"
 ),
 */
