package com.proyecto.services;

import java.util.List;

import com.proyecto.util.Utils;

public class LexicalAnalizer {

	public static LexicalAnalizer instance;

	public static LexicalAnalizer getInstance() {
		if (instance == null) {
			instance = new LexicalAnalizer();
		}

		return instance;
	}

	public void readPatterns() {
		List<String> fileLines = Utils.readResourceFile("/config/lexical-patterns");

		for (String string : fileLines) {
			System.out.println(string);
		}

	}

}
