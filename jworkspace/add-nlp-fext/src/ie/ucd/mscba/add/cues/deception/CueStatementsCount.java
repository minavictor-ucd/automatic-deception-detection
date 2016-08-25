package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;
import ie.ucd.mscba.add.nlp.FeaturesExtractor;

public class CueStatementsCount extends Cue {
	public CueStatementsCount() {
		super("StatementsCount", "Statements Count", "Number of statements in a given observation");
	}

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		double statementsCount = FeaturesExtractor.getNumberOfSentences(textObservation);

		setValue(new CueValue(CueValueType.Real, statementsCount));
		return getValue();
	}
}
