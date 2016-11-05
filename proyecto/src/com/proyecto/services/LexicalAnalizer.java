package com.proyecto.services;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.nio.charset.Charset;
import java.util.List;

import org.apache.commons.io.IOUtils;

public class LexicalAnalizer {

	public static LexicalAnalizer instance;

	public static LexicalAnalizer getInstance() {
		if (instance == null) {
			instance = new LexicalAnalizer();
		}

		return instance;
	}

	public void readPatterns() {
		List<String> lines;
		List<String> fileLines = readResourceFile("/config/lexical-patterns");
		
		for (String string : fileLines) {
			System.out.println(string);
		}

	}

	private List<String> readResourceFile(String filePath) {
		List<String> lines = null;
		InputStream in = getClass().getResourceAsStream(filePath);

		try {
			lines = IOUtils.readLines(in, Charset.forName("UTF-8"));
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return lines;
	}
}
