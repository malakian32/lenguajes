package com.proyecto.services;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.function.BiConsumer;
import java.util.regex.Pattern;

import com.proyecto.entity.Token;
import com.proyecto.util.Utils;

public class LexicalAnalizer {

	public static LexicalAnalizer instance;
	private Map<String, Pattern> lexicalCategories;

	public LexicalAnalizer() {
		lexicalCategories = new LinkedHashMap<String, Pattern>();
		readPatterns();
	}

	public static LexicalAnalizer getInstance() {
		if (instance == null) {
			instance = new LexicalAnalizer();
		}

		return instance;
	}

	private void readPatterns() {
		List<String> fileLines = Utils.readResourceFile("/config/lexical-patterns");
		int i = 0;

		for (String line : fileLines) {
			int lastIndexOf = line.lastIndexOf(" ");

			if (lastIndexOf != -1) {
				String regex = line.substring(0, lastIndexOf).trim();
				String lexicalCategory = line.substring(lastIndexOf).trim();
				addLexicalCategory(lexicalCategory, regex);
			} else {
				addLexicalCategory("ignore" + i, line);
			}
		}
	}

	private void addLexicalCategory(String name, String regex) {
		lexicalCategories.put(name, Pattern.compile(regex));
	}

	public List<Token> getTokens(String text) throws Exception {
		List<Token> tokens = new ArrayList<Token>();

		processText(text, tokens);

		return tokens;
	}

	private void processText(String text, List<Token> tokens) throws Exception {
		int start = 0;
		System.out.println(text);

		while (start < text.length()) {
			int length = 0;
			Token token = null;

			for (String lexicalCategory : lexicalCategories.keySet()) {
				Pattern pattern = lexicalCategories.get(lexicalCategory);
				String textMatched = scanTextWithPattern(text, pattern, start);

				if (textMatched.length() > length) {
					length = textMatched.length();
					token = new Token(lexicalCategory, textMatched);
				}
			}

			start += length;

			if (token != null) {
				if (!token.lexicalCategory.startsWith("ignore")) {
					tokens.add(token);
				}
			} else {
				throw new Exception("Unrecognized token " + text.substring(start));
			}

		}
	}

	private String scanTextWithPattern(String text, Pattern pattern, int start) {
		int i = start + 1;
		String lexeme = "";

		while (lookAhead(text, pattern, start, i)) {
			lexeme = text.substring(start, i);
			i++;
		}

		return lexeme;
	}

	private boolean lookAhead(String text, Pattern pattern, int start, int end) {
		if (end == text.length()) {
			return true;
		}

		if (end >= text.length()) {
			return false;
		}

		return pattern.matcher(text.substring(start, end)).matches();
	}

	public void printLexicalCategories() {
		BiConsumer<String, Pattern> print = new BiConsumer<String, Pattern>() {

			@Override
			public void accept(String key, Pattern p) {
				System.out.println(key + "-->" + p.pattern());
			}
		};

		lexicalCategories.forEach(print);
	}
}
