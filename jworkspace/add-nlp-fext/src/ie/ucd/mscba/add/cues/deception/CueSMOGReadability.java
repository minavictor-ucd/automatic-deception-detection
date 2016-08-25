package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;
import ie.ucd.mscba.add.nlp.FeaturesExtractor;

public class CueSMOGReadability extends Cue {
	public CueSMOGReadability() {
		super("SMOGReadability", "SMOG Readability", "A readability that estimates the years of education needed to understand a piece of writing");
	}

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		double readabilityIndex = FeaturesExtractor.getSMOG(textObservation);

		setValue(new CueValue(CueValueType.Real, readabilityIndex));
		return getValue();
	}
}
