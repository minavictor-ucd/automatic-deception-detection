package ie.ucd.mscba.add.cues.deception.r;

import ie.ucd.mscba.add.cues.Cue;
import ie.ucd.mscba.add.cues.CueValue;
import ie.ucd.mscba.add.cues.deception.CuesFactory;
import ie.ucd.mscba.add.cues.deception.CuesTypes;
import ie.ucd.mscba.add.nlp.SentenceExtractor;

public class RDeceptionFeatureExtractor {
	public double getStatementsCountCue(String textObservation) {
		return processCue(textObservation, CuesTypes.STATEMENTS_COUNT);
	}

	public double getWordsCountCue(String textObservation) {
		return processCue(textObservation, CuesTypes.WORDS_COUNT);
	}

	public double getSymbolsCountCue(String textObservation) {
		return processCue(textObservation, CuesTypes.SYMBOLS_COUNT);
	}

	public double getNumbersCountCue(String textObservation) {
		return processCue(textObservation, CuesTypes.NUMBERS_COUNT);
	}

	public double getDigitsCountCue(String textObservation) {
		return processCue(textObservation, CuesTypes.DIGITS_COUNT);
	}

	public double getMonetarySymbolsCountCue(String textObservation) {
		return processCue(textObservation, CuesTypes.MONETARYSYMBOLS_COUNT);
	}
	
	public double getMonetaryShorthandSymbolsCountCue(String textObservation) {
		return processCue(textObservation, CuesTypes.MONETARYSYMBOLS_COUNT);
	}

	public double getMeasurementsCountCue(String textObservation) {
		return processCue(textObservation, CuesTypes.MEASUREMENTS_COUNT);
	}

	public double getSyllablesCountCue(String textObservation) {
		return processCue(textObservation, CuesTypes.SYLLABLES_COUNT);
	}

	public double getComplexWordsCountCue(String textObservation) {
		return processCue(textObservation, CuesTypes.COMPLEXWORDS_COUNT);
	}

	public double getSMOGReadabilityIndexCue(String textObservation) {
		return processCue(textObservation, CuesTypes.SMOGREADABILITY_READABILITYINDEX);
	}

	public double getSMOGReadabilityCue(String textObservation) {
		return processCue(textObservation, CuesTypes.SMOGREADABILITY);
	}

	public double getGunningFogIndexCue(String textObservation) {
		return processCue(textObservation, CuesTypes.GUNNINGFOG_READABILITYINDEX);
	}

	public double getFleschReadabilityIndexCue(String textObservation) {
		return processCue(textObservation, CuesTypes.FLESCHREADABILITY_READABILITYINDEX);
	}

	public double getFleschKincaidReadabilityIndexCue(String textObservation) {
		return processCue(textObservation, CuesTypes.FLESCHKINCAIDREADABILITY_READABILITYINDEX);
	}

	public double getColemanLiauIndexCue(String textObservation) {
		return processCue(textObservation, CuesTypes.COLEMANLIAU_READABILITYINDEX);
	}

	public double getAutomatedReadabilityIndexCue(String textObservation) {
		return processCue(textObservation, CuesTypes.AUTOMATEDREADABILITY_READABILITYINDEX);
	}

	public double getAvarageStatementLengthCue(String textObservation) {
		return processCue(textObservation, CuesTypes.AVGSTATEMENTLENGTH);
	}
	
	public double getAvarageWordsLengthCue(String textObservation) {
		return processCue(textObservation, CuesTypes.AVGWORDSLENGTH);
	}
	
	// Additive Transition
	
