package io.github.crisstanza.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Cris Stanza, 19-Ago-2015
 */
public final class FileSystemUtil {

	private static final char LEFT_DOUBLE_QUOTE = '\u201D';
	private static final char RIGHT_DOUBLE_QUOTE = '\u201C';
	private static final char QUOTE = '"';

	private static final char[][] REPLACEBLES = {
	/* */{ LEFT_DOUBLE_QUOTE, QUOTE },
	/* */{ RIGHT_DOUBLE_QUOTE, QUOTE } //
	};

	private static final Charset CHARSET_UTF8 = Charset.forName("UTF-8");

	private FileSystemUtil() {
	}

	/**
	 * Converte cada um dos arquivos descritos, um em cada linha, na primeira posi&ccedil;&atilde;o do argumento
	 * <code>args</code> para o charset UTF-8.
	 * 
	 * @param args
	 *            Array de apenas 1 posi&ccedil;&atilde;o, contendo um caminho de arquivo v&aacute;lido. Cada linha deste
	 *            arquivo deve corresponder a um caminho de arquivo tamb&eacute;m v&aacute;lido.
	 */
	public static final void main(final String[] args) {
		List<String> lines = FileSystemUtil.readLines(new File(args[0]));
		for (String line : lines) {
			fixCharSet(new File(line));
		}
	}

	private static void fixCharSet(File file) {
		FileSystemUtil.write(file, fixQuotes(FileSystemUtil.readContents(file)), CHARSET_UTF8);
	}

	private static String fixQuotes(String str) {
		final int length = REPLACEBLES.length;
		for (int i = 0; i < length; i++) {
			char[] replacement = REPLACEBLES[i];
			str = str.replace(replacement[0], replacement[1]);
		}
		return str;
	}

	public static final String readContents(File path) {
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new FileReader(path));
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = reader.readLine()) != null) {
				sb.append(line).append(System.lineSeparator());
			}
			return sb.toString();
		} catch (IOException exc) {
			RuntimeException re = new RuntimeException(exc);
			re.setStackTrace(exc.getStackTrace());
			throw re;
		} finally {
			Closer.close(reader);
		}
	}

	public static final List<String> readLines(File path) {
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new FileReader(path));
			List<String> lines = new ArrayList<>();
			String line;
			while ((line = reader.readLine()) != null) {
				lines.add(line);
			}
			return lines;
		} catch (IOException exc) {
			RuntimeException re = new RuntimeException(exc);
			re.setStackTrace(exc.getStackTrace());
			throw re;
		} finally {
			Closer.close(reader);
		}
	}

	public static void write(File path, String contents, Charset charset) {
		BufferedWriter writer = null;
		try {
			writer = new BufferedWriter(new FileWriter(path));
			writer.write(new String(contents.getBytes(charset)));
		} catch (IOException exc) {
			RuntimeException re = new RuntimeException(exc);
			re.setStackTrace(exc.getStackTrace());
			throw re;
		} finally {
			Closer.close(writer);
		}
	}

}
