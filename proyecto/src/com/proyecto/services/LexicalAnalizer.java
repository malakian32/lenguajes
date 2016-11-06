package com.proyecto.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.BiConsumer;

import com.proyecto.util.Utils;

public class LexicalAnalizer {

	public static LexicalAnalizer instance;
	private Map<String, String> lexicalCategories;

	public LexicalAnalizer() {
		lexicalCategories = new HashMap<String, String>();
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

		for (String line : fileLines) {
			line = line.trim();
			int lastIndexOf = line.lastIndexOf(" ");

			if (lastIndexOf != -1) {
				String regex = line.substring(0, lastIndexOf).trim();
				String lexicalCategory = line.substring(lastIndexOf).trim();
				addLexicalCategory(lexicalCategory, regex);
			} else {
				addLexicalCategory("ignore", line);
			}
		}
	}

	private void addLexicalCategory(String name, String regex) {
		lexicalCategories.put(name, regex);
	}

	public List<String> getTokens(String text) {
		List<String> tokens = new ArrayList<>();
		text.split(regex)
		

		return tokens;
	}

	public void printLexicalCategories() {
		BiConsumer<String, String> action = new BiConsumer<String, String>() {

			@Override
			public void accept(String t, String u) {
				System.out.println(t + "-->" + u);
			}
		};

		lexicalCategories.forEach(action);
	}
}
