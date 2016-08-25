package ie.ucd.mscba.add.nlp;

import java.io.*;
import java.util.*;
import java.util.regex.*;

public class Spelling {
	private final HashMap<String, Integer> nWords = new HashMap<String, Integer>();

	public Spelling(String file) {
		BufferedReader in;
		try {
			in = new BufferedReader(new FileReader(file));
			Pattern p = Pattern.compile("\\w+");
			for(String temp = ""; temp != null; temp = in.readLine()){
				Matcher m = p.matcher(temp.toLowerCase());
				while(m.find()) nWords.put((temp = m.group()), nWords.containsKey(temp) ? nWords.get(temp) + 1 : 1);
			}
			in.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private final ArrayList<String> edits(String word) {
		ArrayList<String> result = new ArrayList<String>();
		for(int i=0; i < word.length(); ++i) result.add(word.substring(0, i) + word.substring(i+1));
		for(int i=0; i < word.length()-1; ++i) result.add(word.substring(0, i) + word.substring(i+1, i+2) + word.substring(i, i+1) + word.substring(i+2));
		for(int i=0; i < word.length(); ++i) for(char c='a'; c <= 'z'; ++c) result.add(word.substring(0, i) + String.valueOf(c) + word.substring(i+1));
		for(int i=0; i <= word.length(); ++i) for(char c='a'; c <= 'z'; ++c) result.add(word.substring(0, i) + String.valueOf(c) + word.substring(i));
		return result;
	}

	public final boolean isCorrect(String word) {
		if(nWords.containsKey(word.toLowerCase())) return true;
		return false;
	}

	public static Spelling CurrentInstance = new Spelling("c:/Users/mivictor/OneDrive/project-alpha/learning/mscba/Practicum/code/target/big.txt");
}