/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.adolfosc.controlador;

import com.adolfosc.analizadores.ErrorCom;
import com.adolfosc.analizadores.Lexico;
import com.adolfosc.analizadores.Sintactico;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author adolfosc
 */
public class ControlCargar {

    public String compilar(String texto){
        try {
            List<ErrorCom> errores = new ArrayList<>();
            StringReader reader = new StringReader(texto);
            Lexico lexico = new Lexico(reader);
            Sintactico parser = new Sintactico(lexico);
            try {
                parser.parse();
                errores = parser.getErroresCom();
                if (errores.size() > 0) {
                    String err = "";
                    for (ErrorCom er: errores){
                        err += "error: " + er.getLex() + " tipo " + er.getTipo() + " linea " + er.getLin() +"\n";
                    }
                    return  err;
                }
                return  parser.getResult();
            } catch (Exception ex) {
                System.out.println("Error irrecuperable");
                System.out.println("Causa: " + ex.getCause());
                System.out.println("Causa2: " + ex.toString());
            }
            if (errores.size() > 0) {
                JFReporteErrores jfReporteErrores = new JFReporteErrores(errores);
                jfReporteErrores.setVisible(true);
            } else {
                System.out.println("Compilado Correctamente");
            }
        } catch (Exception e) {

        }
        return "error en la compilación";
    }
}
