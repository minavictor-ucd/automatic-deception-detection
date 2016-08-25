package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;

public class CueSymbolsCount extends Cue {
	public CueSymbolsCount() {
		super("SymbolsCount", "Symbols Count", "Number of symbols in a given observation");
	}

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		double symbolsCount = getSpecialCharacterCount(textObservation);

		setValue(new CueValue(CueValueType.Real, symbolsCount));
		return getValue();
	}

	private int getSpecialCharacterCount(String s) {
		if (s == null || s.trim().isEmpty()) {
			return 0;
		}
		
		String specialChars = "/*!@#$%^&*()\"{}_[]|\\?/<>,.";
		
		int theCount = 0;
		for (int i = 0; i < s.length(); i++) {
			if (specialChars.indexOf(s.charAt(i)) != -1) {
				theCount++;
			}
		}
		
		return theCount;
	}
}
