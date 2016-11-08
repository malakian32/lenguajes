package com.proyecto.main;

import java.util.List;

import com.proyecto.entity.Token;
import com.proyecto.services.LexicalAnalizer;
import com.proyecto.util.Utils;

public class Main {

	public static void main(String[] args) {
		List<String> fileLines = Utils.readResourceFile("/config/test-program");

		// for (String string : fileLines) {
		try {
			List<Token> tokens = LexicalAnalizer.getInstance().getTokens(fileLines.get(4));
			System.out.println(tokens.toString());
		} catch (Exception e) {
			e.printStackTrace();
			// }
		}

	}
}
