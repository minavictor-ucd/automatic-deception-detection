package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;
import ie.ucd.mscba.add.nlp.FeaturesExtractor;

public class CueWordsCount extends Cue {
	public CueWordsCount() {
		super("WordsCount", "Words Count", "Number of words in a given observation");
	}

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		double wordsCount = FeaturesExtractor.getNumberOfWords(textObservation);

		setValue(new CueValue(CueValueType.Real, wordsCount));
		return getValue();
	}
}
