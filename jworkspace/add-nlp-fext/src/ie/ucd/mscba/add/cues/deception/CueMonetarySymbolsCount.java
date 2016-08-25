package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;

public class CueMonetarySymbolsCount extends Cue {
	public CueMonetarySymbolsCount() {
		super("Monetary Symbol Count", "MonetarySymbolCount", "Number of monetaries symbols in a given observation");
	}

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		double symbolsCount = getMonetarySymbolsCount(textObservation);

		setValue(new CueValue(CueValueType.Real, symbolsCount));
		return getValue();
	}
	
	private int getMonetarySymbolsCount(String s) {
		if (s == null || s.trim().isEmpty()) {
			return 0;
		}
		
		String specialChars = "£$€¥₳₢₤฿₫";
		
		int theCount = 0;
		for (int i = 0; i < s.length(); i++) {
			if (specialChars.indexOf(s.charAt(i)) != -1) {
				theCount++;
			}
		}
		
		return theCount;
	}
}
