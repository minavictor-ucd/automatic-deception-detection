package ie.ucd.mscba.add.cues.deception;

import java.util.HashMap;
import java.util.Map;

import ie.ucd.mscba.add.cues.Cue;

public final class CuesFactory {
	private CuesFactory() {}
	
	public static Cue GetInstance(CuesTypes cueType) {
		if (cues.containsKey(cueType)) {
			return cues.get(cueType);
		}
		
		return null;
	}
	
	private static Map<CuesTypes, Cue> cues = new HashMap<CuesTypes, Cue>() {{
		// Quantative 
		put(CuesTypes.STATEMENTS_COUNT, new CueStatementsCount());
		put(CuesTypes.WORDS_COUNT, new CueWordsCount());
		put(CuesTypes.SYMBOLS_COUNT, new CueSymbolsCount());
		put(CuesTypes.NUMBERS_COUNT, new CueNumbersCount());
		put(CuesTypes.DIGITS_COUNT, new CueDigitCount());
		put(CuesTypes.MONETARYSYMBOLS_COUNT, new CueMonetarySymbolsCount());
		put(CuesTypes.MONETARYSHORTHANDSYMBOLS_COUNT, new CueMonetaryShorthandSymbols());
		put(CuesTypes.MEASUREMENTS_COUNT, new CueMeasurementCount());
		put(CuesTypes.SYLLABLES_COUNT, new CueSyllablesCount());
		put(CuesTypes.COMPLEXWORDS_COUNT, new CueComplexWordsCount());
		put(CuesTypes.WRONGWORDS_COUNT, new CueWrongWordsCount());
		
		put(CuesTypes.AVGSTATEMENTLENGTH, new CueAvarageStatementLength());
		put(CuesTypes.AVGWORDSLENGTH, new CueAvarageWordLength());
		 
		put(CuesTypes.SMOGREADABILITY_READABILITYINDEX, new CueSMOGReadability());
		put(CuesTypes.SMOGREADABILITY, new CueSMOGReadabilityIndex());
		put(CuesTypes.GUNNINGFOG_READABILITYINDEX, new CueGunningFogIndex());
		put(CuesTypes.FLESCHREADABILITY_READABILITYINDEX, new CueFleschReadabilityIndex());
		put(CuesTypes.FLESCHKINCAIDREADABILITY_READABILITYINDEX, new CueFleschKincaidReadabilityIndex());
		put(CuesTypes.COLEMANLIAU_READABILITYINDEX, new CueColemanLiauIndex());
		put(CuesTypes.AUTOMATEDREADABILITY_READABILITYINDEX, new CueAutomatedReadabilityIndex());
		
		 // TODO: add more cures
	}};
}
