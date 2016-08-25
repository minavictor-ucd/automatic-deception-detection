package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;
import ie.ucd.mscba.add.nlp.FeaturesExtractor;

public class CueMeasurementCount extends Cue {
	public CueMeasurementCount() {
		super("Measurement Count", "MeasurementCount", "Number of measurements in a given observation");
	}

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		String[] units = new String[] {
				"mm", "cm", "m", "km",
				"mg", "g", "kg", "t", "s", 
				"°C", "m²", "m²", "km²", "mL", 
				"cm³", "L", "m³", 
				"m/s", "km/h", 
				"kg/m³",
				"N",
				"kPa",
				"W", "kW",
				"kJ", "MJ", "kW·h"
		};
	
		double measurementCount = 0.0; 
		String[] tokens = FeaturesExtractor.getTokens(textObservation);
		for (String token : tokens) {
			for (String unit : units) {
				if (token.equalsIgnoreCase(unit)) {
					measurementCount++;
				}
			}
		}

		setValue(new CueValue(CueValueType.Real, measurementCount));
		return getValue();
	}
}
