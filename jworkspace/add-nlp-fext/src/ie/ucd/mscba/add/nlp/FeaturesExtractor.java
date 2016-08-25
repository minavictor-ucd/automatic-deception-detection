package ie.ucd.mscba.add.nlp;

import java.math.BigDecimal;

public class FeaturesExtractor {
	public static int getNumberOfCharacters(String text) {
		String[] words = getTokens(text);

		int charactersCount = 0;
		for (String word : words) {
			charactersCount += word.length();
		}

		return charactersCount;
	}

	public static int getNumberOfComplexWords(String text) {
		String[] words = getTokens(text);

		int complexCount = 0;
		for (String w : words) {
			if (isComplex(w)) {
				complexCount++;
			}
		}

		return complexCount;
	}

	public static String[] getTokens(String text) {
		String cleanText = preprocessing(text);
		return cleanText.split(" ");
	}

	public static int getNumberOfWords(String text) {
		String[] words = getTokens(text);

		int wordsCount = 0;
		for (String w : words) {
			if (w.length() > 0) {
				wordsCount++;
			}
		}

		return wordsCount;
	}

	public static int getNumberOfSyllables(String text) {
		String[] words = getTokens(text);

		int syllablesCount = 0;
		for (String word : words) {
			if (word.length() > 0) {
				syllablesCount += Syllabify.syllable(word);
			}
		}

		return syllablesCount;
	}

	public static String preprocessing(String text) {
		text = text.trim();
		text = text.replaceAll("\\s+", " ");
		
		// TODO: inspect more cases 
		return text;
	}

	public static boolean isComplex(String w) {
		int syllables = Syllabify.syllable(w);
		return (syllables > 2);
	}

	public static int getNumberOfSentences(String text) {
		text = text.endsWith(".") ? text : text + ".";
		
		int l = se.getSentences(text).length;
		if (l > 0) {
			return l;
		} else if (text.length() > 0) {
			return 1;
		} else {
			return 0;
		}
	}

	// http://en.wikipedia.org/wiki/SMOG_Index
	public static double getSMOGIndex(String text) {
		int sentences = getNumberOfSentences(text + ".");
		int complex = getNumberOfComplexWords(text);

		double score = Math.sqrt(complex * (30.0 / sentences)) + 3;
		return round(score, 3);
	}

	// http://en.wikipedia.org/wiki/SMOG
	public static double getSMOG(String text) {
		int sentences = getNumberOfSentences(text + ".");
		int complex = getNumberOfComplexWords(text);

		double score = 1.043 * Math.sqrt(complex * (30.0 / sentences)) + 3.1291;
		return round(score, 3);
	}

	// http://en.wikipedia.org/wiki/Flesch-Kincaid_Readability_Test
	public static double getFleschReadingEase(String text) {
		int sentences = getNumberOfSentences(text + ".");
		int words = getNumberOfWords(text);
		int syllables = getNumberOfSyllables(text);

		double score = 206.835 - 1.015 * words / sentences - 84.6 * syllables / words;
		return round(score, 3);
	}

	// http://en.wikipedia.org/wiki/Flesch-Kincaid_Readability_Test
	public static double getFleschKincaidGradeLevel(String text) {
		int sentences = getNumberOfSentences(text + ".");
		int words = getNumberOfWords(text);
		int syllables = getNumberOfSyllables(text);

		double score = 0.39 * words / sentences + 11.8 * syllables / words - 15.59;
		return round(score, 3);
	}

	// http://en.wikipedia.org/wiki/Automated_Readability_Index
	public static double getARI(String text) {
		int sentences = getNumberOfSentences(text + ".");
		int words = getNumberOfWords(text);
		int characters = getNumberOfCharacters(text);

		double score = 4.71 * characters / words + 0.5 * words / sentences - 21.43;
		return round(score, 3);
	}

	// http://en.wikipedia.org/wiki/Gunning-Fog_Index
	public static double getGunningFog(String text) {
		int sentences = getNumberOfSentences(text + ".");
		int complex = getNumberOfComplexWords(text);
		int words = getNumberOfWords(text);

		double score = 0.4 * (words / sentences + 100 * complex / words);
		return round(score, 3);
	}

	// http://en.wikipedia.org/wiki/Coleman-Liau_Index
	public static double getColemanLiau(String text) {
		int sentences = getNumberOfSentences(text);
		int words = getNumberOfWords(text);
		int characters = getNumberOfCharacters(text);

		double score = (5.89 * characters / words) - (30 * sentences / words) - 15.8;
		return round(score, 3);
	}

	private static Double round(double d, int decimalPlace) {
		// see the Javadoc about why we use a String in the constructor
		// http://java.sun.com/j2se/1.5.0/docs/api/java/math/BigDecimal.html#BigDecimal(double)
		BigDecimal bd = new BigDecimal(Double.toString(d));
		bd = bd.setScale(decimalPlace, BigDecimal.ROUND_HALF_UP);
		return bd.doubleValue();
	}
	
	private static Double clean(double d, int decimalPlace) {
		// see the Javadoc about why we use a String in the constructor
		// http://java.sun.com/j2se/1.5.0/docs/api/java/math/BigDecimal.html#BigDecimal(double)
		BigDecimal bd = new BigDecimal(Double.toString(d));
		bd = bd.setScale(decimalPlace, BigDecimal.ROUND_HALF_UP);
		return bd.doubleValue();
	}
	
	private static SentenceExtractor se = new SentenceExtractor();
}