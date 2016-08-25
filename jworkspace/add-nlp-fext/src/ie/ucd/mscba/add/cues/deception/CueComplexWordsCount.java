package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;
import ie.ucd.mscba.add.nlp.FeaturesExtractor;

public class CueComplexWordsCount extends Cue {
	public CueComplexWordsCount() {
		super("ComplexWordsCount", "Complex Words Count", "Number of complex words in a given observation");
	}

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		double complexWordsCount = FeaturesExtractor.getNumberOfComplexWords(textObservation);

		setValue(new CueValue(CueValueType.Real, complexWordsCount));
		return getValue();
	}
}
