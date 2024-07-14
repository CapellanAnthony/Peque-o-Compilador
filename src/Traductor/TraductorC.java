package Traductor;

import static compilador2doparcial.Interfaz_Gráfica.ruta_j;
import java.io.*;

public class TraductorC {

    public TraductorC() {

    }//CTranslator constructor

    public void CTranslate(String line, File outfile) {

        try {
            PrintWriter writer = new PrintWriter(new FileOutputStream(outfile, true));//, "UTF-8"); // Permite escribir un nuevo archivo
            writer.println(line);                                                                   // Imprime la nueva linea en el nuevo archivo

            writer.close();                                                                         // cierra el nuevo archivo
        } catch (Exception IOException) {
            System.out.println("Some sort of IO error here");
        }//try-catch

    }//CTranslate

    public void addJavaHeader(String name, File outfile) {
        File fichero = new File(ruta_j);

        String fileNameWithoutExtension = fichero.getName().substring(0, fichero.getName().lastIndexOf('.'));
        // System.out.println(fileNameWithoutExtension);

        try {
            PrintWriter writer = new PrintWriter(new FileOutputStream(outfile, true));             // deDeclara un nuevo PrintWriter, también permite escribir un archivo nuevo

            /*
	      Adds java headers
             */
            writer.println("public class " + fileNameWithoutExtension + " {");
            writer.println("    public static void main(String[] args) {");
            writer.println();

            writer.close();
        } catch (Exception IOException) {
            System.out.println("Error");
        }

    }//addJavaHeader

    public void CstringTrans(String line, File outfile) {

        try {
            PrintWriter writer = new PrintWriter(new FileOutputStream(outfile, true));

            String[] printStatement = line.split("<<");
            int lastentry = printStatement.length - 1;
            if (printStatement[lastentry].equals(" endl;")) {
                writer.print("System.out.println(");
                lastentry--;
            } else {
                writer.print("System.out.print(");
            }//if

            for (int i = 1; i < lastentry - 1; i++) {
                writer.print(printStatement[i] + " + ");
            }//for
            if (lastentry > 0) { //retirar ; de la última entrada
                String newline = printStatement[lastentry].replaceAll("\\;", "");
                writer.println(newline + ");");
            } else {
                writer.println(");");
            }//if-else
            
             
             
            writer.close();
        } catch (Exception IOException) {
            System.out.println("Error");
        }

    }//CTranslator

}
