package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;
import ie.ucd.mscba.add.nlp.FeaturesExtractor;

public class CueAvarageStatementLength extends Cue {
	public CueAvarageStatementLength() {
		super("AvarageStatementLength", "Avarage Statement Length", "Avarage Statement length in a given textual observation");
	}

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		double wordsCount = FeaturesExtractor.getTokens(textObservation).length;
		double sentencesCount = FeaturesExtractor.getNumberOfSentences(textObservation);

		setValue(new CueValue(CueValueType.Real, wordsCount / sentencesCount));
		return getValue();
	}
}
