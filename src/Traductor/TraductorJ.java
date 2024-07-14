package Traductor;

import java.io.*;

public class TraductorJ {

    public TraductorJ() {

    }

    public void JTranslate(String line, File outfile) {

	try {
	    PrintWriter writer = new PrintWriter(new FileOutputStream(outfile, true));//, "UTF-8"); //permite escribir en un nuevo archivo
	    writer.println(line);  // imprime la línea de código en el nuevo archivo

	    writer.close();  // cierra el archivo nuevo
	} catch (Exception IOException) {
	    System.out.println("Some sort of IO error here");
	}

    }

// Agrega un encabezado C++ al nuevo archivo
    public void addCPPHeader(File outfile) {

	try {
            // declara al escritor como un nuevo PrintWriter, nos permite escribir en un nuevo archivo
	    PrintWriter writer = new PrintWriter(new FileOutputStream(outfile, true)); 

      /*
     Agrega encabezados de C++
      */
	    writer.println("#include <iostream>");
	    writer.println("#include <string>");
	    writer.println("using namespace std;");
	    writer.println("int main() {");

	    writer.close();
	} catch (Exception IOException) {
	    System.out.println("Some sort of IO error here");
	}

    }

    //método que traduce sentencias de impresión de Java a C++
    public void JstringTrans(String line, File outfile) {

	try {
	    PrintWriter writer = new PrintWriter(new FileOutputStream(outfile, true));

	    String[] printStatement = line.split("\\(");  // divide el printStatement después de (
	    char[] systemSt = printStatement[0].toCharArray();//establece la primera parte de split en systemSt
	    char[] printSt = printStatement[1].toCharArray();  // establece la segunda parte de la división en pintereSt
	    int sysLength = systemSt.length; // crea sysLength para obtener la longitud de la primera parte de la división
	    boolean endl = false;  // Establece endl = a falsa

       // si la longitud de systemSt -2 es l y systemSt -1 es n, declara endl como verdadero
	    if (systemSt[sysLength - 2] == 'l' && systemSt[sysLength - 1] == 'n') {
		endl = true;
	    }

	    writer.print("cout <<");// escribr cout << en el nuevo archivo

	    //se repite siempre que i sea menor que la longitud de printSt -2 y lee cada parte de la matriz de caracteres
	    for (int i = 0; i < (printSt.length - 2); i++) {

		if (printSt[i] == '+') {  //si el código encuentra un +, lo reemplazará con <<
		    writer.print("<<");
		} else {                     // de lo contrario, continuará
		    writer.print(printSt[i]);
		}
	    }

	    if (endl) { // si endl es verdadero, el código agregará << endl; hasta el final de la línea.
		writer.print("<< endl");
	    }

	    writer.println(";");


	    writer.close(); //termina con la escritura en un nuevo archivo
	} catch (Exception IOException) {                                                        
	    System.out.println("Some sort of IO error here");
	}
    }
}
