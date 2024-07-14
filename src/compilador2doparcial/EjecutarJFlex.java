package compilador2doparcial;


import jflex.exceptions.SilentExit;


public class EjecutarJFlex {

    public static void main(String omega[]) {
        String lexerFile = System.getProperty("user.dir") + "/src/Lexer.flex",
                lexerFileColor = System.getProperty("user.dir") + "/src/LexerColor.flex";
        try {
            jflex.Main.generate(new String[]{lexerFile, lexerFileColor});
        } catch (SilentExit ex) {
            System.out.println("Error al compilar/generar el archivo flex: " + ex);
        }
    }
}
