package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;
import ie.ucd.mscba.add.nlp.FeaturesExtractor;

public class CueSyllablesCount extends Cue {
	public CueSyllablesCount() {
		super("SyllablesCount", "Syllables Count", "Number of syllables in a given observation");
	}

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		double syllablesCount = FeaturesExtractor.getNumberOfSyllables(textObservation);

		setValue(new CueValue(CueValueType.Real, syllablesCount));
		return getValue();
	}
}
