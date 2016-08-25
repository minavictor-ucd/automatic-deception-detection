package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;
import ie.ucd.mscba.add.nlp.FeaturesExtractor;

public class CueAutomatedReadabilityIndex extends Cue {
	public CueAutomatedReadabilityIndex() {
		super("AutomatedReadabilityIndex", "Automated Readability Index",
				"A readability test designed to assess the understandability of a text");
	}

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		double ariValue = FeaturesExtractor.getARI(textObservation);

		setValue(new CueValue(CueValueType.Real, ariValue));
		return getValue();
	}
}