	public double getAdditionTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"indeed", "further", "as well", "as this", "either", "neither", "also", "moreover", "what is more", "as a matter of fact", "in all honesty", "and", "furthermore", "in addition", "besides", "to tell the truth", "or", "in fact", "actually", "to say nothing of", "too", "let alone", "much less", "additionally", "nor", "alternatively", "on the other hand", "not to mention"});
	}
	
	public double getIntroductionTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"such as", "as", "particularly", "including", "as an illustration", "for example", "like", "in particular", "for one thing", "to illustrate", "for instance", "especially", "notably", "by way of example"});
	}
	
	public double getReferenceTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"speaking about", "considering", "regarding", "with regards to", "as for", "the fact that", "on the subject of"});
	}
	
	public double getSimilarityTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"similarly", "in the same way", "by the same token", "in a like manner", "equally", "likewise"});
	}
	
	public double getIdentificationTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"that is to say", "that is", "namely", "specifically", "thus"});
	}
	
	public double getClarificationTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"that is to say", "that is", "I mean", "put it another way", "in other words"});
	}
	
	public double getAdditiveTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {
		"indeed", "further", "as well", "as this", "either", "neither", "also", "moreover", "what is more", "as a matter of fact", "in all honesty", "and", "furthermore", "in addition", "besides", "to tell the truth", "or", "in fact", "actually", "to say nothing of", "too", "let alone", "much less", "additionally", "nor", "alternatively", "on the other hand", "not to mention",
		"such as", "as", "particularly", "including", "as an illustration", "for example", "like", "in particular", "for one thing", "to illustrate", "for instance", "especially", "notably", "by way of example",
		"speaking about", "considering", "regarding", "with regards to", "as for", "the fact that", "on the subject of",
		"similarly", "in the same way", "by the same token", "in a like manner", "equally", "likewise",
		"that is to say", "that is", "namely", "specifically", "thus",
		"I mean", "put it another way", "in other words"});
	}
	

	// Adversative Transitions

	public double getConflictTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"but", "by way of contrast","while", "on the other hand", "however", "yet", "whereas", "though", "though final position", "in contrast", "when in fact", "conversely"});
	}
	
	public double getEmphasisTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"even more", "above all", "indeed", "more importantly", "besides"});
	}
	
	public double getConcessionTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"but even so", "nevertheless", "even though", "on the other hand", "admittedly", "however", "nonetheless", "despite", "notwithstanding", "albeit", "still", "although", "in spite of", "regardless", "yet", "though", "granted", "be that as it may"});
	}
	
	public double getDismissalTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"either way", "whichever happens", "in either event", "in any case", "at any rate", "in either case", "whatever happens", "all the same", "in any event"});
	}
	
	public double getReplacementTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"at least", "rather", "instead"});
	}
	
	public double getAdversativeTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"but", "by way of contrast","while", "on the other hand", "however", "yet", "whereas", "though", "though final position", "in contrast", "when in fact", "conversely",
				"even more", "above all", "indeed", "more importantly", "besides",
				"but even so", "nevertheless", "even though", "on the other hand", "admittedly", "however", "nonetheless", "despite", "notwithstanding", "albeit", "still", "although", "in spite of", "regardless", "yet", "though", "granted", "be that as it may",
				"either way", "whichever happens", "in either event", "in any case", "at any rate", "in either case", "whatever happens", "all the same", "in any event",
				"at least", "rather", "instead"});
	}

	// Causal Transitions
	
	public double getCausalAndReasonTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"for the simple reason", "for the reason", "being that", "for", "in view of", "inasmuch as", "because", "seeing that", "as", "owing to", "due to", "in that since", "for as much as"});
	}
	
	public double getConditionTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"on the condition", "on condition", "granted", "if", "provided that", "in case", "in the event that", "as long as", "so long as", "unless given that", "granting", "providing that", "even if", "only if"});
	}
	
	public double getEffectAndResultTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"as a result", "consequently", "hence", "for this reason", "thus", "because", "in consequence", "so that", "accordingly", "as a consequence", "so much so that", "so much that", "so", "therefore"});
	}
	
	public double getPurposeTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"for the purpose of", "in the hope that", "for fear that", "so that", "with this intention", "to the end that", "in order to", "lest", "with this in mind", "in order that", "so as to", "so"});
	}
	
	public double getConsequenceTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"under those circumstances", "then", "in that case", "if not", "that being the case", "if so", "otherwise"});
	}
	
	public double getCausalTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"for the simple reason", "for the reason", "being that", "for", "in view of", "inasmuch as", "because", "seeing that", "as", "owing to", "due to", "in that since", "for as much as",
				"on the condition", "on condition", "granted", "if", "provided that", "in case", "in the event that", "as long as", "so long as", "unless given that", "granting", "providing that", "even if", "only if",
				"as a result", "consequently", "hence", "for this reason", "thus", "because", "in consequence", "so that", "accordingly", "as a consequence", "so much so that", "so much that", "so", "therefore",
				"for the purpose of", "in the hope that", "for fear that", "so that", "with this intention", "to the end that", "in order to", "lest", "with this in mind", "in order that", "so as to",
				"under those circumstances", "then", "in that case", "if not", "that being the case", "if so", "otherwise"});
	}
	
	// Sequential Transitions
	
	public double getNumericalTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"first", "second", "third", "fourth", "fifth", "initially", "to start with", "first of all", "to begin with", "for a start"});
	}
	
	public double getContinuationTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"subsequently", "previously", "eventually", "next", "before", "afterwards", "then"});
	}

	public double getConclusionTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"conclude", "as a final point", "eventually", "at last", "in the end", "finally", "lastly"});
	}

	public double getDigressionTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"to change the topic", "incidentally", "by the way"});
	}

	public double getResumptionTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"to get back to the point", "to resume", "anyhow", "anyway", "at any rate", "to return to the subject"});
	}

	public double getSummationTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"as was previously stated", "so", "consequently", "in summary", "all in all", "to make a long story short", "thus", "as I have said", "to sum up", "overall", "as has been mentioned", "then", "to summarize", "to be brief", "briefly", "given these points", "in all", "on the whole",  "therefore", "as has been noted", "hence", "in conclusion", "in a word", "to put it briefly","in sum", "altogether", "in short"});
	}

	public double getSequentialTransitionWordsCountCue(String textObservation) {
		return SentenceExtractor.getSubStringOccurrence(textObservation, new String[] {"first", "second", "third", "fourth", "fifth", "initially", "to start with", "first of all", "to begin with", "for a start",
				"subsequently", "previously", "eventually", "next", "before", "afterwards", "then",
				"conclude", "as a final point", "eventually", "at last", "in the end", "finally", "lastly",
				"to change the topic", "incidentally", "by the way",
				"to get back to the point", "to resume", "anyhow", "anyway", "at any rate", "to return to the subject",  
				"as was previously stated", "so", "consequently", "in summary", "to make a long story short", "thus", "as I have said", "to sum up", "overall", "as has been mentioned", "then", "to summarize", "to be brief", "briefly", "given these points", "in all", "on the whole",  "therefore", "as has been noted", "hence", "in conclusion", "in a word", "to put it briefly","in sum", "altogether", "in short"});
	}
	
	public double getWrongWordsCountCue(String textObservation) {
		return processCue(textObservation, CuesTypes.WRONGWORDS_COUNT);
	}
	
	private double processCue(String textObservation, CuesTypes cueType) {
		Cue cue = CuesFactory.GetInstance(cueType);
		CueValue cv = cue.calculate(textObservation);
		return (double) cv.getValue();
	}
	
	public static void main(String[] args) {
		RDeceptionFeatureExtractor r = new RDeceptionFeatureExtractor();
		double d = r.getWrongWordsCountCue("aasss");
		System.out.println(d);
	}
}
