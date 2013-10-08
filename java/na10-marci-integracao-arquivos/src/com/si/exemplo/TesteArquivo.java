/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.si.exemplo;

import com.si.entidade.Cliente;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author helio
 */
public class TesteArquivo {
    
    private static String filename = "lista-clientes.csv";
    
    public static void main(String [] args) {
        TesteArquivo teste = new TesteArquivo();
        //List<Cliente> list = teste.loadClientes(filename);
        Cliente cliente = new Cliente();
        List<Cliente> list = teste.loadList(filename, cliente);
        System.out.println(list.size()+" clientes carregados do arquivo "+filename);
        for(Cliente c : list) {
            System.out.println(c.toString());
        }
    }
    
    private List loadList(String filename, Object entidade){
        List res = new ArrayList(); //<--
        FileReader f = null;
        try {
            f = new FileReader(filename);
            BufferedReader reader = new BufferedReader(f);
            String line = reader.readLine();
            while (line!=null) {
                String[] params = line.split("\t");
                res.add(entidade.load(params)); //<--
                line = reader.readLine();
            }
            
        } catch (FileNotFoundException ex) {
            System.out.println("Erro abrindo arquivo "+filename);
            ex.printStackTrace();
        } catch (IOException ex) {
            System.out.println("Erro lendo arquivo "+filename);
            ex.printStackTrace();
        } finally {
            if (f!=null) {
                try {
                    f.close();
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            }
        }
        return res;
    }
    
    private List<Cliente> loadClientes(String filename) {
        List<Cliente> res = new ArrayList<Cliente>(); //<--
        FileReader f = null;
        try {
            f = new FileReader(filename);
            BufferedReader reader = new BufferedReader(f);
            String line = reader.readLine();
            while (line!=null) {
                String[] params = line.split("\t");
                res.add(createCliente(params)); //<--
                line = reader.readLine();
            }
            
        } catch (FileNotFoundException ex) {
            System.out.println("Erro abrindo arquivo "+filename);
            ex.printStackTrace();
        } catch (IOException ex) {
            System.out.println("Erro lendo arquivo "+filename);
            ex.printStackTrace();
        } finally {
            if (f!=null) {
                try {
                    f.close();
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            }
        }
        return res;
    }   
    
}
