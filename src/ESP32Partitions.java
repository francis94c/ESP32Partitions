package com.espressif.partitions;

import java.io.InputStream;
import java.lang.Runtime;
import java.lang.StringBuilder;

import processing.app.Editor;
import processing.app.tools.Tool;

public class ESP32Partitions implements Tool {

	Editor editor;

  public void init(Editor editor) {
    this.editor = editor;
  }

  public String getMenuTitle() {
    return "ESP32 Partition Manager";
  }

  public void run() {
		Runtime rt = Runtime.getRuntime();
		try {
			StringBuilder command = new StringBuilder("reg query \"HKCU\\Software\\");
			command.append("Microsoft\\Windows\\CurrentVersion\\Explorer\\");
			command.append("Shell Folders\" /v personal");
			Process p = rt.exec(command.toString());
      p.waitFor();
      InputStream in = p.getInputStream();
      byte[] b = new byte[in.available()];
      in.read(b);
      in.close();
      String docsPath = new String(b);
      docsPath = docsPath.split("\\s\\s+")[4] + "\\";
      Process pr = rt.exec("python " + docsPath + "Arduino\\tools\\ESP32Partitions\\tool\\esp-partition.py");
    } catch (Exception e) {
			e.printStackTrace();
    }
  }

}
