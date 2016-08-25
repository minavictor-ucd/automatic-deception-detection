package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;

public class CueDigitCount extends Cue {
  public CueDigitCount() {
    super("Digits Count", "DigitsCount", "Number of digits in a given observation");
  }

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		double digitsCount = 0;
		for (char chrIter : textObservation.toCharArray()) {
			if (Character.isDigit(chrIter)) {
				++digitsCount;
			}
		}

		setValue(new CueValue(CueValueType.Real, digitsCount));
		return getValue();
	}
}
