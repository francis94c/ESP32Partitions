package com.espressif.partitions;

import java.io.InputStream;
import java.lang.Runtime;
import java.lang.StringBuilder;

import processing.app.Editor;
import processing.app.tools.Tool;

/**
 * Author: Francis Ilechukwu.
 * Credits: Elochukwu Ifediora C.
 *
 * This is the java wrapper class for the esp-partition.py script. this class is
 * necessary for Arduino IDE to integrate this tool in its tools menu.
 * this is basically a class that implmements the Tools interface which has the
 * necessary functins that the Arduini IDe will call to fully integrate the tool.
 */
public class ESP32Partitions implements Tool {

	// Jsut a reference to the Arduino IDE text/code editor.
	Editor editor;

	/**
	 * [init called on startup of the IDE.]
	 * @param Editor editor [the text/code editor of Arduino IDE.]
	 */
  public void init(Editor editor) {
    this.editor = editor;
  }

	/**
	 * [getMenuTitle the function that is called by Arduino IDE to get the name
	 * with which this tool will appear as in the tools menu.]
	 * @return [String menu name.]
	 */
  public String getMenuTitle() {
    return "ESP32 Partition Manager";
  }

	/**
	 * [run called to start the tool. i.e. when a user clicks or selects the tool
	 * from the tools menu.]
	 */
  public void run() {
		Runtime rt = Runtime.getRuntime();
		try {
			String docsPath = null;
			String OS = System.getProperty("os.name").toLowerCase();
			StringBuilder command = new StringBuilder("reg query \"HKCU\\Software\\");
			if (OS.indexOf("win") >= 0) {
				command.append("Microsoft\\Windows\\CurrentVersion\\Explorer\\");
				command.append("Shell Folders\" /v personal");
				Process p = rt.exec(command.toString());
      	p.waitFor();
      	InputStream in = p.getInputStream();
      	byte[] b = new byte[in.available()];
      	in.read(b);
      	in.close();
      	docsPath = new String(b);
			} else if (OS.indexOf("linux") >= 0) {
				docsPath = System.getenv("HOME");
			}
      docsPath = docsPath.split("\\s\\s+")[4] + "\\";
			command = new StringBuilder("python ").append(docsPath).append("Arduino");
			command.append("\\tools\\ESP32Partitions\\tool\\esp-partition.py");
      Process pr = rt.exec(command.toString());
    } catch (Exception e) {
			e.printStackTrace();
    }
  }

}
