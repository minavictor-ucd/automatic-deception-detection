package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;
import ie.ucd.mscba.add.nlp.FeaturesExtractor;

public class CueAvarageWordLength extends Cue {
	public CueAvarageWordLength() {
		super("AvarageWordLength", "Avarage Word Length", "Avarage word length in a given textual observation");
	}

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		double totalWordsLength = FeaturesExtractor.getNumberOfCharacters(textObservation);
		String[] words = FeaturesExtractor.getTokens(textObservation);

		setValue(new CueValue(CueValueType.Real, totalWordsLength / (double) words.length));
		return getValue();
	}
}
