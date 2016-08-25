package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;
import ie.ucd.mscba.add.nlp.FeaturesExtractor;

public class CueGunningFogIndex extends Cue {
	public CueGunningFogIndex() {
		super("GunningFogIndex", "Gunning Fog Index", "The index estimates the years of formal education needed to understand the text on a first reading");
	}

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		double readabilityIndex = FeaturesExtractor.getGunningFog(textObservation);

		setValue(new CueValue(CueValueType.Real, readabilityIndex));
		return getValue();
	}
}
