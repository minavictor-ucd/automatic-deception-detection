package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;
import ie.ucd.mscba.add.nlp.FeaturesExtractor;

public class CueNumbersCount extends Cue {
	public CueNumbersCount() {
		super("Numbers Count", "NumbersCount", "Number of numbers in a given observation");
	}

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		String[] words = FeaturesExtractor.getTokens(textObservation);

		double numbersCount = 0;
		for (String word : words) {
			try { Double.parseDouble(word); numbersCount++; continue; } catch (Exception e) {}
			try { Integer.parseInt(word); numbersCount++; continue; } catch (Exception e) {}
		}

		setValue(new CueValue(CueValueType.Real, numbersCount));
		return getValue();
	}
}
