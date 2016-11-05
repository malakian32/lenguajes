package com.proyecto.util;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.List;

import org.apache.commons.io.IOUtils;

public class Utils {
	
	public static List<String> readResourceFile(String filePath) {
		List<String> lines = null;
		InputStream in = Utils.class.getClass().getResourceAsStream(filePath);

		try {
			lines = IOUtils.readLines(in, Charset.forName("UTF-8"));
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return lines;
	}

}
