package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;
import ie.ucd.mscba.add.nlp.FeaturesExtractor;
import ie.ucd.mscba.add.nlp.Spelling;;

public class CueWrongWordsCount extends Cue {
	public CueWrongWordsCount() {
		super("WrongWordsCount", "WrongWordsCount", "");
	}

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		double totalWrongWords = 0;
		String[] words = FeaturesExtractor.getTokens(textObservation);
		for (String word : words) {
			if (!Spelling.CurrentInstance.isCorrect(word)) totalWrongWords++;
		}
		setValue(new CueValue(CueValueType.Real, totalWrongWords));
		return getValue();
	}
}
