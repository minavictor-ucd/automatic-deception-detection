package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;
import ie.ucd.mscba.add.nlp.FeaturesExtractor;

public class CueFleschReadabilityIndex extends Cue {
	public CueFleschReadabilityIndex() {
		super("FleschReadabilityIndex", "Flesch Readability Index", " A readability tests designed to indicate how difficult a reading passage in English is to understand");
	}

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		double readabilityIndex = FeaturesExtractor.getFleschReadingEase(textObservation);

		setValue(new CueValue(CueValueType.Real, readabilityIndex));
		return getValue();
	}
}
