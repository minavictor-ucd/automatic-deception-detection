package ie.ucd.mscba.add.cues.deception;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.CueValueType;
import ie.ucd.mscba.add.nlp.FeaturesExtractor;

public class CueColemanLiauIndex extends Cue {
	public CueColemanLiauIndex() {
		super("ColemanLiauIndex", "Coleman Liau Index", "A readability test designed by Meri Coleman and T. L. Liau to gauge the understandability of a text");
	}

	@Override
	public CueValue calculate(String textObservation) {
		if (textObservation == null || textObservation.isEmpty()) {
			setValue(CueValue.Default);
			return getValue();
		}

		double colemanLiauIndex = FeaturesExtractor.getColemanLiau(textObservation);

		setValue(new CueValue(CueValueType.Real, colemanLiauIndex));
		return getValue();
	}
}
